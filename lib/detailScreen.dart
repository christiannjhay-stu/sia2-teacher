import 'dart:ui';

import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {

  final Map < String, dynamic > data;

  const DetailScreen({
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 26, 47),
        title: Text(data['name']),
      ),
      body: Container(
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
                        onPressed: () {
                          print('Joined');
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
    );
  }
}