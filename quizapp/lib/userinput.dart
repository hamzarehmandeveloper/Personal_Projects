
import 'package:flutter/material.dart';
import 'quiz_brain.dart';


void main() => runApp(userinput());


class userinput extends StatefulWidget {
  const userinput({Key? key}) : super(key: key);

  @override
  State<userinput> createState() => _userinputState();
}

class _userinputState extends State<userinput> {

  QuizBrain obj = QuizBrain();

  final question= TextEditingController();
  final ans= TextEditingController();

  String? Q;
  String? A;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Expanded(
                    child:TextField(
                      controller: question,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: obj.getQuestionText(),
                      ),
                    )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Expanded(
                    child:TextField(
                      controller: ans,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'True or False',
                      ),
                    )
                ),
              ),
            ),
            Container(

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.green, // Background Color
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      Q = question.text;
                      A = ans.text;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


