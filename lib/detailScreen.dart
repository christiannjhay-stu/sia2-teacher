

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_data/homeScreen.dart';
import 'user_provider.dart';


class DetailScreen extends StatelessWidget {
   
  final Map < String, dynamic > data;
  late String docID;
  DetailScreen({Key? key, required this.data, required this.docID,  String documentId = '', 
      
  });
  
  
  
  @override
  Widget build(BuildContext context) {
     
    String? email = FirebaseAuth.instance.currentUser?.email;
    context.read<UserProvider>().setEmail(email!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text(data['name']),
      ),
      body:Center(
        child: Stack(
          children: <Widget>[
            Row(
              children: [
                Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 115),
              child: Text(
                '1ST',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
                 Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 45),
              child: Text(
                '2ND',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
                 Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 40),
              child: Text(
                '3RD',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
                 Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 40),
              child: Text(
                '4TH',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
                 Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20, left: 50),
              child: Text(
                'REMARKS',
                style: TextStyle(color: Colors.white),
                    
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            Padding(padding: EdgeInsets.only(top: 40, bottom: 20),
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('students')
            .where('name', isEqualTo: data['name'])
            .snapshots()
            .asyncMap((QuerySnapshot<Map<String, dynamic>> query) async {
          return await query.docs.first.reference
              .collection('affiliations')
              .get();
        }),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
             children: snapshot.data!.docs.map((DocumentSnapshot document) {
              String documentID = document.id;
             
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
                  String Subject = data['name'];
              return new Card(
                color: Color.fromARGB(255, 9, 26, 47).withOpacity(0.2),
                child: new Padding(
                  padding: const EdgeInsets.all(15),
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                           

                            Row(
                             children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      Subject,
                                      style: TextStyle(
                                        color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      data['Grade1'],
                                      style: TextStyle(
                                        color: Color.fromARGB(246, 255, 208, 0)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      data['Grade2'],
                                      style: TextStyle(
                                        color: Color.fromARGB(246, 255, 208, 0)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      data['Grade3'],
                                      style: TextStyle(
                                        color: Color.fromARGB(246, 255, 208, 0)
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      data['Grade4'],
                                      style: TextStyle(
                                        color: Color.fromARGB(246, 255, 208, 0)
                                      ),
                                    ),
                                  ),
                                   new IconButton(
                                    icon: Icon(Icons.edit,
                                    color: Colors.red,),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                        return EditTeacherPage(documentID: documentID, docID: docID  );
                                      }));
                                      
                                    },
                                  ),      
                                ],
                              )
                             ],
                            ),
                            
                            
                          ],
                        ),
                      ),
                     
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
            
            
            )
          ],
        ),
      )
      
      
      
    );
  }
}

class EditTeacherPage extends StatefulWidget {


  final String documentID;
  late String docID;
  

  EditTeacherPage({

     
    required this.documentID,
    required this.docID
    

    });

  @override
  _EditTeacherPageState createState() => _EditTeacherPageState();
}

class _EditTeacherPageState extends State<EditTeacherPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController FirstQuarterController =  TextEditingController();
   final TextEditingController SecondQuarterController =  TextEditingController();
    final TextEditingController ThirdQuarterController =  TextEditingController();
   final TextEditingController FourthQuarterController =  TextEditingController();
     
     

  @override
  void dispose() {
    FirstQuarterController.dispose();
    SecondQuarterController.dispose();
    ThirdQuarterController.dispose();
    FourthQuarterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('Edit Grade'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: FirstQuarterController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.white
                  ),
                  labelText: '1ST QUARTER',
                  
                ),
                style: TextStyle(color: Colors.white),
              ),
              TextField(
                controller: SecondQuarterController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.white
                  ),
                  labelText: '2ND QUARTER',
                  
                ),
                style: TextStyle(color: Colors.white),
              ),
              TextField(
                controller: ThirdQuarterController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.white
                  ),
                  labelText: '3RD QUARTER',
                  
                ),
                style: TextStyle(color: Colors.white),
              ),
              TextField(
                controller: FourthQuarterController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Colors.white
                  ),
                  labelText: '4TH QUARTER',
                  
                ),
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final String FirstQuarter = FirstQuarterController.text;
                  final String SecondQuarter = SecondQuarterController.text;
                   final String ThirdQuarter = ThirdQuarterController.text;
                  final String FourthQuarter = FourthQuarterController.text;

                   // Get a reference to the student document
                  DocumentReference studentDocRef = FirebaseFirestore.instance.collection('students').doc(widget.docID);

                  // Get a reference to the grades subcollection for the student
                  CollectionReference gradesCollRef = studentDocRef.collection('affiliations');

                  // Get a reference to the specific document within the grades subcollection that you want to update
                  DocumentReference gradeDocRef = gradesCollRef.doc(widget.documentID);
                  
                  
                  // Update the document data for the specific document
                  gradeDocRef.update({
                   'Grade1' :  FirstQuarter,
                   'Grade2' :  SecondQuarter,
                   'Grade3' :  ThirdQuarter,
                   'Grade4' :  FourthQuarter
                  }).then((value) {
                    print('Subcollection updated successfully!');
                  }).catchError((error) {
                    print('Error updating subcollection: $error');
                  });

                  print('working9999'+ widget.documentID);
                 
                  ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 28, 117, 1), // set the background color
                              content: Text('Grades Updated'), // set the message text
                              duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                            ),
                          ); 
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return FirestoreDataScreen();
                          }));
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}