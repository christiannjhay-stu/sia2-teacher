import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_data/user_provider.dart';

class Information extends StatefulWidget {

  const Information({ Key? key }) : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {

   @override
   Widget build(BuildContext context) {
    String? email = FirebaseAuth.instance.currentUser?.email;
    context.read<UserProvider>().setEmail(email!);
       return Scaffold(
           appBar: AppBar(title: const Text('My Information'),),
           body: StreamBuilder<QuerySnapshot>(
            
        stream: FirebaseFirestore.instance
            .collection('teachers')
            .where('email', isEqualTo: email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              String documentId = document.id;
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
             
              return ListTile(
                title: Text(data['name'],
                style: TextStyle(
                  color: Colors.white
                ),),
                subtitle: Text(data['section'],style: TextStyle(
                  color: Colors.white
                ),),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                   onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return EditTeacherScreen(documentId: documentId);
                          }));
                          
                          
                          
                        },
                ),
                
              );
            },
          );
        },
      ),
       );
  }
}



class EditTeacherScreen extends StatefulWidget {
  final String documentId;

  EditTeacherScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _EditTeacherScreenState createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  late String _initialName;
  late String _initialSubject;

  @override
  void initState() {
    super.initState();
    // Retrieve the current teacher data and populate the text fields
    FirebaseFirestore.instance
        .collection('teachers')
        .doc(widget.documentId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        _nameController.text = data['name'];
        _subjectController.text = data['section'];
        _initialName = data['name'];
        _initialSubject = data['section'];
      }
    });
  }

  Future<void> _updateTeacher() async {
    if (_formKey.currentState!.validate()) {
      try {
        String newName = _nameController.text;
        String newSubject = _subjectController.text;
        // Only update the fields that have changed
        if (newName != _initialName || newSubject != _initialSubject) {
          await FirebaseFirestore.instance
              .collection('teachers')
              .doc(widget.documentId)
              .update({
            if (newName != _initialName) 'name': newName,
            if (newSubject != _initialSubject) 'section': newSubject,
          });
        }
        Navigator.pop(context); // Navigate back to the previous screen
      } catch (e) {
        print('Error updating teacher: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Teacher'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _nameController,
                decoration: InputDecoration(
                  
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Name',
                  hintStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _subjectController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Section',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateTeacher,
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}