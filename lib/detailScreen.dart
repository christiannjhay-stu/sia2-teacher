

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
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
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
                                 Text('Filipino         '+ data['Filipino1'] +'         '+ data['Filipino2']+'         '+ data['Filipino3']+'         '+ data['Filipino4'],
                                 style: TextStyle(
                                  color: Color.fromARGB(246, 255, 208, 0)
                                 ),),
                              ],
                            )
                            
                          ],
                        ),
                      ),
                      new IconButton(
                        icon: Icon(Icons.delete,
                        color: Colors.red,),
                        onPressed: () {
                          document.reference.delete();
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return FirestoreDataScreen();
                          }));


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