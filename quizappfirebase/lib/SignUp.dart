import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Auth.dart';
import 'Login.dart';
import 'MainScreen.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final authServices auth= authServices();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late String _email, _password, _name;
  late int _age,_phone;
  late bool showspiner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 100.0),
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 48.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: 'Full Name',
                        labelStyle: TextStyle(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (input) =>
                      input == null || input.isEmpty
                          ? 'Please enter name'
                          : null,
                      onSaved: (input) => _name = input!,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 24.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: 'Age',
                        labelStyle: TextStyle(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (input) =>
                      input == null || input.isEmpty
                          ? 'Please enter Age'
                          : null,
                      onSaved: (input) => _age = int.parse(input!),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 24.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        labelText: 'Phone No',
                        labelStyle: TextStyle(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (input) =>
                      input == null || input.isEmpty
                          ? 'Please enter Phone Number'
                          : null,
                      onSaved: (input) => _phone = int.parse(input!),
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 24.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                        ),
                        labelText: 'Email',
                        labelStyle: TextStyle(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (input) =>
                      input == null || !input.contains('@')
                          ? 'Please enter a valid email'
                          : null,
                      onSaved: (input) => _email = input!,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 24.0),
                    TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        labelText: 'Password',
                        labelStyle: TextStyle(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      validator: (input) => input == null || input.length < 6
                          ? 'Your password needs to be at least 6 characters'
                          : null,
                      onSaved: (input) => _password = input!,
                      obscureText: true,
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print(_email);
                          print(_password);
                          print(_name);
                          setState(() {
                            showspiner = true;
                          });
                          auth.signupUser(_email, _password , _name , _age , _phone);

                          setState(() {
                            showspiner = false;
                          });

                        }

                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
