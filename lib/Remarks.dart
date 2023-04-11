import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({Key? key, required this.studID}) : super(key: key);

  final String studID;
  
  @override
  _AddSubjectScreenState createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _lockStream;

  String remarksValue = '';

  @override
  void initState() {
    super.initState();
    _lockStream = FirebaseFirestore.instance
        .collection('lock')
        .doc('N3P3FO3eYiLe54mJ7MKf')
        .snapshots();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Color.fromARGB(255, 9, 26, 47),
      title: Text('Final Remarks'),
    ),
    body: Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                'Antonio Pichon Jr.\nElementary School\nFinal Remarks',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Ateneo",
                ),
              ),
            ),
            SizedBox(height: 25),
            Center(
                child: Image.asset(
              'assets/images/adduLogo.png',
              width: 200,
              height: 200,
            )),
            SizedBox(height: 20),
            StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: _lockStream,
              builder: (context, snapshot) {
                bool isLocked = false;
                if (snapshot.hasData) {
                  Map<String, dynamic>? data = snapshot.data!.data();
                  if (data != null) {
                    isLocked = data['data6'] == false;
                  }
                }
                return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: firestore.collection('students').doc(widget.studID).get(),
                  builder: (context, snapshot) {
                    String? currentRemarks;
                    if (snapshot.hasData) {
                      Map<String, dynamic>? data = snapshot.data!.data();
                      if (data != null) {
                        currentRemarks = data['remarks'];
                      }
                    }
                    return AbsorbPointer(
                      absorbing: isLocked,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: 340,
                        height: 90,
                        child: DropdownButtonFormField(
                          items: [
                            DropdownMenuItem(
                              value: '',
                              child: Text(''),
                            ),
                            DropdownMenuItem(
                              value: 'Passed',
                              child: Text(
                                'Passed',
                                style: TextStyle(
                                    color: Color.fromARGB(246, 255, 208, 0)),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Retained',
                              child: Text(
                                'Retained',
                                style: TextStyle(
                                    color: Color.fromARGB(246, 255, 208, 0)),
                              ),
                            ),
                          ],
                          value: currentRemarks ?? '',
                          onChanged: isLocked
                              ? null
                              : (value) {
                                  setState(() {
                                    remarksValue = value.toString();
                                    String docId = widget.studID;
                                    firestore
                                        .collection('students')
                                        .doc(docId)
                                        .update({
                                      'remarks': remarksValue,
                                    });
                                    print(widget.studID);
                                  });
                                },
                          decoration: InputDecoration(
                              labelText: 'Remarks',
                              labelStyle: TextStyle(color: Colors.white)),
                          dropdownColor: Colors.grey[800],
                        ),
                      ),
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    ),
  );
}

}

