
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/models/user_model.dart';
import 'package:home_services_fyp/Widget/profile.dart';
import 'package:home_services_fyp/Widget/profile_edit_screens_textfield.dart';
import '../../../FireStore_repo/user_repo.dart';
import '../../../Widget/custom_button.dart';

class UserEditProfile extends StatefulWidget {
  String? email;
  String? name;
  String? imagePath;
  String? city;
  UserEditProfile({
    this.name,
    this.email,
    this.imagePath,
    this.city,
});
  @override
  _UserEditProfileState createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController fullnameController = TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  late User currentUser;
  UserRepo userRepo = UserRepo();


  @override
  void initState() {
    super.initState();

  }

  Future<void> fetchUserData(String userId) async {
    try {
      final Map<String, dynamic>? userData = await userRepo.getUserData(userId);
      if (userData != null) {
        UserModel user = UserModel.fromJson(userData, userId);
        print('User name: ${user.name}');
        print('User email: ${user.email}');
        // ... other fields
      } else {
        print('User data not found.');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          ProfileWidget(
            imagePath: widget.imagePath,
            isEdit: true,
            onClicked: () async {},
            email: widget.email,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: widget.name,
            controller: nameController,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'City',
            text: widget.city,
            controller: cityController,
          ),
          const SizedBox(height: 20),
          customButton(
            title: "Save",
            onTap: () async {
              final String name = nameController.text.trim();
              final String city = cityController.text.trim();
              print(currentUser.email);
              try {
                await userRepo.firestore.collection('Users').doc(currentUser.uid).update({
                  "name" : name!=""?name:widget.name,
                  "city" : city!=""?city:widget.city,
                }).whenComplete(() => print("updated"));
              } catch (e) {
                print('Error updating user data: $e');
              }
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}