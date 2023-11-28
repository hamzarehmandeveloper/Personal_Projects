import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final Function() onIncrement;
  final Function() onDecrement;

  CounterWidget(
      {required this.value,
      required this.onDecrement,
      required this.onIncrement});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 150,
          child: const Text('Number of hours to complete work?',style: TextStyle(
            fontSize: 15,
          ),),
        ),
        Container(
          width: 150,
          height: 50,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: onDecrement,
                customBorder: CircleBorder(),
                child: Icon(
                  Icons.remove,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 25,
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: onIncrement,
                customBorder: CircleBorder(),
                child: Icon(
                  Icons.add,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
