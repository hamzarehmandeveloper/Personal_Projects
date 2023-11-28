import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  NumbersWidget(this.rating,this.numOfRating);

  double? rating;
  int? numOfRating;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildButton(rating.toString(), 'Rating'),
      buildDivider(),
      buildButton(numOfRating.toString(), 'Completed Works'),
    ],
  );
  Widget buildDivider() => Container(
    height: 24,
    child: const VerticalDivider(),
  );

  Widget buildButton(String value, String text) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 2),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      );
}