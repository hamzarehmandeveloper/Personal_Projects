import 'package:flutter/material.dart';
import 'package:tasbeehapp/sharedPref.dart';
import 'package:tasbeehapp/Saved.dart';
import 'constant.dart';

void main() {
  runApp(Tasbeeh());
}

class Tasbeeh extends StatelessWidget {
  const Tasbeeh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainpage(),
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
    );
  }
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  late int _count = 0;
  String Tname = '';

  void increament() {
    setState(() {
      _count++;
    });
    int i = tnameclass.indexWhere((element) => element.name == Tname);
    tnameclass[i].count = _count;
    tnameclass.forEach((element) {
      print(element.name +' = '+ element.count.toString());
    });
    sharedPref.save('tName', tnameclass);
  }

  void reset() {
    setState(() {
      _count = 0;
    });
    int i = tnameclass.indexWhere((element) => element.name == Tname);
    tnameclass[i].count = _count;
    tnameclass.forEach((element) {
      print(element.name +' = '+ element.count.toString());
    });
    sharedPref.save('tName', tnameclass);
  }


  @override
  void initState() {
    super.initState();
    getSavedT();
  }

  TextEditingController _textFieldController = TextEditingController();
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter Tasbeeh Name '),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _textFieldController,
                  decoration: InputDecoration(hintText: "Enter Text"),
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Limit"),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: new Text('ADD'),
                onPressed: () {
                  setState(() {
                    Tname = _textFieldController.value.text;
                    tnameclass.add(tName(_textFieldController.value.text, 0));
                  });
                  tnameclass.forEach((element) {print(element.name);});
                  sharedPref.save('tName', tnameclass);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasbeeh Counter"),
        centerTitle: true,

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0,),
            child: Container(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  side: BorderSide(width: 2.0, color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left:27,right: 27),
                  child: Text(
                    'Saved',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>saved(

                  )));
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  side: BorderSide(width: 2.0, color: Colors.white),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Customize',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onPressed: () {
                  _displayDialog(context);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Tname),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(150),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: Text(
                    _count.toString(),
                    style: TextStyle(
                      fontSize: 100.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 80, bottom: 20, left: 70, right: 70),
            child: Row(
              children: [
                  Container(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        side: BorderSide(width: 2.0, color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Reset',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        reset();
                      },
                    ),
                  ),

                Spacer(
                  flex: 1,
                ),
                Container(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        side: BorderSide(width: 2.0, color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Count',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
                        increament();
                      },
                    ),
                  ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

class tName {
  tName(this._name, this._count);
  String _name;
  int _count;

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get count => _count;

  set count(int value) {
    _count = value;
  }


}
