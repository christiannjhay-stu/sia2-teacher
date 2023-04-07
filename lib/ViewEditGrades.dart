

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:read_data/homeScreen.dart';

class MyHomePage extends StatefulWidget {
  final String studentId;

  const MyHomePage({Key? key, required this.studentId}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    String year = '';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('schoolyear')
          .doc('SchoolYear')
          .get();
      final String year = documentSnapshot.get('yearStarted');
      setState(() {
        this.year = year;
      });
    } catch (e) {
      print('Error retrieving data: $e');
    }
  } 
  
  
  @override
  Widget build(BuildContext context) {
    
  
    Query<Map<String, dynamic>> 
    
    subjectsRef =
        FirebaseFirestore.instance
            .collection('students')
            .doc(widget.studentId)
            .collection('Subjects')
            .where('Year', isEqualTo: year);
            
    return Scaffold(
      appBar: AppBar(
        title: Text('Grades'),
      ),
      body: Column(
        
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10,left: 100, bottom: 10),
            child: Row(
              children: <Widget>[
                SizedBox(width: 37,),
                Container(
                  child: Text('1ST', style: TextStyle(color: Colors.white),),
                ),
                   SizedBox(width: 37,),
                Container(
                  child: Text('2ND',style: TextStyle(color: Colors.white)),
                ),
                 SizedBox(width: 37,),
                Container(
                  child: Text('3RD',style: TextStyle(color: Colors.white)),
                ),
                 SizedBox(width: 37,),
                    Container(
                  child: Text('4TH', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 37,),
                Container(
                  child: Text('FINAL',style: TextStyle(color: Colors.white)),
                )

              ],
              
            ),
            
            
          ),
          
          
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: subjectsRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Text('No subjects found for this student.');
                }
                
                

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Map<String, dynamic>> subjectDoc =
                        snapshot.data!.docs[index];
                      
                       
                    return Card(
                      shape: Border.all(width: 1),
                      color: Color.fromARGB(255, 36, 59, 78),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              child: Text(
                              subjectDoc['name'],
                              
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            ),
                            
                            
                            SizedBox(height: 10),
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: subjectDoc.reference
                                  .collection('Grades')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                      gradesSnapshot) {
                                if (gradesSnapshot.hasError) {
                                  return Text('Error: ${gradesSnapshot.error}');
                                }

                                if (gradesSnapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text('Loading...');
                                }

                                if (gradesSnapshot.data == null ||
                                    gradesSnapshot.data!.docs.isEmpty) {
                                  return Text('No grades found for this subject.');
                                }
                          String subjectName = subjectDoc['name'] as String;
                          List<String> gradesList = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade1'] as String,
                                  )
                              .toList();

                               List<String> gradesList1 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade2'] as String,
                                  )
                              .toList();
                                List<String> gradesList2 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade3'] as String,
                                  )
                              .toList();
                                List<String> gradesList3 = gradesSnapshot.data!.docs
                              .map((QueryDocumentSnapshot<Map<String, dynamic>> gradeDoc) =>
                                  gradeDoc['Grade4'] as String,
                                  )
                              .toList();

                          
                          return Row(
                            
                            crossAxisAlignment: CrossAxisAlignment.start,
                            
                            children: [
                             SizedBox(width: 20,),
                             Container(
                             
                               width: 30,
                               
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                                ],)
                              ),
                                  SizedBox(width: 30,),
                              Container(
                             
                                 width: 30,
                               
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList1.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                                ],)
                              ),
                                 SizedBox(width: 35,),
                              Container(
                            
                               width: 30,
                                
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList2.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                                ],)
                              ),
                                SizedBox(width: 35,),
                              Container(
                             
                                 width: 30,
                              
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList3.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                              ),
                                ],)
                              ),
                              SizedBox(width: 70,),
                              Container(
                                width: 50,
                                child: SizedBox(
                                
                                height: 15,
                                child: IconButton(
                                    icon: Icon(Icons.edit,
                                    size: 15,
                                    color: Colors.red,),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                        return EditTeacherPage(documentID: widget.studentId, SubjectName: subjectName );
                                      }));
                                      
                                    },
                                ),
                              )
                              )
                               
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
          )]
    ));
  }
}



