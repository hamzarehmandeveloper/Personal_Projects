import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/models/user_model.dart';
import '../../Widget/custom_button.dart';
import '../../adminMode/admin-home.dart';
import '../../adminMode/adminWidget/admin-customButton.dart';
import '../../adminMode/list-user-workRequests.dart';
import '../../models/worker_review_model.dart';
import 'chat_screen.dart';

class WorkerProfileScreen extends StatefulWidget {
  late final String userId;
  bool? showContactButton;
  bool? isWorker;
  bool? showButtons;

  WorkerProfileScreen({
    required this.userId,
    this.showContactButton,
    this.isWorker,
    this.showButtons
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

  void showDeleteConfirmationDialog(BuildContext context, String userID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text('Delete User'),
          content: const Text('Are you sure you want to delete this User?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deleteUser(userID);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteUser(String userID) async {
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userID)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User deleted deleted.')),
      );
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => AdminHomeScreen()), (Route<dynamic> route) => false);
    } catch (e) {
      print('Error deleting user: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete user.')),
      );
    }
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
        title: Text(
          widget.isWorker! ? 'Worker Profile' : 'User Profile',
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
              return workerProfile != null
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 10.0, right: 10.0),
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
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 10,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      ClipOval(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: CachedNetworkImage(
                                            imageUrl: workerProfile!.imagePath!,
                                            fit: BoxFit.cover,
                                            width: 169,
                                            height: 169,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Image.asset(
                                              'assets/images/demo.png',
                                              fit: BoxFit.cover,
                                              width: 170,
                                              height: 170,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    workerProfile!.name.toString(),
                                    style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    workerProfile!.skill.toString(),
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                  const SizedBox(height: 8),
                                  widget.isWorker == true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.star,
                                                color: Colors.yellow, size: 24),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Rating: ${(workerProfile!.rating?.toStringAsFixed(1))} (${(workerProfile!.numOfRatings.toString())})',
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ],
                                        )
                                      : Text(
                                          'City: ${workerProfile!.city}',
                                          style: const TextStyle(fontSize: 18),
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
                              width: MediaQuery.of(context).size.width * 1,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(0, 4),
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                              child: widget.isWorker!
                                  ? Text(
                                      workerProfile!.about.toString(),
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    )
                                  : Text(
                                      'Email : ${workerProfile!.email.toString()}',
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                            ),
                            const SizedBox(height: 20),

                            widget.isWorker == true || widget.showButtons == true ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: 60,
                                      child: AdminCustomButton(
                                        title: 'Delete Profile',
                                        fontSize: 18,
                                        color: Colors.red,
                                        onTap: () {
                                          showDeleteConfirmationDialog(context, widget.userId);
                                        },
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: 60,
                                      child: AdminCustomButton(
                                        title: 'See Activity',
                                        fontSize: 18,
                                        color: Colors.black,
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ListWorkRequests(UserID: workerProfile!.userId)));
                                        },
                                      )),
                                ),
                              ],
                            ): SizedBox(),

                            const SizedBox(height: 20),

                            widget.isWorker!
                                ? const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Past Work Review',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : SizedBox(),
                            const SizedBox(height: 20),
                            widget.isWorker!
                                ? Column(
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
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: reviews.length,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              itemBuilder: (context, index) {
                                                final message = reviews[index];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 5.0),
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          radius: 15,
                                                          child: Image.asset(
                                                              'assets/images/demo.png'),
                                                        ),
                                                        Flexible(
                                                          child: ConstrainedBox(
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.9,
                                                            ),
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      12.0),
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          8.0,
                                                                      left: 8.0,
                                                                      right:
                                                                          8.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            4),
                                                                    blurRadius:
                                                                        10.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      message
                                                                          .proposerName
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                  Text(
                                                                    message
                                                                        .userReview
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black),
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
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Text('User Not Found'),
                    );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: (widget.showContactButton == true)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 60,
                    child: customButton(
                      title: 'Contact',
                      fontSize: 18,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagingScreen(
                                      receiverID: workerProfile!.userId ?? "",
                                      receiverName: workerProfile!.name,
                                      receiverImagePath:
                                          workerProfile!.imagePath,
                                      receiverToken: workerProfile!.userToken,
                                    )));
                      },
                    )),
              )
            : SizedBox(),
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
