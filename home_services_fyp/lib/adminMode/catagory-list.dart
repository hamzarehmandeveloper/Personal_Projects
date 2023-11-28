import 'package:flutter/material.dart';
import 'package:home_services_fyp/adminMode/record-list.dart';
import 'package:home_services_fyp/usersMode/screens/worker_list_screen.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String serviceImage = '';
  String serviceTitle = '';

  List<Service> services = [
    Service('Cleaning', 'assets/icons/cleaning.png'),
    Service('Plumber', 'assets/icons/plumber.png'),
    Service('Electrician', 'assets/icons/electrician.png'),
    Service('Painter', 'assets/icons/painter.png'),
    Service('Carpenter', 'assets/icons/carpenter.png'),
    Service('Gardener', 'assets/icons/gardener.png'),
    Service('Tailor', 'assets/icons/tailor.png'),
    Service('Maid', 'assets/icons/maid.png'),
    Service('Driver', 'assets/icons/driver.png'),
    Service('Cook', 'assets/icons/cook.png'),
  ];

  int selectedService = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 20.0,
                      mainAxisSpacing: 20.0,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: services.length,
                    itemBuilder: (BuildContext context, int index) {
                      return serviceContainer(
                          services[index].icon, services[index].name, index);
                    }),
              ),
            ]),
      ),
    );
  }

  serviceContainer(String icon, String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index)
            selectedService = -1;
          else
            selectedService = index;
          print(name);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RecordList(
                        isWorker: true,
                        skill: name,
                      )));
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
            width: 2.0,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 6),
              blurRadius: 10.0,
            ),
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(icon),
              const SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              )
            ]),
      ),
    );
  }
}

class Service {
  final String name;
  final String icon;

  Service(this.name, this.icon);
}
