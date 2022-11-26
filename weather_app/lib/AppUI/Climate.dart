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

  String ? _cityEntered;

  Future _goToNextScreen(BuildContext context) async {
    Map? results = await Navigator.of(context)
        .push(MaterialPageRoute<Map>(builder: (BuildContext context) {
      //change to Map instead of dynamic for this to work
      return ChangeCity();
    }));

    if (results != null && results.containsKey('enter')) {
      _cityEntered = results['enter'];

      print("From First screen" + _cityEntered!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ClimateApp'),
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _goToNextScreen(context);
              })
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage('images/umbrella.png'),
              height: 1250.0,
              width: 600.0,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: Text(
              '${_cityEntered == null ? util.defaultCity : _cityEntered}',
              style: cityStyle(),
            ),
          ),
          Center(
            child: Image(
              image: AssetImage('images/light_rain.png'),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30.0, 90.0, 0.0, 0.0),
            child: updateTempWidget(
                '${_cityEntered == null ? util.defaultCity : _cityEntered}'),
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
              margin: const EdgeInsets.fromLTRB(30.0, 250.0, 0.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      content!['main']['temp'].toString() + " F",
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 49.9,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: ListTile(
                      title: Text(
                        "Humidity: ${content!['main']['humidity'].toString()}\n"
                            "Min: ${content['main']['temp_min'].toString()} F\n"
                            "Max: ${content['main']['temp_max'].toString()} F ",
                        style: extraData(),
                      ),
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
    color: Colors.white,
    fontSize: 22.9,

  );
}

TextStyle extraData() {
  return TextStyle(
      color: Colors.white70, fontStyle: FontStyle.normal, fontSize: 17.0);
}