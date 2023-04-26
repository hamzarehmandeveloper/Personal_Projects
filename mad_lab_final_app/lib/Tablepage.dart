import 'package:flutter/material.dart';
import 'package:mad_lab_final_app/Quiz.dart';

import 'HomePage.dart';

class Tablepage extends StatefulWidget {
  Tablepage({required this.tstart, required this.tend, required this.tableno});
  final int tstart;
  final int tend;
  final int tableno;

  @override
  _TablepageState createState() => _TablepageState();
}

class _TablepageState extends State<Tablepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.tend - widget.tstart + 1,
              itemBuilder: (context, index) {
                final i = index + widget.tstart;
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Text(
                      '${widget.tableno}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    title: Text('x'),
                    trailing: Text(
                      '${widget.tableno * i}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
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
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.brown
            ),
            child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizPage(
                    tstart: widget.tstart,
                    tend: widget.tend,
                    tableno: widget.tableno,
                  )));
                },
                child: Text("Create Quiz", style: TextStyle(fontSize: 20, color: Colors.black))
            ),
          ),
        ],
      ),
    );
  }
}
