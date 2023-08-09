import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/usersMode/screens/select_service.dart';
import '../../../Widget/worker_container.dart';
import '../../../models/user_model.dart';
import '../conversation_screen.dart';
import '../worker_list_screen.dart';
import '../worker_profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> workers = [];
  UserRepo userRepo = UserRepo();

  Future<List<dynamic>> fetchWorkerData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await userRepo
          .firestore
          .collection("Users")
          .where("isWorker", isEqualTo: true)
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
  void initState() {
    super.initState();
    fetchWorkerData();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: const Text(
            'Dashboard',
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversationsScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.message,
                color: Colors.grey.shade700,
                size: 30,
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
                } else {
                  workers = snapshot.data!;
                  UserModel recentWorker = workers[0];
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recent',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View all',
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          height: 180,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: Offset(0, 4),
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                               Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.asset(
                                  recentWorker.imagePath.toString(),
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recentWorker.name.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  recentWorker.skill.toString(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 18),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      recentWorker.rating.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                              SizedBox(
                                height: 20,
                              ),
                              InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkerProfileScreen(
                                    userId: recentWorker.userId.toString(),),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Center(
                                child: Text(
                              'View Profile',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            )),
                          ),
                        )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SelectService()));
                                },
                                child: Text('View all'))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 300,
                        child: GridView.count(
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(20.0),
                          children: <Widget>[
                            ServiceContainer(
                              icon: 'assets/icons/plumber.png',
                              name: 'Plumber',
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkerList(
                                          skill: 'Plumber',
                                        )));
                              },
                            ),
                            ServiceContainer(
                              icon: 'assets/icons/painter.png',
                              name: 'Painter',
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkerList(
                                          skill: 'Painter',
                                        )));
                              },
                            ),
                            ServiceContainer(
                              icon: 'assets/icons/electrician.png',
                              name: 'Electrician',
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkerList(
                                          skill: 'Electricians',
                                        )));
                              },
                            ),
                            ServiceContainer(
                              icon: 'assets/icons/cleaning.png',
                              name: 'Cleaning',
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkerList(
                                          skill: 'Cleaning',
                                        )));
                              },
                            ),
                            ServiceContainer(
                              icon: 'assets/icons/gardener.png',
                              name: 'Gardener',
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkerList(
                                          skill: 'Gardener',
                                        )));
                              },
                            ),
                            ServiceContainer(
                              icon: 'assets/icons/carpenter.png',
                              name: 'Carpenter',
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WorkerList(
                                          skill: 'Carpenter',
                                        )));
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Top Rated',
                              style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  'View all',
                                ))
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
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
                                      builder: (context) =>
                                          WorkerProfileScreen(userId: workerData.userId.toString()),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ));
  }
}

class ServiceContainer extends StatelessWidget {
  final String icon;
  final String name;
  final Function() ontap;

  const ServiceContainer(
      {required this.icon, required this.name, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade200,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(0, 4),
              blurRadius: 10.0,
            ),
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                icon,
                height: 45,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 16),
              )
            ]),
      ),
    );
  }
}
