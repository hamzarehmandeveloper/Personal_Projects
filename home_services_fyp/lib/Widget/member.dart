import 'package:flutter/material.dart';

class NumbersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      buildButton('4.8', 'Rating'),
      buildDivider(),
      buildButton('35', 'Completed Works'),
      buildDivider(),
      buildButton('50', 'Total Works'),
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