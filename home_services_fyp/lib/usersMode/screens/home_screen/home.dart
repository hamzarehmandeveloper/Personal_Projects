import 'package:flutter/material.dart';
import 'package:home_services_fyp/usersMode/screens/select_service.dart';
import '../../../Widget/worker_container.dart';
import '../conversation_screen.dart';
import '../worker_list_screen.dart';
import '../worker_profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> workers = [
    ['Hamza rehman', 'Plumber', 'assets/images/demo.png', 4.8],
    ['Usman Mushtaq', 'Cleaner', 'assets/images/demo.png', 4.6],
    ['Moiz Mazher', 'Driver', 'assets/images/demo.png', 4.4]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
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
                                workers[0][2],
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
                                workers[0][0],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                workers[0][1],
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
                                    workers[0][3].toString(),
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
                                  workerData: [
                                    workers[0][0],
                                    workers[0][1],
                                    workers[0][2],
                                    workers[0][3]
                                  ]),
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
                      name: 'Electrical',
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WorkerList(
                                      skill: 'Electrical',
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
                              builder: (context) =>
                                  WorkerProfileScreen(workerData: workerData),
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
