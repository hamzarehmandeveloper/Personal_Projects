import 'package:flutter/material.dart';

RichText richText(String title, String text){
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
            text:
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        TextSpan(
            text: text,
            style: TextStyle(
                color: Colors.grey.shade800)),
      ],
    ),
  );
}