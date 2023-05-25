/*

import 'package:flutter/material.dart';
import 'package:quizappmaster/model/score.dart';
import 'package:quizappmaster/util/dbmanager.dart';
import 'package:provider/provider.dart';

class ScoreProvider with ChangeNotifier{

  DbManger dbManger = DbManger();
  List<Score> arrScore = [];


  Future<Score> addScore(String nameUser,String categories,int scoree,String date, int totalAnswer, int totalQuestion , int id) async{
    Score score = Score(nameUser: nameUser,categories: categories,score: scoree,date: date,totalAnswer: totalAnswer,totalQuestion: totalQuestion, id: id);
    await dbManger.addUserScore(score);
    notifyListeners();
    return score;
  }

  Future deleteScore(int id ) async {
    await dbManger.deleteScore(id);

    notifyListeners();
  }


  Future<List<Score>> getAllScore() async {
   await dbManger.getUserScore().then((value) => {
      arrScore = value
    });
    notifyListeners();
    return arrScore;
  }
}*/
