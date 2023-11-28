import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/Widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/models/user_model.dart';
import '../../Validators.dart';
import '../../Widget/custom_button.dart';
import 'login_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
  TextEditingController(text: '');
  UserRepo userRepo = UserRepo();
  String city = '';

  bool passwordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoaderOverlay(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Sign up',
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
                          'Register new account',
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
                          SizedBox(height: 10,),
                          InputField(
                              hintText: 'Name',
                              controller: nameController,
                              suffixIcon: const SizedBox(),
                              textFieldValidator: (value) {
                                if (!Validators().validateName(
                                    nameController.text.trim())) {
                                  return 'Please enter a valid Name';
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          InputField(
                              hintText: 'Email',
                              controller: emailController,
                              suffixIcon: const SizedBox(),
                              textFieldValidator: (value) {
                                if (!Validators().validateEmail(
                                    emailController.text.trim())) {
                                  return 'Please enter a valid email';
                                } else {
                                  return null;
                                }
                              }
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
                              textFieldValidator: (value) {
                                if (!Validators().validatePassword(
                                    passwordController.text.trim())) {
                                  return 'Please enter a valid password';
                                } else {
                                  return null;
                                }
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                              ),
                              hint: Text(
                                'Select a City',
                                style: TextStyle(color: Color(0xff94959b)),
                              ),
                              items: <String>[
                                'Vehari',
                                'Multan',
                                'Lahore',
                                'Karachi',
                                'Islamabad',
                                'Haroonabad',
                                'Faisalabad',
                                'Bahawalpur',
                                'Rawalpindi',
                                'Bahawalnager',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  city = value!;
                                });
                              },
                              validator: (String? value) {
                                if (value == null) {
                                  return 'Please select a city';
                                }
                                return null;
                              },
                              value: city.isNotEmpty ? city : null,
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
                          title: 'Register',
                          fontSize: 18,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              context.loaderOverlay.show();
                              final String email = emailController.text.trim();
                              final String password =
                              passwordController.text.trim();
                              final String name = nameController.text.trim();
                              final String selectedCity = city;
                              try {
                                User? regUser =
                                await userRepo.registerWithEmailAndPassword(
                                    email, password);
                                String userId = regUser!.uid;
                                UserModel user = UserModel(
                                  imagePath: 'assets/images/demo.png',
                                  userId: userId,
                                  name: name,
                                  email: email,
                                  city: selectedCity,
                                  userToken: await userRepo.getToken(),
                                );
                                userRepo.createUser(user);
                                emailController.clear();
                                passwordController.clear();
                                nameController.clear();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              } catch (e) {
                                context.loaderOverlay.hide();
                                print('Error during registration: $e');
                              }
                            }
                          }),
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
                        const Text(
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
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xff007aff),
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
      ),
    );
  }
}
