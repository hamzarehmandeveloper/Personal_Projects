import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizappfirebase/User.dart';

import 'Auth.dart';
import 'SignUp.dart';
import 'masterpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final authServices authser= authServices();
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool showSpinner = false;
  late String userEmail='';


  void getCurrentUserEmail() async {
    final user = await _auth.currentUser;
    userEmail = user?.email ?? 'User not found';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100.0),
                    const Text(
                      'Quiz App',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 48.0),
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
                      style: const TextStyle(color: Colors.black),
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
                    const SizedBox(height: 36.0),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print(_email);
                          print(_password);
                          getCurrentUserEmail();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MasterPage(),
                            ),
                          );
                          setState(() {
                            showSpinner = true;
                          });
                          authser.login(_email, _password);
                          setState(() {
                            showSpinner = false;
                          });

                        }
                      },
                      child: const Text('Log In'),
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpPage(),
                          ),
                        );
                      },
                      child: const Text('Sign Up'),
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

