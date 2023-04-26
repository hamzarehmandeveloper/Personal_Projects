import 'package:home_services_fyp/screens/login_screen.dart';
import 'package:home_services_fyp/Widget/input_field.dart';
import 'package:flutter/material.dart';
import '../Widget/custom_button.dart';
import '../Widget/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController(text: '');
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
            padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register new\naccount',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
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
                        hintText: 'Name',
                        controller: nameController,
                        suffixIcon: const SizedBox(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        hintText: 'Email',
                        controller: emailController,
                        suffixIcon: const SizedBox(),
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
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        hintText: 'City',
                        controller: emailController,
                        suffixIcon: const SizedBox(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  child: customButton(
                    title: 'Register',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Text(
                    '- OR -',
                    style:TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
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
