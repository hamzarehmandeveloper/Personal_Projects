import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (input) {
                if(input.isEmpty){
                  return 'Provide an email';
                }
              },
              decoration: InputDecoration(
                  labelText: 'Email'
              ),
              onSaved: (input) => _email = input!,
            ),
            TextFormField(
              validator: (input) {
                if(input.length < 6){
                  return 'Longer password please';
                }
              },
              decoration: InputDecoration(
                  labelText: 'Password'
              ),
              obscureText: true,
              onSaved: (input) => _password = input,
            ),
            RaisedButton(
              onPressed: signIn,
              child: Text('Sign in'),
            ),
          ],
        ),
      ),
    );
  }

  void signIn() {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      //Add your sign in logic here, for example, checking against a mock database of users
      print(_email);
      print(_password);
    }
  }
}
