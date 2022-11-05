import 'package:bmicalculator/constants.dart';
import 'package:flutter/material.dart';

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
          style: Klabelstyle,
        ),
      ],
    );
  }
}