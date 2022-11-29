import 'package:flutter/material.dart';
import '../utils/apifile.dart' as util;
import 'package:http/http.dart' as http;
import 'ChangeCity.dart';
import 'dart:convert';


class Climate extends StatefulWidget {
  @override
  _ClimateState createState() => _ClimateState();
}

class _ClimateState extends State<Climate> {
  void showStuff() async {
    Map data = await getWeather(util.apiId, util.defaultCity);
    print(data.toString());
  }
  var _cityFieldController = TextEditingController();
  String ? _cityEntered;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClimateApp'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: <Widget>[

          Column(
            children: [
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
                      _cityEntered=_cityFieldController.value.text;
                      print("From First screen" + _cityEntered!);
                    },


                    child: Text('Get Weather')),
              ),
            ],
          ),

          Container(
            alignment: Alignment.center,

          ),
          Center(
            child: Image(
              image: AssetImage('images/light_rain.png'),
            ),
          ),
          Column(
            children:[
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(150),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      '${_cityEntered == null ? util.defaultCity : _cityEntered}',
                      style: TextStyle(
                        fontSize: 50.0,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
              child: updateTempWidget(
                  '${_cityEntered == null ? util.defaultCity : _cityEntered}'),
            ),
            ],
          ),
        ],
      ),
    );
  }


  Future<Map> getWeather(String appId, String city) async {
    String ? apiUrl =
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid='
        '${util.apiId}&units=imperial';
    //http://api.openweathermap.org/data/2.5/weather?q=vehari&appid=ee595cbdb0db0ef5d11b9caf5a8eb1ea&units=metric
    http.Response ? response = await http.get(Uri.parse(apiUrl));

    return json.decode(response.body);
  }


  Widget updateTempWidget(String city) {
    return FutureBuilder(
        future: getWeather(util.apiId, city == null ? util.defaultCity : city),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          //where we get all of the json data, we setup widgets etc.
          if (snapshot.hasData) {
            Map ? content = snapshot.data;
            return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        content!['main']['temp'].toString() + " F",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 49.9,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                          "Humidity: ${content!['main']['humidity'].toString()}\n"
                              "Min: ${content['main']['temp_min'].toString()} F\n"
                              "Max: ${content['main']['temp_max'].toString()} F ",
                          style: extraData(),
                        ),

                    )
                  ],
                ),
              );
          } else {
            return Container();
          }
        });
  }
}

TextStyle cityStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 22.9,

  );
}

TextStyle extraData() {
  return TextStyle(
      color: Colors.black, fontStyle: FontStyle.normal, fontSize: 17.0);
}