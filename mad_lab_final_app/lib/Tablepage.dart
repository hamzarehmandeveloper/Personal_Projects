import 'package:flutter/material.dart';

class Tablepage extends StatefulWidget {
  const Tablepage({Key? key}) : super(key: key);
  @override
  State<Tablepage> createState() => _TablepageState();
}

class _TablepageState extends State<Tablepage> {
  Tablepage({required this.tstart, required this.tend, required this.tableno,});
  late int tstart,tend,tablono;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table"),

      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
