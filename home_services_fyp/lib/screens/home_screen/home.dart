import 'package:home_services_fyp/animation/FadeAnimation.dart';
import 'package:home_services_fyp/models/service.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/screens/select_service.dart';

import '../../Widget/services_container.dart';
import '../../Widget/worker_container.dart';
import 'notification_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Service> services = [
    Service('Cleaning',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Plumber',
        'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Electrician',
        'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
    Service('Painter',
        'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Carpenter', 'https://img.icons8.com/fluency/2x/drill.png'),
    Service('Gardener',
        'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png'),
  ];

  List<dynamic> workers = [
    ['Hamza rehman', 'Plumber', 'assets/images/demo.jpg', 4.8],
    ['Usman Mushtaq', 'Cleaner', 'assets/images/demo.jpg', 4.6],
    ['Moiz Mazher', 'Driver', 'assets/images/demo.jpg', 4.4]
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
                        builder: (context) => NotificationsScreen()));
              },
              icon: Icon(
                Icons.notifications_none,
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
                                'assets/images/demo.jpg',
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
                                "Hamza Rehman",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Worker",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 18),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Center(
                            child: Text(
                          'View Profile',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectService()));
                        },
                        child: Text('View all'))
                  ],
                ),
              ),
              Container(
                height: 300,
                child: GridView.count(
                  crossAxisCount: 3,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(20.0),
                  children: const <Widget>[
                    ServiceContainer(icon: Icons.build, name: 'Plumber'),
                    ServiceContainer(icon: Icons.landscape, name: 'Landscaper'),
                    ServiceContainer(icon: Icons.flash_on, name: 'Electrical'),
                    ServiceContainer(icon: Icons.cleaning_services, name: 'Cleaning'),
                    ServiceContainer(icon: Icons.bug_report, name: 'Pest Control'),
                    ServiceContainer(icon: Icons.security, name: 'Security'),
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
              workerContainer(
                  name: workers[0][0],
                  job: workers[0][1],
                  image: workers[0][2],
                  rating: workers[0][3]),
              workerContainer(
                  name: workers[0][0],
                  job: workers[0][1],
                  image: workers[0][2],
                  rating: workers[0][3]),
              workerContainer(
                  name: workers[0][0],
                  job: workers[0][1],
                  image: workers[0][2],
                  rating: workers[0][3]),
              workerContainer(
                  name: workers[0][0],
                  job: workers[0][1],
                  image: workers[0][2],
                  rating: workers[0][3]),
              workerContainer(
                  name: workers[0][0],
                  job: workers[0][1],
                  image: workers[0][2],
                  rating: workers[0][3]),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}

class ServiceContainer extends StatelessWidget {
  final IconData icon;
  final String name;

  const ServiceContainer({required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 40.0),
          SizedBox(height: 10.0),
          Text(name, style: TextStyle(fontSize: 18.0)),
        ],
      ),
    );
  }
}
