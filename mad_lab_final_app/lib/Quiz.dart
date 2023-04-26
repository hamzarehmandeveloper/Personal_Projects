import 'package:flutter/material.dart';
import 'dart:math';
import 'package:mad_lab_final_app/Result.dart';

import 'HomePage.dart';

class QuizPage extends StatefulWidget {
  QuizPage({required this.tstart, required this.tend, required this.tableno});
  final int tstart;
  final int tend;
  final int tableno;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<int> _quizQuestions = [];
  int _currentQuestion = 0;
  int _score = 0;
  int _tries = 0;
  Random _random = Random();
  TextEditingController _answerController = TextEditingController();
  String _result = '';

  @override
  void initState() {
    super.initState();
    _quizQuestions = _generateQuizQuestions();
    _shuffleQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "What is ${widget.tableno} x ${_quizQuestions[_currentQuestion]}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _answerController,
              decoration: InputDecoration(
                hintText: "Answer here",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _checkAnswer,
                ),
              ),
            ),
          ),
          Text(_result),
          Container(
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.brown
            ),
            child: TextButton(
                onPressed: _nextQuestion,
                child: Text("Next Question", style: TextStyle(fontSize: 20, color: Colors.black))
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.brown
            ),
            child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                },
                child: Text("Go to Home", style: TextStyle(fontSize: 20, color: Colors.black))
            ),
          ),
        ],
      ),
    );
  }

  List<int> _generateQuizQuestions() {
    List<int> questions = [];
    for (int i = widget.tstart; i <= 3; i++) {
      questions.add(i);
    }
    return questions;
  }

  void _shuffleQuestions() {
    _quizQuestions.shuffle(_random);
  }

  void _nextQuestion() {
    if (_currentQuestion == _quizQuestions.length - 1) {
      _showResults();
    } else {
      setState(() {
        _currentQuestion++;
        _result = '';
      });
    }
  }

  void _showResults() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ResultPage(
                  score: _score,
                  totalQuestions: _quizQuestions.length,
                )));
  }

  void _checkAnswer() {
    int answer = int.parse(_answerController.text);
    setState(() {
      if (answer == widget.tableno * _quizQuestions[_currentQuestion]) {
        _score++;
        _tries++;
        _result = 'Correct';
        _nextQuestion();
      } else {
        _result = 'Incorrect';
        _nextQuestion();
        _tries++;
      }
      if (_tries == 4) {
        _showResults();
      }
    });
    _answerController.clear();
  }
}