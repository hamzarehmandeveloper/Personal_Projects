import 'package:home_services_fyp/Widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/input_field.dart';
import 'package:home_services_fyp/usersMode/screens/register_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../Constants.dart';
import '../../FireStore_repo/admin_repo.dart';
import '../../Validators.dart';
import '../../buttomBar/buttombar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../themes.dart';
import 'admin-home.dart';

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
  TextEditingController(text: '');

  AdminRepo adminRepo = AdminRepo();

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
      body: LoaderOverlay(
        overlayOpacity: 0.0,
        overlayColor: Colors.grey,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff94959b)),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputField(
                              hintText: 'Admin Email',
                              suffixIcon: const SizedBox(),
                              controller: emailController,
                              textFieldValidator: (value) {
                                if (!Validators().validateEmail(
                                    emailController.text.trim())) {
                                  return 'Please enter a valid email';
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          InputField(
                              hintText: 'Admin Password',
                              controller: passwordController,
                              obscureText: !passwordVisible,
                              suffixIcon: IconButton(
                                color: const Color(0xff94959b),
                                splashRadius: 1,
                                icon: Icon(passwordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined),
                                onPressed: togglePassword,
                              ),
                              textFieldValidator: (value) {
                                if (!Validators().validatePassword(
                                    passwordController.text.trim())) {
                                  return 'Please enter a valid password';
                                } else {
                                  return null;
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                        child: customButton(
                            title: 'Login',
                            fontSize: 18,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                context.loaderOverlay.show();
                                final String email =
                                emailController.text.trim();
                                final String password =
                                passwordController.text.trim();
                                User? user =
                                await adminRepo.adminSignIn(
                                    email, password);
                                if (user != null) {

                                  context.loaderOverlay.hide();
                                  emailController.clear();
                                  passwordController.clear();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const AdminHomeScreen()),
                                  );
                                } else {
                                  context.loaderOverlay.hide();
                                  showErrorMessage(context,
                                      'Invalid email or password. Please try again.');
                                }
                              }
                            })),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
