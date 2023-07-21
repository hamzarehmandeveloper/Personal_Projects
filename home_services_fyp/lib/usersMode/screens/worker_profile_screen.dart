import 'package:flutter/material.dart';

import '../../Widget/custom_button.dart';
import 'chat_screen.dart';

class WorkerProfileScreen extends StatelessWidget {
  final List<dynamic> workerData;

  WorkerProfileScreen({required this.workerData});

  @override
  Widget build(BuildContext context) {
    String name = workerData[0];
    String occupation = workerData[1];
    String image = workerData[2];
    double rating = workerData[3];

    final List<workerReviewsModel> reviews = [
      workerReviewsModel(
          user: 'hamza',
          reviewText:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
      workerReviewsModel(
          user: 'hamza',
          reviewText:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
      workerReviewsModel(
          user: 'hamza',
          reviewText:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
      workerReviewsModel(
          user: 'hamza',
          reviewText:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Worker Profile',style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 5),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 170,
                        width: 170,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 90,
                        backgroundImage: AssetImage(image),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    name,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    occupation,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 24),
                      SizedBox(width: 5),
                      Text(
                        'Rating: $rating',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'About',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Past Work Review',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviews.length,
                  padding: const EdgeInsets.all(8.0),
                  itemBuilder: (context, index) {
                    final message = reviews[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 15,
                              child: Image.asset('assets/images/demo.png'),
                            ),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.9,
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  margin: const EdgeInsets.only(
                                      bottom: 8.0, left: 8.0, right: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          message.user,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        message.reviewText,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: 60,
              child: customButton(
                title: 'Contact',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MessagingScreen(workerName: name, workerImage: 'assets/images/demo.png',)));
                },
              )),
        ),
      ),
    );
  }
}

Widget skillTextContainer(String skillname) {
  return Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10)),
    child: Text(
      skillname,
      style: const TextStyle(fontSize: 12, color: Colors.black),
    ),
  );
}

class workerReviewsModel {
  late String user;
  late String reviewText;

  workerReviewsModel({required this.user, required this.reviewText});
}
