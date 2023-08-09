import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/profile.dart';
import 'package:home_services_fyp/models/worker_model.dart';
import '../../../Widget/custom_button.dart';
import '../../Constants.dart';
import '../../FireStore_repo/user_repo.dart';
import '../../Widget/profile_edit_screens_textfield.dart';
import '../../models/user_model.dart';

class WorkerEditProfileScreen extends StatefulWidget {
  @override
  _WorkerEditProfileScreenState createState() =>
      _WorkerEditProfileScreenState();
}

class _WorkerEditProfileScreenState extends State<WorkerEditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  String skill='';
  final TextEditingController aboutController = TextEditingController();
  UserRepo userRepo = UserRepo();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WorkerModel worker = WorkerPreferences.myWorker;
    return FutureBuilder(
      future: userRepo.fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text('Error fetching user data: ${snapshot.error}');
        } else {
          return SafeArea(
            child: Scaffold(
                body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                      child: Text(
                        'Register \nas a Worker',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ];
              },
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 32),
                physics: BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 10),
                  ProfileWidget(
                    imagePath: worker.imagePath,
                    isEdit: true,
                    onClicked: () async {},
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'Full Name',
                    text: Constants.userModel?.name,
                    onChanged: (name) {
                      print(name);
                    },
                    controller: nameController,
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'Email',
                    text: Constants.userModel?.email,
                    onChanged: (email) {},
                    controller: emailController,
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'City',
                    text: Constants.userModel?.city,
                    onChanged: (name) {},
                    controller: cityController,
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'Mobile Number',
                    text: Constants.userModel?.phoneNo,
                    onChanged: (name) {},
                    controller: mobileNumberController,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Skill',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff1f1f5),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      hint: Text(
                        'Select a category',
                        style: TextStyle(color: Color(0xff94959b)),
                      ),
                      items: <String>[
                        'Cleaning',
                        'Plumber',
                        'Electrician',
                        'Painter',
                        'Carpenter',
                        'Gardener',
                        'Tailor',
                        'Maid',
                        'Driver',
                        'Cook',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          skill = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                      value: skill.isNotEmpty ? skill : null,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFieldWidget(
                    label: 'About',
                    text: Constants.userModel?.about,
                    maxLines: 5,
                    onChanged: (about) {},
                    controller: aboutController,
                  ),
                  const SizedBox(height: 24),
                  customButton(
                    title: "Save",
                    onTap: () async {
                      final String email = emailController.text.trim();
                      final String name = nameController.text.trim();
                      final String city = cityController.text.trim();
                      final String phoneNo = mobileNumberController.text.trim();
                      final String skillToAdd = skill;
                      final String about = aboutController.text.trim();
                      print(userRepo.currentUser);
                      try {
                        await userRepo.firestore.collection('Users').doc(userRepo.currentUser).update({
                          "email": email!=""?email:Constants.userModel?.email,
                          "name" : name!=""?name:Constants.userModel?.name,
                          "city" : city!=""?city:Constants.userModel?.city,
                          "phoneNo" : phoneNo!=""?phoneNo:Constants.userModel?.phoneNo,
                          "skill" : skillToAdd!=""?skillToAdd:Constants.userModel?.skill,
                          "about" : about!=""?about:Constants.userModel?.about,
                        }).whenComplete(() => print("updated"));
                      } catch (e) {
                        print('Error updating user data: $e');
                      }
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            )),
          );
        }
      },
    );
  }
}
