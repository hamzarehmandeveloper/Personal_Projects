import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/profile.dart';
import 'package:home_services_fyp/usersMode/screens/profile_screen/user_edit_profile.dart';
import '../../../Widget/button.dart';
import '../../../Widget/member.dart';
import '../../../models/user_model.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Column(
                children: [
                  ProfileWidget(
                    imagePath: user.imagePath,
                    onClicked: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => UserEditProfile()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  buildName(user),
                  const SizedBox(height: 24),
                  Center(
                    child: ButtonWidget(
                      text: 'Register as worker',
                      onClicked: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfileScreen()));
                      },
                    ),
                  ),
                  /*const SizedBox(height: 24),
                  NumbersWidget(),*/
                  const SizedBox(height: 48),
                  buildAbout(user),
                  SizedBox(height: 24),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 7.5, top: 24),
                child: Material(
                  borderRadius: BorderRadius.circular(14.0),
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(0, 6),
                          blurRadius: 10.0,
                        ),
                      ],
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            Icons.warning_amber,
                            color: Colors.black,
                          ),
                          title: const Text('Report an issue'),
                          onTap: () => {},
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.exit_to_app_rounded,
                            color: Colors.black,
                          ),
                          title: const Text('Log out'),
                          onTap: () => {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildName(User user) => Column(
      children: [
        Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(color: Colors.grey),
        )
      ],
    );

Widget buildAbout(User user) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30.0),
  child:   Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(0, 4),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
);
