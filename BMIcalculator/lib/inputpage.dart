import 'package:flutter/material.dart';


class inputpage extends StatefulWidget {
  const inputpage({Key? key}) : super(key: key);

  @override
  State<inputpage> createState() => _inputpageState();
}

class _inputpageState extends State<inputpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color:Color(0xFF1D1E33),
                  borderRadius: BorderRadius.circular(10.0)
                ),
              ),),
              Expanded(child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color:Color(0xFF1D1E33),
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              ),
            ],
          )),
          Expanded(child: Container(
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color:Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(10.0)
            ),
          ),),

          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color:Color(0xFF1D1E33),
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),),
              Expanded(child: Container(
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color:Color(0xFF1D1E33),
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              ),
            ],
          )),

        ],
      ),
    );
  }
}