import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                cardWidget: ReapeatTIwidget(
                  icondata: FontAwesomeIcons.male,
                  label: 'Male',
                ),
              ),),
              Expanded(child: Repeatcontainercode(
                colors: Color(0xFF1D1E33),
                cardWidget: ReapeatTIwidget(
                  icondata: FontAwesomeIcons.female,
                  label: 'Female',
                ),
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

class ReapeatTIwidget extends StatelessWidget {
  ReapeatTIwidget({required this.icondata,this.label});

  final IconData? icondata;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Icon(
            icondata,
            size: 80.0,
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label.toString(),
          style: TextStyle(
            fontSize: 20.0,
            color: Color(0xFF8D8E98),
          ),
        ),
      ],
    );
  }
}

class Repeatcontainercode extends StatelessWidget {

  Repeatcontainercode ({@required this.colors, this.cardWidget});
  Color? colors;
  Widget? cardWidget;
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(15.0),
      child: cardWidget,
      decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(10.0)
      ),
    );
  }
}