import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_data/user_provider.dart';
import 'package:intl/intl.dart';

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
           appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 9, 26, 47),
            title: const Text('My Information'),),
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
                title: Center(
                  child: Text(data['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white
                ),), 
                ),
                subtitle: Column(
                  children: <Widget>[
                    SizedBox(height: 10,),
                    Text('Email', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['email'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Grade Level', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['grade'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Section', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['section'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Address', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['address'], style: TextStyle(
                      color: Colors.white
                    ), ),
                     SizedBox(height: 10,),
                    Text('Contact Number', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['contact'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Gender', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['gender'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Birthday', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['birthday'], style: TextStyle(
                      color: Colors.white
                    ), ),
                    SizedBox(height: 10,),
                    Text('Mother Tongue', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['MT'], style: TextStyle(
                      color: Colors.white
                    ), ),
                      SizedBox(height: 10,),
                    Text('Religion', style: TextStyle(color: Color.fromARGB(255, 251, 183, 24), fontWeight: FontWeight.bold ),),
                    Text(data['religion'], style: TextStyle(
                      color: Colors.white
                    ), ),

                    
                  ],
                ),
                 trailing: IconButton(
                  icon: Icon(Icons.edit),
                   onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return EditTeacherScreen(documentId: documentId);
                          }));
                          
                          
                          
                        },
                )
              );
            },
          );
        },
      ),
       );
  }
}



class EditTeacherScreen extends StatefulWidget {
  final TextEditingController _controller = TextEditingController();
  final String documentId;

  EditTeacherScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _EditTeacherScreenState createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  
   DateTime? _selectedDate;


  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _subjectController = TextEditingController();
  final _emailController = TextEditingController();
   final _addressController = TextEditingController();
  final _contactController = TextEditingController();
   final _genderController = TextEditingController();
  final _BirthdayController = TextEditingController();
        final _GradeController = TextEditingController();
        final _MTController = TextEditingController();
        final _ReligionController = TextEditingController();





  late String _initialName;
  late String _initialSubject;
  late String _initialEmail;
  late String _initialAddress;


 late String _initialContact;
  late String _initialGender;
  late String _initialBirthday;
  late String _initialGrade;
  late String _initialMT;
  late String _initialReligion;

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
        _emailController.text = data['email'];
        _GradeController.text = data['grade'];
        _subjectController.text = data['section'];
        _addressController.text = data['address'];
        _contactController.text = data['contact'];
        _genderController.text = data['gender'];
        _BirthdayController.text = data['birthday'];
        _MTController.text = data['MT'];
        _ReligionController.text = data['religion'];




        _initialName = data['name'];
        _initialAddress = data['address'];
        _initialContact = data['contact'];
        _initialGender = data['gender'];
        _initialBirthday = data['birthday'];
        _initialMT = data['MT'];
        _initialReligion = data ['religion'];

        
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (picked != null && picked != _selectedDate) {
    setState(() {
      _selectedDate = picked;
      DateTime truncatedDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
        0,
        0,
        0,
        0,
        0,
      );
      String formattedDateString =
          DateFormat('dd/MM/yyyy').format(truncatedDate);
      _BirthdayController.text = formattedDateString;
    });
  }
}

  Future<void> _updateTeacher() async {
    if (_formKey.currentState!.validate()) {
      try {
        String newName = _nameController.text;
        String newAddress = _addressController.text;
        String newContact = _contactController.text;
        String newGender = _genderController.text;
        
        String newMT = _MTController.text;
        String newReligion = _ReligionController.text;
        String newBirthday = _BirthdayController.text;


        // Only update the fields that have changed
        if (newName != _initialName || newAddress != _initialAddress || newContact != _initialContact || newGender != _initialGender
        || newBirthday != _initialBirthday || newMT != _initialMT || newReligion != _initialReligion) {
          await FirebaseFirestore.instance
              .collection('teachers')
              .doc(widget.documentId)
              .update({
            if (newName != _initialName) 'name': newName,
            if (newAddress != _initialAddress) 'address': newAddress,
            if (newContact != _initialContact) 'contact': newContact,
            if (newGender != _initialGender) 'gender': newGender,
            if (newBirthday != _initialBirthday) 'birthday': newBirthday,
            if (newMT != _initialMT) 'MT': newMT,
            if (newReligion != _initialReligion) 'religion': newReligion,
            
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
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text('Edit Information'),
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
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _emailController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Email',
                ),
                
              ),
              
               TextFormField(
                enabled: false,
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _GradeController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Grade Level',
                ),
                
              ),
              TextFormField(
                enabled: false,
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
                
              ),
               TextFormField(
               
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _addressController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Address',
                ),
               
              ),
                TextFormField(
               
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _contactController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Contact Number',
                ),
               
              ),
                TextFormField(
               
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _genderController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Gender',
                ),
                
              ),
                
               TextFormField(
                    style: TextStyle(
                      color: Colors.white
                    ),
                  controller: _BirthdayController,
                  decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'DD/MM/YYYY',
                ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  keyboardType: TextInputType.datetime,
                ),
                TextFormField(
               
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _MTController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'MT',
                ),
               
              ),
                TextFormField(
               
                style: TextStyle(
                  color: Colors.white
                ),
                controller: _ReligionController,
                decoration: InputDecoration(
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 251, 183, 24)
                  ),
                  labelText: 'Religion',
                ),
               
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _updateTeacher();
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Color.fromARGB(255, 23, 133, 60), // set the background color
                    content: Text('Successfully Updated'), // set the message text
                    duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                  ),
                  );
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}