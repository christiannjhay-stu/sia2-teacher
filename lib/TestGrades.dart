import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String studentId;

  const MyHomePage({Key? key, required this.studentId}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _selectedYear;

  @override
  void initState() {
    super.initState();
    _selectedYear = '2023'; // set default value for dropdown
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> subjectsRef =
        FirebaseFirestore.instance
            .collection('students')
            .doc(widget.studentId)
            .collection('Subjects')
            .where('Year', isEqualTo: _selectedYear);

    return Scaffold(
      appBar: AppBar(
        title: Text('Grades'),
      ),
      body: Column(
        
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10,left: 20),
            child: Row(
              children: <Widget>[
                Container(
                    child: Text('Year'),
                ),
                 DropdownButton<String>(
                  value: _selectedYear,
                  items: <String>['2023', '2024', '2025', '2026']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                      style: TextStyle(
                        color: Colors.amberAccent
                      ),),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedYear = newValue!;
                    });
                  },
                ),
                
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
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subjectDoc['name'],
                              style: TextStyle(fontSize: 18),
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
                             Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                                ],)
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList1.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                                ],)
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList2.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                                ],)
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Stack(
                                  children: <Widget>[
                                    SizedBox(height: 5),
                              ...gradesList3.map(
                                (grade) => Text(
                                  grade,
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                                ],)
                              ),
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