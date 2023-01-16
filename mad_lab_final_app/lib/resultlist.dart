import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'dart:math';


class ResultList extends StatelessWidget {
  final int totalQuestions;
  final List<int> scores;
  var random = new Random();

  ResultList({required this.totalQuestions, required this.scores});

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
                Expanded(
                  child: ListView.builder(
                      itemCount: scores.length,
                      itemBuilder: (context, index) {
                        return Card(
                            color: Colors.white,
                            child: ListTile(
                              leading: Icon(Icons.assessment, color: Colors.blue),
                              title: Text("Score ${scores[index]} out of $totalQuestions"),
                            )
                        );
                      }
                  ),
                ),
                Container(
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                  ),
                  child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                      },
                      child: Text("Go to Home",textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.blue))
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            )
        )
    );
  }
}