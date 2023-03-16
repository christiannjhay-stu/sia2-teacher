import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AffiliationsList extends StatelessWidget {
  final String userEmail;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AffiliationsList({required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('students').where('email', isEqualTo: 'cej@gmail.com') .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        else(
          print('no data')
        );
        List<dynamic> affiliations = snapshot.data!.docs[0]['affiliations'];
        return ListView.builder(
          itemCount: affiliations.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(affiliations[index]['club']),
                
              ),
            );
          },
        );
      },
    );
  }
}