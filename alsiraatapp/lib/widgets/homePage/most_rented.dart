import 'package:alsiraatapp/widgets/homePage/car.dart';
import 'package:flutter/material.dart';

Widget buildMostRented(Size size) {
  List<Car> cars = [
    Car(
      carImage: 'assets/images/yaris.png',
      carClass: 'Sedan',
      carName: 'Suzuki',
      carPower: '200 HP',
      people: 4,
      avg: 18,
    ),
    Car(
      carImage: 'assets/images/golf.png',
      carClass: 'SUV',
      carName: 'Suzuki',
      carPower: '250 HP',
      people: 6,
      avg: 16,

    ),
    // Add more cars as needed
  ];

  return Column(
    children: [
      Padding(
        padding: EdgeInsets.all(
          15
        ),
        child: SizedBox(
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: cars.length,
            itemBuilder: (context, i) {
              return buildCar(
                i,
                size,
                cars,
              );
            },
          ),
        ),
      ),
    ],
  );
}


class Car {
  final String carImage;
  final String carClass;
  final String carName;
  final String carPower;
  final int people;
  final int avg;

  Car({
    required this.carImage,
    required this.carClass,
    required this.carName,
    required this.carPower,
    required this.people,
    required this.avg,
  });
}
