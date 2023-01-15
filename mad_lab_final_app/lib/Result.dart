import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

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
                    Navigator.pop(context);
                  },
                  child: Text("Go to Home", style: TextStyle(fontSize: 20, color: Colors.blue))
              ),
            )
          ],
        ),
      ),
    );
  }
}
