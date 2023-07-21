import 'package:flutter/material.dart';
import '../../Widget/custom_button.dart';
import 'login_screen.dart';
import 'package:lottie/lottie.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            padding: EdgeInsets.only(bottom: 15),
            height: 70,
            child: customButton(
              title: 'Get Start',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight: Radius.circular(80),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 60),
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
                    SizedBox(
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
