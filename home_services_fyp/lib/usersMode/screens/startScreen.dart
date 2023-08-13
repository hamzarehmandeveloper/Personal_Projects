import 'package:flutter/material.dart';
import 'package:home_services_fyp/Constants.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import '../../Widget/custom_button.dart';
import '../../buttomBar/buttombar.dart';
import 'login_screen.dart';
import 'package:lottie/lottie.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  UserRepo userRepo = UserRepo();
  @override
  void initState() {
    super.initState();
    init();
  }
   init() async {
    Constants.userModel = (await userRepo.fetchUserData());
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            padding: const EdgeInsets.only(bottom: 15),
            height: 70,
            child: customButton(
              title: 'Get Start',
              onTap: () {
                if (Constants.userModel!=null){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TabContainer()));
                } else{
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.5,
              child: Lottie.asset(
                  'assets/lottie_animation/HomeServicesLogo.json',
                  ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight: Radius.circular(80),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Center(
                        child: Text(
                          'Easy, reliable way to take \ncare of your home',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Center(
                        child: Text(
                          'We provide you with the best people to help take care of your home.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
