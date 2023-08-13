import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/models/user_model.dart';
import 'package:home_services_fyp/usersMode/screens/worker_profile_screen.dart';
import '../../FireStore_repo/user_repo.dart';
import '../../Widget/worker_container.dart';

class WorkerList extends StatefulWidget {
  final String skill;

  WorkerList({Key? key, required this.skill}) : super(key: key);

  @override
  State<WorkerList> createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  List<dynamic> workers = [];

  UserRepo userRepo = UserRepo();

  Future<List<dynamic>> fetchWorkerData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await userRepo
          .firestore
          .collection("Users")
          .where("skill", isEqualTo: widget.skill)
          .get();

      final workers = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data(), doc.id))
          .toList();
      return workers;
    } catch (e) {
      print('Error fetching worker data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.skill,
          style: const TextStyle(color: Colors.black, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final updatedWorkers = await fetchWorkerData();
          setState(() {
            workers = updatedWorkers;
          });
        },
        child: SingleChildScrollView(
          child: FutureBuilder<List<dynamic>>(
            future: fetchWorkerData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data.'),
                );
              }
              else {
                workers = snapshot.data!;
                return workers.isNotEmpty ? Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: workers.length,
                      itemBuilder: (context, index) {
                        UserModel workerData = workers[index];
                        return workerContainer(
                          name: workerData.name.toString(),
                          job: workerData.skill.toString(),
                          image: workerData.imagePath.toString(),
                          rating: workerData.rating!.toStringAsFixed(1),
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkerProfileScreen(
                                    userId: workerData.userId.toString()),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ): const Center(
                  child: Text('No workers found for this category.'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