class EditTeacherPage extends StatefulWidget {


  final String documentID;
  late String SubjectName;
  

  EditTeacherPage({

     
    required this.documentID,
    required this.SubjectName
    

    });


    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> updateGrade(String studentId, String subjectName, int year, double newGrade) async {
      
    }


  @override
  _EditTeacherPageState createState() => _EditTeacherPageState();
}

class _EditTeacherPageState extends State<EditTeacherPage> {
  late bool _lockValue1 = false; // default value
  late bool _lockValue2 = false; // default value
 late bool _lockValue3 = false; // default value
  late bool _lockValue4 =false; // default value
  
    String year = '';

      @override
      void initState() {
        super.initState();


         // fetch the lock value from Firestore and update _lockValue
          FirebaseFirestore.instance.collection('lock').doc('N3P3FO3eYiLe54mJ7MKf').get().then((docSnapshot) {
            setState(() {
              _lockValue1 = docSnapshot.get('data1'); // assuming 'data1' is the field name
            });
          });

          // fetch the lock value from Firestore and update _lockValue
          FirebaseFirestore.instance.collection('lock').doc('N3P3FO3eYiLe54mJ7MKf').get().then((docSnapshot) {
            setState(() {
              _lockValue2 = docSnapshot.get('data2'); // assuming 'data1' is the field name
            });
          });

          // fetch the lock value from Firestore and update _lockValue
          FirebaseFirestore.instance.collection('lock').doc('N3P3FO3eYiLe54mJ7MKf').get().then((docSnapshot) {
            setState(() {
              _lockValue3 = docSnapshot.get('data3'); // assuming 'data1' is the field name
            });
          });

          // fetch the lock value from Firestore and update _lockValue
          FirebaseFirestore.instance.collection('lock').doc('N3P3FO3eYiLe54mJ7MKf').get().then((docSnapshot) {
            setState(() {
              _lockValue4 = docSnapshot.get('data4'); // assuming 'data1' is the field name
            });
          });










        _getData();
      }

      Future<void> _getData() async {
        try {
          final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
              .collection('schoolyear')
              .doc('SchoolYear')
              .get();
          final String year = documentSnapshot.get('yearStarted');
          setState(() {
            this.year = year;
          });
        } catch (e) {
          print('Error retrieving data: $e');
        }
      } 
      











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
                enabled: _lockValue1 == true, // enable/disable based on lock value
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
                 enabled: _lockValue2 == true, // enable/disable based on lock value
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
                 enabled: _lockValue3 == true, // enable/disable based on lock value
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
                 enabled: _lockValue4 == true, // enable/disable based on lock value
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


                      
                
                      
                     
                                              try {
                          // Filter the subjects by year and name
                          QuerySnapshot subjectSnapshot = await FirebaseFirestore.instance
                              .collection('students')
                              .doc(widget.documentID)
                              .collection('Subjects')
                              .where('Year', isEqualTo: year)
                              .where('name', isEqualTo: widget.SubjectName)
                              .get();

                          if (subjectSnapshot.docs.isEmpty) {
                            print('Subject not found!');
                            return;
                          }

                          // Get the reference to the grades collection for the first matching subject
                          DocumentReference subjectDocRef = subjectSnapshot.docs.first.reference;
                          CollectionReference gradesColRef = subjectDocRef.collection('Grades');

                          // Filter the grades by year
                          QuerySnapshot gradesSnapshot =
                              await gradesColRef.where('Year', isEqualTo: year).get();

                          if (gradesSnapshot.docs.isEmpty) {
                            print('No grades found for the given year!');
                            return;
                          }

                          // Update the first grade document
                          DocumentReference gradeDocRef = gradesSnapshot.docs.first.reference;
                          await gradeDocRef.update({
                            'Grade1': FirstQuarter,
                            'Grade2': SecondQuarter,
                            'Grade3': ThirdQuarter,
                            'Grade4': FourthQuarter
                            
                            
                            
                            });

                          print('Grade updated!');
                        } catch (e) {
                          print('Error updating grade: $e');
                        }
                                

                  


                  
                 
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