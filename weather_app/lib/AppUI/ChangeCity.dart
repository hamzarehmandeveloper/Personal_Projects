import 'package:flutter/material.dart';


class ChangeCity extends StatefulWidget {
  const ChangeCity({Key? key}) : super(key: key);


  @override
  State<ChangeCity> createState() => _ChangeCityState();
}

class _ChangeCityState extends State<ChangeCity> {
  var _cityFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Change City'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset(
              'images/white_snow.png',
              width: 590.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter City',
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: TextButton(
                    onPressed: () {
                      Navigator.pop(
                          context, {'enter': _cityFieldController.text});
                    },


                    child: Text('Get Weather')),
              )
            ],
          )
        ],
      ),
    );;
  }
}