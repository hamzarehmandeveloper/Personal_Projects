import 'package:flutter/material.dart';
import 'package:home_services_fyp/screens/profile_screen/profile_screen.dart';

import '../../Widget/custom_button.dart';
import '../../Widget/input_field.dart';
import '../../animation/FadeAnimation.dart';
import '../professionals_registration_screen.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController skillController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                child: Text(
                  'Register \nas a Worker',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: SizedBox(
                  height: 140,
                  width: 140,
                  child: Stack(
                    clipBehavior: Clip.none,
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("assets/images/demo.jpg"),
                      ),
                      Positioned(
                          bottom: 0,
                          right: -25,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 2.0,
                            fillColor: Color(0xFFF5F6F9),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                            ),
                            padding: EdgeInsets.all(5.0),
                            shape: CircleBorder(),
                          )),
                    ],
                  ),
                )),
                SizedBox(height: 20),
                const Text(
                  'Enter full name:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                InputField(
                  hintText: 'Name',
                  suffixIcon: const SizedBox(),
                  controller: nameController,
                ),
                SizedBox(height: 16),
                const Text(
                  'Enter Identity:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                InputField(
                  hintText: 'CNIC',
                  suffixIcon: const SizedBox(),
                  controller: cnicController,
                ),
                SizedBox(height: 16),
                const Text(
                  'Enter full address:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                InputField(
                  hintText: 'Address',
                  suffixIcon: const SizedBox(),
                  controller: addressController,
                ),
                SizedBox(height: 16),
                const Text(
                  'Select City:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                InputField(
                  hintText: 'City',
                  suffixIcon: const SizedBox(),
                  controller: cityController,
                ),
                SizedBox(height: 16),
                const Text(
                  'Enter Mobile Number:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                InputField(
                  hintText: 'Mobile Number',
                  suffixIcon: const SizedBox(),
                  controller: mobileNumberController,
                ),
                SizedBox(height: 16),
                const Text(
                  'Select Skill:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5),
                InputField(
                  hintText: 'Skill',
                  suffixIcon: const SizedBox(),
                  controller: skillController,
                ),
                SizedBox(height: 24),
                customButton(
                  title: "Save",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfessionalRegistrationScreen()));
                    // Navigate to the Edit Profile screen or show a modal to edit the profile
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
