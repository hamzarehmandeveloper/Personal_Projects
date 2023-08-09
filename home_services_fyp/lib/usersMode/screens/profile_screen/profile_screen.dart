import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/profile.dart';
import 'package:home_services_fyp/usersMode/screens/profile_screen/user_edit_profile.dart';
import '../../../Constants.dart';
import '../../../FireStore_repo/user_repo.dart';
import '../../../Widget/button.dart';
import '../../../buttomBar/workerBottombar.dart';
import '../../../workerMode/screens/worker_edit_profile_screen.dart';
import '../login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserRepo userRepo = UserRepo();

  @override
  void initState() {
    super.initState();
  }

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
                            builder: (context) => UserEditProfile(
                              name: Constants.userModel?.name,
                              email: Constants.userModel?.email,
                              imagePath: Constants.userModel?.imagePath,
                              city: Constants.userModel?.city,
                            )),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  buildName(Constants.userModel?.name, Constants.userModel?.email),
                  const SizedBox(height: 24),
                  Center(
                    child: ButtonWidget(
                      text: 'Register as worker',
                      onClicked: () async {
                        if (Constants.userModel?.isWorker == false) {
                          try {
                            bool isWorker = true;
                            print(Constants.userModel?.isWorker);
                            await userRepo.firestore
                                .collection('Users')
                                .doc(userRepo.currentUser)
                                .update({
                              "isWorker": isWorker,
                            }).whenComplete(() async {
                              print("updated");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WorkerEditProfileScreen()));
                              Constants.userModel = (await userRepo.fetchUserData())!;
                            });
                          } catch (e) {
                            print('Error updating user data: $e');
                          }
                        } else {
                          userRepo.firestore
                              .collection("Users")
                              .where("isWorker", isEqualTo: true)
                              .get()
                              .then(
                                (querySnapshot) {
                              print("Successfully completed");
                              for (var docSnapshot
                              in querySnapshot.docs) {
                                print(
                                    '${docSnapshot.id} => ${docSnapshot.data()}');
                              }
                            },
                            onError: (e) =>
                                print("Error completing: $e"),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WorkerTabContainer()));
                        }
                      },),
                  ),
                  const SizedBox(height: 48),
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
                      onTap: () async {
                        await userRepo.signOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
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

Widget buildName(String? userName, String? userEmail) => userName != null
    ? Column(
        children: [
          Text(
            userName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            userEmail!,
            style: TextStyle(color: Colors.grey),
          )
        ],
      )
    : CircularProgressIndicator();
