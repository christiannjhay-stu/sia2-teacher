

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:read_data/Announcement.dart';
import 'package:read_data/ViewEditGrades.dart';
import 'package:read_data/affiliations.dart';

import 'package:read_data/information.dart';
import 'package:read_data/loginScreen.dart';
import 'package:read_data/user_provider.dart';

class FirestoreDataScreen extends StatefulWidget {
  @override
  FirestoreDataScreenState createState() => FirestoreDataScreenState();
}

class FirestoreDataScreenState extends State<FirestoreDataScreen> {
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final FirebaseAuth _auth = FirebaseAuth.instance;
    


  String section = '';
  

  @override
  void initState() {
    super.initState();
    getTeacherData();
  }


 

 Future<void> getTeacherData() async {
    final currentUser = _auth.currentUser;

    final QuerySnapshot querySnapshot = await _firestore
        .collection('teachers')
        .where('email', isEqualTo: currentUser?.email)
        .get();
    
    

    if (querySnapshot.docs.isNotEmpty) {
      final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
     
      setState(() {
        section = documentSnapshot.get('section');
       
      });
    } else {
      // Handle the case where the query does not return any documents
    }
  }

  @override
  Widget build(BuildContext context) {

   
   
    
    String? email = FirebaseAuth.instance.currentUser?.email;
    context.read<UserProvider>().setEmail(email!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('List of Students'),
      ),
      body: StreamBuilder<QuerySnapshot>(
         stream: FirebaseFirestore.instance.collection('students').where('section', isEqualTo: section).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          if (documents == null || documents.isEmpty) {
          
            return Center(child: Text('No data found'));
          }
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final docId = documents[index].id;
              String docIdt = docId;
              final data = documents[index].data();
              if (data == null) {
                return SizedBox();
              }
              
              final mapData = data as Map<String, dynamic>;
              
              Stack(

              );
              return GestureDetector(
                onTap: () {
                 
                  print('working' + docId);
                  Navigator.push(
                    
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(studentId: docId),

                    ),
                  );
                },
                child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                borderOnForeground: true,
                
                color: Color.fromARGB(255, 9, 26, 47).withOpacity(0.2),
                  child: ListTile(
                  leading: CircleAvatar(
                  radius: 30,
                  
                ),
                  title: Text(mapData['name'] ?? '',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(''),
                      Text(mapData['email'] ?? '',
                  style: TextStyle(
                    color: Colors.white
                  ),),
                      Text(''),
                      Text(mapData['username'] ?? '',
                  style: TextStyle(
                    color: Color.fromARGB(246, 255, 208, 0)
                  ),),
                      
                    ],
                  ) 
                ),
                )
              );
              
            },
          );
        },
      ),
      
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          children: [

            SizedBox(height: 20),
             ListTileTheme(
              child: ListTile(
                
                leading: Icon(Icons.contact_mail),
                title: Text('${context.watch<UserProvider>().email}'),
                  onTap: () {

                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 30),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.home),
                title: const Text('Home'),
                  onTap: () {

                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 4),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.work),
                title: const Text('Announcements'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return Announcements();
                          }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 4),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.document_scanner),
                title: const Text('My Information'),
                  onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return Information();
                          }));
                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            SizedBox(height: 520),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.settings),
                title: const Text('Settings'),
                  onTap: () {

                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
            
            SizedBox(height: 4),
            ListTileTheme(
              child: ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color.fromARGB(255, 251, 183, 24)),
                  borderRadius: BorderRadius.circular(20),
                ),
                leading: Icon(Icons.logout),
                title: const Text('Log out'),
                  onTap: () {

                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext) {
                      return LoginScreen();
                    }));


                     ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Color.fromARGB(255, 255, 0, 0), // set the background color
                        content: Text('Logged out'), // set the message text
                        duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                      ),
                    );


                  },
                  textColor: Colors.white,
                  iconColor: Colors.white,
              )
            ),
          ],
        ),
      ),
     
    );
  }
}

class EditTeacherPage extends StatefulWidget {


  final String documentID;

  EditTeacherPage({required this.documentID});

  @override
  _EditTeacherPageState createState() => _EditTeacherPageState();
}

class _EditTeacherPageState extends State<EditTeacherPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _teacherNameController =
      TextEditingController();

  @override
  void dispose() {
    _teacherNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _teacherNameController,
                decoration: InputDecoration(
                  labelText: 'Teacher Name',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final String teacherName = _teacherNameController.text;
                  print('working9999'+ widget.documentID);
                  await _firestore
                      .collection('students')
                      .doc(widget.documentID)
                      .update({'name': teacherName});

                  Navigator.pop(context);
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