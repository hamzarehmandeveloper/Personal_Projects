import 'package:flutter/material.dart';
import 'package:mad_lab_final_app/resultlist.dart';

import 'HomePage.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;
  late String Status="";

  ResultPage({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Text("Quiz Results", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 50),
            Text("You scored $score out of $totalQuestions", style: TextStyle(fontSize: 20, color: Colors.white)),
            SizedBox(height: 50),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
              ),
              child: TextButton(
                  onPressed: () {
                    Status="Saved Data to firebase";
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResultList(totalQuestions: 4, scores: [3],)));
                  },
                  child: Text("Save To Firebase", style: TextStyle(fontSize: 20, color: Colors.blue))
              ),
            ),
            SizedBox(height: 20),

            Text('$Status'),

            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
              ),
              child: TextButton(
                  onPressed: () {
                    Status="Saved data to SQLite";
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResultList(totalQuestions: 4, scores: [3],)));
                  },
                  child: Text("Save To SQLite", style: TextStyle(fontSize: 20, color: Colors.blue))
              ),
            ),
            SizedBox(height: 20),

            Text("$Status"),

            SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
              ),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                  },
                  child: Text("Go to Home", style: TextStyle(fontSize: 20, color: Colors.blue))
              ),
            ),
          ],
        ),
      ),
    );
  }
}
