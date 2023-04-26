import 'package:flutter/material.dart';
import 'package:quizappfirebase/User.dart';

class usertiles extends StatelessWidget {
  const usertiles({Key? key, required this.user}) : super(key: key);
  final Userinfo user;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.indigo,
            ),
            title: Text(user.name.toString()),
            subtitle: Text("Age : ${user.age}      Phone: ${user.phone}"),
          ),
        ),
    );
  }
}
