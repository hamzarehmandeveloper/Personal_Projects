import 'package:flutter/material.dart';
import 'package:home_services_fyp/my_services/professional_worker_services.dart';
import 'package:home_services_fyp/my_services/service_finder_services.dart';

class MyServicesTab extends StatefulWidget {

  MyServicesTab();

  @override
  _MyServicesTabState createState() => _MyServicesTabState();
}

class _MyServicesTabState extends State<MyServicesTab> {
  late bool userType=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Services', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: userType != true
          ? ProfessionalWorkerServices()
          : ServiceFinderServices(),
    );
  }
}