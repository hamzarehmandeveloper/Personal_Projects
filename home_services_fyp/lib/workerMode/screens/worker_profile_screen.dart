import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/profile.dart';
import 'package:home_services_fyp/models/worker_model.dart';
import 'package:home_services_fyp/usersMode/screens/profile_screen/user_edit_profile.dart';
import 'package:home_services_fyp/workerMode/screens/worker_edit_profile_screen.dart';
import '../../../Widget/button.dart';
import '../../../Widget/member.dart';
import '../../Constants.dart';
import '../../FireStore_repo/user_repo.dart';
import '../../buttomBar/buttombar.dart';
import '../../models/user_model.dart';

class WorkerProfile extends StatefulWidget {
  @override
  _WorkerProfileState createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  UserRepo userRepo = UserRepo();

  @override
  Widget build(BuildContext context) {
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
                    imagePath: Constants.userModel?.imagePath,
                    onClicked: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => WorkerEditProfileScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  buildName(Constants.userModel!),
                  const SizedBox(height: 24),
                  Center(
                    child: ButtonWidget(
                      text: 'Switch To User Mode',
                      onClicked: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabContainer()));
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  NumbersWidget(),
                  const SizedBox(height: 48),
                  buildAbout(context,Constants.userModel!),
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
                    child: ListTile(
                      leading: const Icon(
                        Icons.exit_to_app_rounded,
                        color: Colors.black,
                      ),
                      title: const Text('Log out'),
                      onTap: () => {},
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

Widget buildName(UserModel user) => Column(
      children: [
        Text(
          user.name.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email.toString(),
          style: TextStyle(color: Colors.grey),
        )
      ],
    );

Widget buildAbout(BuildContext context,UserModel user) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30.0),
  child:   Container(
        width: MediaQuery.of(context).size.width*0.9,
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
              user.about.toString(),
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
);
