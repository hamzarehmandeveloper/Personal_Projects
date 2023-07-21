import 'package:alsiraatapp/widgets/homePage/most_rented.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: const BoxDecoration(
            color: Color(0xfff8f8f8), //background color
          ),
          child: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: size.height * 0.04,
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    bottom: size.height * 0.04,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                      color: Colors.white, //section bg color
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.04,
                          ),
                          child: const Align(
                            child: Text(
                              'Al-Sirat',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Align(
                          child: Text(
                            'Car Rental Services',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xff3b22a1),
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.04,),
                          child: Align(
                            child: Text(
                              'We offer the wheels, You bring the adventure',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xff3b22a1),
                                fontSize: size.width * 0.035,
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                buildMostRented(size),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
