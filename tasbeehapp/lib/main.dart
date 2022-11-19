import 'package:flutter/material.dart';

void main(){
  runApp(Tasbeeh());
}

class Tasbeeh extends StatelessWidget {
  const Tasbeeh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: mainpage(),
        theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
    );
  }
}


class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasbeeh Counter"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: GestureDetector(
            child: SizedBox(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text("Costomize"),
                ),
              ),
            ),
          ),
          ),
          Expanded(child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Text(
                    '10',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 70),
                  ),
                ],
              ),
            ),
            ),
          ),
          Row(
            children: [
              Expanded(child: GestureDetector(
                child: SizedBox(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text("Count"),
                    ),
                  ),
                ),
              ),
              ),
              Expanded(child: GestureDetector(
                child: SizedBox(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text("Reset"),
                    ),
                  ),
                ),
              ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
