import 'package:flutter/material.dart';
import 'sharedPref.dart';
import 'main.dart';


List<tName> tnameclass = [];

SharedPref sharedPref = new SharedPref();

getSavedT() async {
  tnameclass = await sharedPref.read('tName');
  tnameclass.forEach((element) {
    print("Tname GetSavedT: "+element.name);
  });
}

