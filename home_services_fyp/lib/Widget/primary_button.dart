import 'package:flutter/material.dart';

class CustomPrimaryButton extends StatelessWidget {
  final Color? buttonColor;
  final Color textColor;
  final Function() onPressed;
  final String iconData;

  CustomPrimaryButton({
    required this.buttonColor,
    required this.textColor,
    required this.onPressed,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(100.0),
      child: Material(
        borderRadius: BorderRadius.circular(100.0),
        elevation: 0,
        child: Container(
            padding: const EdgeInsets.only(left: 1, right: 1),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Material(
              color: Colors.transparent,
              child: Image.asset(
                iconData,
              ),
            )),
      ),
    );
    ;
  }
}
