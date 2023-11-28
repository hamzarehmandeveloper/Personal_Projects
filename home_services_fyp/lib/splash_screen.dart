import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/usersMode/screens/startScreen.dart';
import 'package:lottie/lottie.dart';

import 'Constants.dart';
import 'buttomBar/buttombar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserRepo userRepo = UserRepo();
  @override
  void initState() {
    super.initState();
    timer();
  }

  timer() async {
    Constants.userModel = (await userRepo.fetchUserData());
    Future.delayed(const Duration(seconds: 2), () async {
      if (Constants.userModel != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TabContainer()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const StartPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset('assets/lottie_animation/Splash_Screen.json',
                width: MediaQuery.of(context).size.width*1, height: MediaQuery.of(context).size.height*.70),
            const SizedBox(height: 10,),
            const Text('Home Mender',style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
    );
  }
}
