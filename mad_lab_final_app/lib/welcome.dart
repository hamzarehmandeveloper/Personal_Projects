import 'package:flutter/material.dart';
import 'package:mad_lab_final_app/Roundbutton.dart';
import 'package:mad_lab_final_app/Signup.dart';
import 'package:mad_lab_final_app/Login.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Table Generator & Quiz",textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 25,color: Colors.black
                ),),
                SizedBox(height: 20),

                RoundedButton(
                  colour: Colors.brown,
                  title: 'Log In',
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                ),
                RoundedButton(
                    colour: Colors.brown,
                    title: 'Register',
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                    }),
              ]),
        ));
  }
}
