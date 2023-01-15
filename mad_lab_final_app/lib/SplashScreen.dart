import 'package:flutter/material.dart';
import 'package:mad_lab_final_app/HomePage.dart';


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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage()));
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
            Image.asset('Assets/Icon.png', height: 130,),
            Text("Quiz App",style: TextStyle(
                fontSize: 25,color: Colors.white
            ),),

          ],
        ),
      ),
    );
  }
}