import 'package:flutter/material.dart';
import 'package:quizappmaster/provider/question_provider.dart';
import 'package:quizappmaster/provider/score_provider.dart';
import 'package:quizappmaster/screen/dashboard.dart';
import 'package:quizappmaster/util/router.dart';
import 'package:quizappmaster/util/router_path.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen,
    );
  }
}
