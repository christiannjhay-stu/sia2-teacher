

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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                                 Text(Subject + '     ' + data['Grade1'] +'         '+ data['Grade2']+'         '+ data['Grade3']+'         '+ data['Grade4'],
                                 style: TextStyle(
                                  color: Color.fromARGB(246, 255, 208, 0)
                                 ),),
                              ],
                            ),
                            
                            
                          ],
                        ),
                      ),
                      new IconButton(
                        icon: Icon(Icons.edit,
                        color: Colors.red,),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return EditTeacherPage(documentID: documentID, docID: docID  );
                          }));
                          
                          /*Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return FirestoreDataScreen();
                          }));*/


                           ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 255, 0, 0), // set the background color
                              content: Text('Leave'), // set the message text
                              duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                            ),
                          ); 
                          
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),  
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