import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/models/user_model.dart';
import 'package:home_services_fyp/usersMode/screens/worker_profile_screen.dart';
import '../../FireStore_repo/user_repo.dart';
import '../../Widget/worker_container.dart';
import 'adminWidget/record-container.dart';

class RecordList extends StatefulWidget {
  final bool isWorker;
  final String? skill;


  RecordList({Key? key, required this.isWorker,this.skill}) : super(key: key);

  @override
  State<RecordList> createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  List<dynamic> record = [];

  UserRepo userRepo = UserRepo();

  Future<List<dynamic>> fetchAllWorkerData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await userRepo.firestore
          .collection("Users")
          .where("isWorker", isEqualTo: true)
          .get();

      final workers = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data(), doc.id))
          .toList();

      workers.sort((a, b) => b.rating!.compareTo(a.rating!));

      return workers;
    } catch (e) {
      print('Error fetching worker data: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchSelectedWorkerData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await userRepo
          .firestore
          .collection("Users")
          .where("skill", isEqualTo: widget.skill)
          .get();

      final workers = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data(), doc.id))
          .toList();

      workers.sort((a, b) => b.rating!.compareTo(a.rating!));

      return workers;
    } catch (e) {
      print('Error fetching worker data: $e');
      return [];
    }
  }

  Future<List<dynamic>> fetchAllUsersData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await userRepo
          .firestore
          .collection("Users")
          .where("isWorker", isEqualTo: false)
          .get();

      final users = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data(), doc.id))
          .toList();
      return users;
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
          widget.skill==null ? widget.isWorker? 'Workers List': 'Users List': widget.skill.toString(),
          style: const TextStyle(color: Colors.black, fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<dynamic>>(
          future: widget.skill==null ? widget.isWorker? fetchAllWorkerData(): fetchAllUsersData() : fetchSelectedWorkerData(),
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
              record = snapshot.data!;
              return record.isNotEmpty ? Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: record.length,
                    itemBuilder: (context, index) {
                      UserModel workerData = record[index];
                      return recordContainer(
                        name: workerData.name.toString(),
                        city: workerData.city.toString(),
                        job: workerData.skill.toString(),
                        image: workerData.imagePath.toString(),
                        rating: workerData.rating!.toStringAsFixed(1),
                        isWorker: widget.isWorker,
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkerProfileScreen(
                                userId: workerData.userId.toString(),
                                showContactButton: false,
                                isWorker: workerData.isWorker,
                                showButtons: true,
                              ),
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
    );
  }
}
