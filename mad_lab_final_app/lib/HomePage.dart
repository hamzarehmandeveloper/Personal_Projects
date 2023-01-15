import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

import 'Tablepage.dart';
import 'db_manager.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _tstr = TextEditingController();
  final TextEditingController _tlast = TextEditingController();
  final TextEditingController _table = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.greenAccent, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1.0),
              ),
              hintText: 'Enter Table Number',
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
            ),
            controller: _table,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Table Number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.greenAccent, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1.0),
              ),
              hintText: 'Enter Table Starting Number',
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
            ),
            controller: _tstr,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Table Starting Number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.greenAccent, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.pink, width: 1.0),
              ),
              hintText: 'Enter Table Ending Number',
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
            ),
            controller: _tlast,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Table Ending Number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          TextButtonTheme(
            data: TextButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.white30),
              ),
            ),
            child: TextButton(
              onPressed: () {

                }
              },
              child: const Text(
                "Generate Table",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ),
            TextButtonTheme(
              data: TextButtonThemeData(
              style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
              Colors.white30),
              ),
              ),
              child: TextButton(
                onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Homepage(_);
  }));
                },
                child: const Text(
                "Generate Table",
                style: TextStyle(color: Colors.white),
                ),
              ),
              ),
        ],
      ),
    );
  }
}

