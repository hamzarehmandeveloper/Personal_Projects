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
              Expanded(child: Repeatcontainercode(
                colors: Color(0xFF1D1E33),
              ),),
              Expanded(child: Repeatcontainercode(
                colors: Color(0xFF1D1E33),
              ),),
            ],
          )),
          Expanded(child: Repeatcontainercode(
            colors: Color(0xFF1D1E33),
          ),),

          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: Repeatcontainercode(
                colors: Color(0xFF1D1E33),
              ),),
              Expanded(child: Repeatcontainercode(
                colors: Color(0xFF1D1E33),
              ),),
            ],
          )),

        ],
      ),
    );
  }
}

class Repeatcontainercode extends StatelessWidget {

  Repeatcontainercode ({@required this.colors});
  Color? colors;
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(10.0)
      ),
    );
  }
}