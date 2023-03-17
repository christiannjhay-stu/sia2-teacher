
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:read_data/user_provider.dart';


class MyWidget extends StatefulWidget {

   String email;

   MyWidget({required this.email});

  @override

  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  final CollectionReference clubsRef = FirebaseFirestore.instance.collection('students');
  late Stream<QuerySnapshot<Map<String, dynamic>>> _membersStream;

  @override
  void initState() {
    super.initState();
    _membersStream = clubsRef.doc('Test').collection('affiliations').snapshots();
    
  }

  @override
  Widget build(BuildContext context) {
     String? email = FirebaseAuth.instance.currentUser?.email;
    context.read<UserProvider>().setEmail(email!);
    return Scaffold(
      appBar: AppBar(
        title: Text('Affiliations'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _membersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot<Map<String, dynamic>> documentSnapshot = snapshot.data!.docs[index];
              Map<String, dynamic> data = documentSnapshot.data()!;
              return Card(
                child: ListTile(
                  title: Text(data['club']),
                  subtitle: Text(email),
                  
                ),
              );
            },
          );
        },
      ),
    );
  }
}
