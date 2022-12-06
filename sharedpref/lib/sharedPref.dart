import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var d = jsonDecode(prefs.getString(key)??'');
    print(d);
    return (d);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();

    print("save: "+d);
    prefs.setString(key,d );
  }


}