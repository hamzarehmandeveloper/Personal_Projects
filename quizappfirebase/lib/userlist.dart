import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:quizappfirebase/User.dart';
import 'package:quizappfirebase/usertiles.dart';

class userlist extends StatefulWidget {
  const userlist({Key? key}) : super(key: key);

  @override
  State<userlist> createState() => _userlistState();
}

class _userlistState extends State<userlist> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Userinfo>>(context);
    return  ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index){
          return usertiles(user: users[index]);
        }
    );
  }
}
