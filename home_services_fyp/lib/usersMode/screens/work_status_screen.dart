import 'package:flutter/material.dart';
import 'package:home_services_fyp/usersMode/screens/work_rating_screen.dart';

class WorkStatusScreen extends StatelessWidget {
  final bool isInProgress;

  const WorkStatusScreen({Key? key, required this.isInProgress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Work Status',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Color(0xff202124),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6bb8f6),
              Color(0xff0093e9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isInProgress ? Icons.timer : Icons.done,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 30),
              Text(
                isInProgress ? 'In Progress' : 'Completed',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 48,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RatingScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
