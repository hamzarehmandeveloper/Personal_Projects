import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/adminMode/record-list.dart';
import '../FireStore_repo/admin_repo.dart';
import '../models/user_model.dart';
import '../usersMode/screens/worker_list_screen.dart';
import 'catagory-list.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  AdminRepo adminRepo = AdminRepo();
  int totalUsers = 0;
  List<UserModel> allData = [];
  List<UserModel> workers = [];
  List<UserModel> users = [];

  Future<List<UserModel>> fetchWorkerData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection("Users")
              .where("isWorker", isEqualTo: true)
              .get();

      final workers = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data(), doc.id))
          .toList();
      print(workers.length);
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
        automaticallyImplyLeading: false,
        title: const Text('Admin Panel'),
        actions: [
          GestureDetector(
            onTap: () {
              adminRepo.adminSignOut();
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.exit_to_app_rounded),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final updatedWorkers = await fetchWorkerData();
          setState(() {
            workers = updatedWorkers;
          });
        },
        child: FutureBuilder<List<UserModel>>(
          future: fetchWorkerData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              allData = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      margin: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 14),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: const Text(
                          'Welcome to Admin Panel',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RecordList(
                                          isWorker: false,
                                        )));
                              },
                              child: gridContainer(context, 'Manage Users')),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CategoryList()));
                              },
                              child: gridContainer(context, 'Manage Workers')),
                        ])
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget gridContainer(BuildContext context, String title) {
  return Container(
    height: 100,
    width: MediaQuery.of(context).size.width * 0.4,
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.grey,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 5,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}
// ... (Remaining code for UserCard and WorkerCard)
