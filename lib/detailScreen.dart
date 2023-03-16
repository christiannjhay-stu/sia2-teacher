import 'dart:ui';

import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {

  final Map<String, dynamic> data;

  const DetailScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
      ),
      body: Center(
        child: Text(data['description'],
        style: TextStyle(
          color: Colors.white
        ),),
      ),
    );
  }
}