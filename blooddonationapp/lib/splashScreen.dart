import 'package:blooddonationapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:blooddonationapp/DonnerList.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Bicon.ico', height: 130,),
            Text("Blood Donation App",style: TextStyle(
              fontSize: 25,color: Colors.white
            ),),

          ],
        ),
      ),
    );
  }
}