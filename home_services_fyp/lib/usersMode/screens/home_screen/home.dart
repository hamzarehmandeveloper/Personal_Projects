import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/usersMode/screens/select_service.dart';
import '../../../Constants.dart';
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

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<dynamic> workers = [];
  UserRepo userRepo = UserRepo();
  TabController? _tabController;

  Future<List<dynamic>> fetchWorkerData() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await userRepo
          .firestore
          .collection("Users")
          .where("isWorker", isEqualTo: true)
          .where("userId", isNotEqualTo: Constants.userModel!.userId)
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
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    fetchWorkerData();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
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
                  return workers.isNotEmpty
                      ? Column(
                    mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  gradient: const LinearGradient(colors: [
                                    Color(0xff4338CA),
                                    Color(0xff6D28D9)
                                  ]),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: const Offset(0, 4),
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Welcome',
                                                style: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                Constants.userModel!.name
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                Constants.userModel!.city
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Colors.grey.shade400,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            child: CachedNetworkImage(
                                              imageUrl: Constants
                                                  .userModel!.imagePath!,
                                              fit: BoxFit.cover,
                                              width: 70,
                                              height: 70,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                'assets/images/demo.png',
                                                fit: BoxFit.cover,
                                                width: 70,
                                                height: 70,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, top: 10.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Recent',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        'View all',
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                height: 180,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: const Offset(0, 4),
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: CachedNetworkImage(
                                            imageUrl: recentWorker.imagePath!,
                                            fit: BoxFit.cover,
                                            width: 70,
                                            height: 70,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recentWorker.name.toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              recentWorker.skill.toString(),
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                  fontSize: 18),
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 20,
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  recentWorker.rating
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                WorkerProfileScreen(
                                              userId: recentWorker.userId
                                                  .toString(),
                                              showContactButton: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 49,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: const Center(
                                            child: Text(
                                          'View Profile',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Categories',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SelectService()));
                                      },
                                      child: const Text('View all'))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 300,
                              child: GridView.count(
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                                crossAxisCount: 3,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(20.0),
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
                            SizedBox(
                              width: double.infinity,
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  DefaultTabController(
                                    length: 6,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, right: 10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Top Rated',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => WorkerList(
                                                            skill: 'All',
                                                          )));
                                                },
                                                child: const Text(
                                                  'View all',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TabBar(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          indicatorSize: TabBarIndicatorSize.tab,
                                          controller: _tabController,
                                          isScrollable: true,
                                          indicatorColor: Colors.black,
                                          labelColor: Colors.white,
                                          unselectedLabelColor: Colors.black,
                                          indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            // Creates border
                                            color: Colors.black,
                                          ),
                                          tabs: const [
                                            Tab(
                                              text: 'All',
                                            ),
                                            Tab(
                                              text: 'Plumber',
                                            ),
                                            Tab(text: 'Painter'),
                                            Tab(text: 'Electrician'),
                                            Tab(text: 'Cleaning'),
                                            Tab(text: 'Carpenter'),
                                          ],
                                        ),
                                        ListView(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          children: [
                                          SizedBox(
                                            height: 400,
                                            child: TabBarView(
                                              physics: const NeverScrollableScrollPhysics(),
                                              controller: _tabController,
                                              children: [
                                                _buildTopRatedList(workers,'All'),
                                                _buildTopRatedList(workers,'Plumber'),
                                                _buildTopRatedList(workers,'Painter'),
                                                _buildTopRatedList(workers,'Electrician'),
                                                _buildTopRatedList(workers,'Cleaning'),
                                                _buildTopRatedList(workers,'Carpenter'),
                                              ],
                                            ),
                                          ),
                                        ]
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                      : const Center(
                          child: Text('No data Found'),
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
      {super.key, required this.icon, required this.name, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade200,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 4),
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
              const SizedBox(
                height: 10,
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 16),
              )
            ]),
      ),
    );
  }
}

Widget _buildTopRatedList(List<dynamic> workers, String skill) {
  List<dynamic> filteredWorkers = (skill != 'All') ? workers.where((worker) => worker.skill == skill).toList(): workers;
  filteredWorkers.sort((a, b) => b.rating!.compareTo(a.rating!));
  if (filteredWorkers.isEmpty) {
    return Center(
      child: Text('No workers available for $skill'),
    );
  }

  return ListView.builder(
    itemCount: filteredWorkers.length,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      UserModel workerData = filteredWorkers[index];
      return workerContainer(
        name: workerData.name.toString(),
        job: workerData.skill.toString(),
        image: workerData.imagePath.toString(),
        rating: workerData.rating!.toStringAsFixed(1),
        isWorker: true,
        ontap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkerProfileScreen(
                userId: workerData.userId.toString(),
                showContactButton: true,
              ),
            ),
          );
        },
      );
    },
  );
}


