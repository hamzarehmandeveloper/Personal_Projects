import 'package:flutter/material.dart';
import 'container.dart';
import 'IconText.dart';
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



