import 'package:flutter/material.dart';
import 'AppUI/Climate.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Climate(),
      ),
    ),
  );
}
