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
  
  String remarksValue = '';

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
              Container(
                padding: EdgeInsets.all(15),
                width: 340,
                height: 90,
                child: AbsorbPointer(
                  absorbing: false,
                  child: DropdownButtonFormField(
                    items: [
                      DropdownMenuItem(
                        value: '',
                        child: Text(''),
                      ),
                      DropdownMenuItem(
                        value: 'Passed',
                        child: Text('Passed'),
                      ),
                      DropdownMenuItem(
                        value: 'Retained',
                        child: Text('Retained'),
                      ),
                    ],
                    value: remarksValue,
                    onChanged: (value) {
                      setState(() {
                        remarksValue = value.toString();
                        String docId = widget.studID;
                        firestore.collection('students').doc(docId).update({
                          'remarks': remarksValue,
                        });
                        print(widget.studID);
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Remarks',
                        labelStyle: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
