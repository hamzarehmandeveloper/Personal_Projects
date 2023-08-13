import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/models/user_model.dart';
import '../../Widget/custom_button.dart';
import '../../models/worker_review_model.dart';
import 'chat_screen.dart';

class WorkerProfileScreen extends StatefulWidget {
  final String userId;

  WorkerProfileScreen({
    required this.userId,
  });

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  UserRepo userRepo = UserRepo();
  UserModel? workerProfile;
  List<WorkerReviewModel> reviews = [];

  @override
  void initState() {
    super.initState();
    fetchReviews();
    //print( 'user name: ${(reviews[0].workerName)}');
  }

  Future<void> fetchReviews() async {
    List<WorkerReviewModel> fetchedReviews =
    await fetchWorkerReviews(widget.userId);
    setState(() {
      reviews = fetchedReviews;
      print(reviews);
    });
  }

  Future<List<WorkerReviewModel>> fetchWorkerReviews(String workerId) async {
    try {
      QuerySnapshot snapshot = await userRepo.firestore
          .collection('WorkerReviews')
          .where('workerID', isEqualTo: workerId)
          .get();
      List<WorkerReviewModel> reviews = snapshot.docs.map((doc) {
        print(doc);
        return WorkerReviewModel(
          proposerName: doc['proposerName'],
          userReview: doc['userReview'],
        );
      }).toList();
      print(reviews[0].proposerName);
      print('Reviews fetched');
      return reviews;
    } catch (e) {
      print('Error fetching worker reviews: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Worker Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchReviews,
        child: FutureBuilder(
          future: userRepo.fetchWorkerProfileData(widget.userId),
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
              workerProfile = snapshot.data;
              return workerProfile != null ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5),
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
                                  backgroundImage: AssetImage(
                                      workerProfile!.imagePath.toString()),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Text(
                              workerProfile!.name.toString(),
                              style: const TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              workerProfile!.skill.toString(),
                              style:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.yellow, size: 24),
                                const SizedBox(width: 5),
                                Text(
                                  'Rating: ${(workerProfile!.rating
                                      ?.toStringAsFixed(1))} (${(workerProfile!
                                      .numOfRatings.toString())})',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'About',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 1,
                        padding: const EdgeInsets.all(15),
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
                        child: Text(
                          workerProfile!.about.toString(),
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Past Work Review',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          reviews.isEmpty
                              ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'No reviews available for this worker.',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                              : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: reviews.length,
                            padding: const EdgeInsets.all(8.0),
                            itemBuilder: (context, index) {
                              final message = reviews[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 15,
                                        child: Image.asset(
                                            'assets/images/demo.png'),
                                      ),
                                      Flexible(
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width *
                                                0.9,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(
                                                12.0),
                                            margin: const EdgeInsets.only(
                                                bottom: 8.0,
                                                left: 8.0,
                                                right: 8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  20.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors
                                                      .grey.shade200,
                                                  offset: const Offset(0, 4),
                                                  blurRadius: 10.0,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Align(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  child: Text(
                                                    message.proposerName
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color:
                                                        Colors.black,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  message.userReview
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color:
                                                      Colors.black),
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
              ):const Center(child: Text('User Not Found'),);
            }
          },
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
                          builder: (context) =>
                              MessagingScreen(
                                receiverID: workerProfile!.userId ?? "",
                                name: workerProfile!.name,
                                receiverToken: workerProfile!.userToken,
                              )));
                },
              )),
        ),
      ),
    );
  }
}

Widget skillTextContainer(String skillname) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10)),
    child: Text(
      skillname,
      style: const TextStyle(fontSize: 12, color: Colors.black),
    ),
  );
}
