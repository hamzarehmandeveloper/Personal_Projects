import 'package:flutter/material.dart';
import '../../Widget/custom_button.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.only(bottom: 50),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        width: MediaQuery.of(context).size.width * 1,
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("assets/images/demo.jpg"),
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Text(
                  'hamzarehman@gmail.com',
                  // Change this to the user's actual name
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: customButton(
                  title: "Register as worker",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()));
                    // Navigate to the Edit Profile screen or show a modal to edit the profile
                  },
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding:
                    const EdgeInsets.only(left: 15, right: 15, bottom: 7.5),
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
                            Icons.ios_share_sharp,
                            color: Colors.black,
                          ),
                          title: const Text('About'),
                          onTap: () => {},
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.star_border,
                            color: Colors.black,
                          ),
                          title: const Text('Leave a review'),
                          onTap: () => {},
                        ),
                        const Divider(),
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
