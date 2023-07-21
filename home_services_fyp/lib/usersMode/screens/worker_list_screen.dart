import 'package:flutter/material.dart';
import 'package:home_services_fyp/usersMode/screens/worker_profile_screen.dart';
import '../../Widget/worker_container.dart';

class WorkerList extends StatelessWidget {
  final String skill;

  WorkerList({Key? key, required this.skill}) : super(key: key);

  List<dynamic> workers = [
    ['Hamza Rehman', 'Plumber', 'assets/images/demo.png', 4.8],
    ['Usman Mushtaq', 'Cleaner', 'assets/images/demo.png', 4.6],
    ['Moiz Mazher', 'Driver', 'assets/images/demo.png', 4.4]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          skill,
          style: const TextStyle(color: Colors.black, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: workers.length,
        itemBuilder: (context, index) {
          List<dynamic> workerData = workers[index];
          return workerContainer(
            name: workerData[0],
            job: workerData[1],
            image: workerData[2],
            rating: workerData[3],
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkerProfileScreen(workerData: workerData),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
