import 'package:flutter/material.dart';



class AdminCustomButton extends StatelessWidget {
  final String title;
  final Function() onTap;
  final double fontSize;
  final Color color;
  const AdminCustomButton({Key? key, required this.title, required this.onTap, required this.fontSize, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      color: color,
      onPressed: onTap,
      height: 55,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
