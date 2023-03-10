import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataScreen extends StatelessWidget {
  final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('clubs');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of clubs'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _collectionRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = snapshot.data!.docs;
          if (documents == null || documents.isEmpty) {
            return Center(child: Text('No data found'));
          }
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final data = documents[index].data();
              if (data == null) {
                return SizedBox();
              }
              final mapData = data as Map<String, dynamic>;
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(mapData['logo'] ?? ''),
                ),
                  title: Text(mapData['name'] ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(''),
                      Text(mapData['description'] ?? ''),
                      Text(''),
                      Text(mapData['email'] ?? ''),
                      
                    ],
                  )
                  
                ),
              );
            },
          );
        },
      ),
    );
  }
}