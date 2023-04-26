import 'package:home_services_fyp/screens/register_screen.dart';
import 'package:home_services_fyp/Widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/input_field.dart';
import '../buttomBar/buttombar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Sign in to continue',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff94959b)),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                        hintText: 'Email',
                        suffixIcon: const SizedBox(),
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        hintText: 'Password',
                        controller: passwordController,
                        obscureText: !passwordVisible,
                        suffixIcon: IconButton(
                          color: Color(0xff94959b),
                          splashRadius: 1,
                          icon: Icon(passwordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                          onPressed: togglePassword,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                    child: customButton(
                  title: 'Login',
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TabContainer()));
                  },
                )),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    '- OR -',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff94959b)),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff94959b),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff007aff),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
