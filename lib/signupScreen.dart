
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_data/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

Widget buildFirstName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Name',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}
Widget buildLastName() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Lastname',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}
Widget buildSEmail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Email Address',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}
Widget buildSUsername() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Username',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}
Widget buildSPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          controller: passwordController,
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.white,

            )
          ),
        )
      )
    ],
  );
}

Widget buildConfirmPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: < Widget > [
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xff3A4859),
            borderRadius: BorderRadius.circular(10),
        ),
        height: 60,
        width: 340,
        child: TextField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 8, left: 20),
            hintText: 'Confirm Password',
            hintStyle: TextStyle(
              color: Colors.white,
            )
          ),
        )
      )
    ],
  );
}

Widget Logo(){
  return Center(
    child: Image.asset(
      'assets/images/adduLogo.png',
       width: 200,
       height: 200,

      )
  );
}

final emailController = TextEditingController();
final passwordController = TextEditingController();


class _SignUpScreenState extends State < SignUpScreen > {

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion < SystemUiOverlayStyle > (
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: < Widget > [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: < Widget > [
                    Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                        child: Text(
                          'Ateneo de Davao\nUniversity\nCreate Account',
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
                    Logo(),
                    SizedBox(height: 20),
                    buildFirstName(),
                    buildSUsername(),
                    buildSEmail(),
                    buildSPassword(),
                    SizedBox(height: 12),
                    Container(
                      width: 340,
                      height: 60,
                      child: TextButton(
                        onPressed: () {

                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text.trim(), 
                            password: passwordController.text.trim()
                            
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color.fromARGB(255, 27, 100, 25), // set the background color
                              content: Text('Account Successfully Created'), // set the message text
                              duration: Duration(seconds: 2), // set the duration for how long the message will be displayed
                            ),
                          ); 

                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return LoginScreen();
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll < Color > (Color(0xffFBB718)),
                          shape: MaterialStateProperty.all < RoundedRectangleBorder > (
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),

                            )
                          )
                        ),
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "Noopla"
                          ),

                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              letterSpacing: 1.2
                            ),
                          ),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                                return LoginScreen();
                              }));
                            },
                            child: Text(
                              'Login Here',
                              style: TextStyle(
                                color: Color.fromARGB(246, 255, 208, 0),
                                fontSize: 10,
                                letterSpacing: 1.2,

                              ),
                            )
                          ),

                        )
                      ],
                    ),
                    Footer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
