import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import 'expenseCalculator_page.dart';

class DetailsPage extends StatefulWidget {
  final String carImage;
  final String carClass;
  final String carName;
  final String carPower;
  final int people;
  final int avg;

  const DetailsPage({
    Key? key,
    required this.carImage,
    required this.carClass,
    required this.carName,
    required this.carPower,
    required this.people,
    required this.avg
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          backgroundColor: const Color(0xfff8f8f8),
          iconTheme: const IconThemeData(
            color: Colors.black
          ),
          titleSpacing: 0,
          leadingWidth: size.width * 0.15,
          title: Text('Details',style: TextStyle(
            color: Colors.black,
            fontSize: size.width * 0.06,
            fontWeight: FontWeight.bold,
          ),),
          centerTitle: true,
        ),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Center(
        child: MainContainer(),
      ),
    );
  }

  Container MainContainer(){
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.height,
      decoration: const BoxDecoration(
        color: Color(0xfff8f8f8),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.width * 0.05,
          ),
          child: Stack(
            children: [
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color:  Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: Image.asset(
                          widget.carImage,
                          height: size.width * 0.5,
                          width: size.width * 0.8,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    widget.carName,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color(0xff3b22a1),
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    widget.carClass,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: const Color(0xff3b22a1),
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.02,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildStat(
                            UniconsLine.dashboard,
                            '${widget.carPower} KM',
                            'Power',
                            size
                        ),
                        buildStat(
                            UniconsLine.users_alt,
                            'People',
                            '( ${widget.people} )',
                            size
                        ),
                        buildStat(
                            UniconsLine.briefcase,
                            'Average',
                            '( ${widget.avg} / KM )',
                            size
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              buildSelectButton(size),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildStat(
      IconData icon, String title, String desc, Size size) {
    return SizedBox(
      height: size.width * 0.32,
      width: size.width * 0.25,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: size.width * 0.03,
            left: size.width * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: const Color(0xff3b22a1),
                size: size.width * 0.08,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.width * 0.02,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                desc,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Align buildSelectButton(Size size) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Padding(
      padding: EdgeInsets.only(
        bottom: size.height * 0.01,
      ),
      child: SizedBox(
        height: size.height * 0.07,
        width: size.width,
        child: InkWell(
          onTap: () {
            Get.to( DistanceCalculatorPage());
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff3b22a1),
            ),
            child: Align(
              child: Text(
                'Select',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
