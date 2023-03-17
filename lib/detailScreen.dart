

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_data/homeScreen.dart';
import 'user_provider.dart';


class DetailScreen extends StatelessWidget {
  
  final Map < String, dynamic > data;

  const DetailScreen({
    required this.data
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
      body: Container(
        child: Center(
          child: Stack(
          children: < Widget > [
            Column(
              children: [
                Padding(padding: EdgeInsets.all(20),
                  child: Container(
                    child: Image(image: NetworkImage(data['logo']), )
                  ),
                ),
                Padding(padding: EdgeInsets.all(20),
                  child: Text(data['description'], style: TextStyle(
                    color: Colors.white
                  ),)
                ),
                SizedBox(height: 20),
                Container(
                      width: 340,
                      height: 60,
                      child: TextButton(
                        onPressed: () async {
                          QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('students').where('email', isEqualTo: email).get();
                          querySnapshot.docs.forEach((doc) async {
                          await doc.reference.collection('affiliations').add({
                            'club': data['name'],                           
                          });
                        });   

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 27, 100, 25), // set the background color
                              content: Text('Successfully Joined'), // set the message text
                              duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                            ),
                          ); 


                           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return FirestoreDataScreen();
                          }));

                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll < Color > (Color.fromARGB(255, 251, 183, 24)),
                          shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),

                            )
                          )
                        ),
                        child: Text(
                          'Join Club',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Noopla"
                          ),

                        ),
                      ),
                    ), 
                
              ],
            )
          ],
        ),
        )
        
        
        
      )
    );
  }
}