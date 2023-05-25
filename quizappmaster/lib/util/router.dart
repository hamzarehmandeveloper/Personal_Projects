/*

import 'package:flutter/material.dart';
import 'package:quizappmaster/screen/dashboard.dart';
import 'package:quizappmaster/screen/quiz_finish_screen.dart';
import 'package:quizappmaster/screen/quiz_screen.dart';
import 'package:quizappmaster/screen/splash_screen.dart';
import 'package:quizappmaster/util/router_path.dart';


class Routerr {
  static Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case SplashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashPage());
      case DashBoardScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => DashboardPage());
      case QuizScreen:
        final argument = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => QuizPage(
            difficult: argument.toString(),
            listQuestion: argument,
            id: argument.toString(),
          ),
        );
      case QuizFinishScreen:
        final argument = settings.arguments;
        return MaterialPageRoute(builder: (_) => QuizFinishPage(title: argument));
    }
  }
}*/
