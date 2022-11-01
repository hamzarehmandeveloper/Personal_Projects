import 'package:flutter/material.dart';

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