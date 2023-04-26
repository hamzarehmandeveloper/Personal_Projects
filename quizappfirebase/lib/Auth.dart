

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizappfirebase/database.dart';

import 'masterpage.dart';





class authServices{
    FirebaseAuth _auth = FirebaseAuth.instance;


    Future signupUser(String email, String password , name , age , phone) async {
      try {
        UserCredential newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        User? user= newUser.user;
        await dbservices(uid: user!.uid).updatedata(name, age, phone);
      } catch (e) {
        print(e);
      }
    }

    Future login(String email, String password) async {
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        if (user != null) {

        }
      }on FirebaseAuthException catch (e) {
        print(e);
      }
    }

}