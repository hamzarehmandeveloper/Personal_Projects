import 'package:home_services_fyp/Widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/input_field.dart';
import 'package:home_services_fyp/usersMode/screens/register_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../Constants.dart';
import '../../FireStore_repo/user_repo.dart';
import '../../buttomBar/buttombar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../themes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  UserRepo userRepo = UserRepo();

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
                          'Sign in to continue',
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
                              color: const Color(0xff94959b),
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
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                        child: customButton(
                            title: 'Login',
                            onTap: () async {
                              context.loaderOverlay.show();
                              final String email = emailController.text.trim();
                              final String password =
                                  passwordController.text.trim();
                              User? user = await userRepo
                                  .signInWithEmailAndPassword(email, password);
                              if (user != null) {
                                Constants.userModel= await userRepo.fetchUserData();
                                userRepo.setupToken();
                                context.loaderOverlay.hide();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TabContainer()),
                                );
                              } else {
                                context.loaderOverlay.hide();
                                showErrorMessage(context,
                                    'Invalid email or password. Please try again.');
                              }
                            })),
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
                        const Text(
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
                                    builder: (context) => const RegisterScreen()));
                          },
                          child: const Text(
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
      ),
    );
  }
}
