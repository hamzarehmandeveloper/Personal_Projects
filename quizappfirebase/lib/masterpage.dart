import 'package:flutter/material.dart';
import 'package:quizappfirebase/database.dart';
import 'package:provider/provider.dart';
import 'package:quizappfirebase/User.dart';
import 'package:quizappfirebase/userlist.dart';

class MasterPage extends StatelessWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Userinfo>>.value(
      value: dbservices().usersdata,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body: userlist(),
      ),
    );
  }
}
