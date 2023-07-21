import 'dart:math';

import 'package:alsiraatapp/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import 'most_rented.dart';

Padding buildCar(int i, Size size, List<Car> cars) {
  final Car car = cars[i];
  return Padding(
    padding: EdgeInsets.only(
      right: size.width * 0.03,
    ),
    child: Center(
      child: SizedBox(
        height: size.width * 0.70,
        width: size.width * 0.9,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(
              size.width * 0.02,
            ),
            child: InkWell(
              onTap: () {
                Get.to(() => DetailsPage(
                      carImage: car.carImage,
                      carClass: car.carClass,
                      carName: car.carName,
                      carPower: car.carPower,
                      people: car.people,
                      avg: car.avg,
                    ));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * 0.01,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(pi),
                        child: Image.asset(
                          car.carImage,
                          height: size.width * 0.25,
                          width: size.width * 0.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.01,
                            ),
                            child: Text(
                              car.carName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color(0xff3b22a1),
                                fontSize: size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            car.carClass,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xff3b22a1),
                              fontSize: size.width * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: size.width * 0.025,
                          ),
                          child: SizedBox(
                            height: size.width * 0.1,
                            width: size.width * 0.1,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xff3b22a1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    10,
                                  ),
                                ),
                              ),
                              child: const Icon(
                                UniconsLine.arrow_circle_right,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
