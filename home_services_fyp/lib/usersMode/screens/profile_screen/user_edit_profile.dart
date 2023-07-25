
import 'package:flutter/material.dart';
import 'package:home_services_fyp/models/user_model.dart';
import 'package:home_services_fyp/Widget/profile.dart';
import 'package:home_services_fyp/usersMode/screens/profile_screen/widgets/textfield.dart';
import '../../../Widget/custom_button.dart';

class UserEditProfile extends StatefulWidget {
  @override
  _UserEditProfileState createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController fullnameController = TextEditingController(text: '');
  final TextEditingController aboutController = TextEditingController(text: '');
  User user = UserPreferences.myUser;
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
            imagePath: user.imagePath,
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: user.name,
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: user.email,
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: user.about,
            maxLines: 5,
            onChanged: (about) {},
          ),
          const SizedBox(height: 10),
          customButton(
            title: "Save",
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}