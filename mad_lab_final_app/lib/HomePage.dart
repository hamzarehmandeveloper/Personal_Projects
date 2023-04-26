
import 'package:flutter/material.dart';
import 'package:mad_lab_final_app/Tablepage.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _tstr = TextEditingController();
  final _tlast = TextEditingController();
  final _table = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Table"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _tstr,
              decoration: InputDecoration(
                hintText: 'Enter start value',
              ),
            ),
            TextField(
              controller: _tlast,
              decoration: InputDecoration(
                hintText: 'Enter end value',
              ),
            ),
            TextField(
              controller: _table,
              decoration: InputDecoration(
                hintText: 'Enter table number',
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.brown
              ),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Tablepage(
                            tstart: int.tryParse(_tstr.text) ?? 0,
                            tend: int.tryParse(_tlast.text) ?? 0,
                            tableno: int.tryParse(_table.text) ?? 0,
                          )),
                    );
                  },
                  child: Text("Show Table", style: TextStyle(fontSize: 20, color: Colors.black))
              ),
            ),

          ],
        ),
      ),
    );
  }
}