import 'package:flutter/material.dart';

Row buildCategory(String text, size, isDarkMode) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.03,
          left: size.width * 0.05,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode ? Colors.white : const Color(0xff3b22a1),
            fontWeight: FontWeight.bold,
            fontSize: size.width * 0.055,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.03,
          right: size.width * 0.05,
        ),
        child: Text(
          'View All',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isDarkMode
                ? Colors.white.withOpacity(0.5)
                : Colors.black.withOpacity(0.5),
            fontSize: size.width * 0.04,
          ),
        ),
      ),
    ],
  );
}
