import 'package:flutter/material.dart';

import 'MainScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward().whenComplete(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MainPage(),
        ),
      );
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Container(
          color: Colors.black,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage("https://picsum.photos/200"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "QUIZ APP",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
