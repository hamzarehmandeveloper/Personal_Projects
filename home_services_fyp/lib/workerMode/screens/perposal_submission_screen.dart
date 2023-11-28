import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/FireStore_repo/worker_proposal_repo.dart';
import 'package:home_services_fyp/models/workRequestModel.dart';
import 'package:home_services_fyp/models/worker_proposals_model.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';

import '../../Constants.dart';
import '../../FireStore_repo/APIsCall.dart';
import '../../Widget/custom_button.dart';
import '../../Widget/hours_counter.dart';
import '../../Widget/image_viewer.dart';
import '../../Widget/input_field.dart';
import '../../Widget/richText.dart';
import '../../buttomBar/workerBottombar.dart';

class JobDetailsScreen extends StatefulWidget {
  WorkRequestProposal? workRequestdata;

  @override
  JobDetailsScreen({
    Key? key,
    required this.workRequestdata,
  }) : super(key: key);

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController completionTimeController =
      TextEditingController();
  UserRepo userRepo = UserRepo();
  WorkerProposalRepo proposalRepo = WorkerProposalRepo();

  void showSubmittedPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          icon: Lottie.asset(
            'assets/lottie_animation/submitted.json',
            width: 100,
            height: 100,
            repeat: false,
          ),
          title: const Text('Submitted'),
          content: const Text(
            'Your Perposal has been submitted.',
          ),
          alignment: Alignment.centerLeft,
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkerTabContainer()));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> updateSubmittedByWorkerIds(String? currentUserId) async {
    try {
      final proposalRef = FirebaseFirestore.instance
          .collection('WorkRequests')
          .doc(widget.workRequestdata!.proposalRequestId);
      final proposalSnapshot = await proposalRef.get();
      final existingWorkerIds = List<String>.from(
          proposalSnapshot.data()!['proposalSubmittedByWorkerIds'] ?? []);
      if (!existingWorkerIds.contains(currentUserId)) {
        existingWorkerIds.add(currentUserId!);
      }
      await proposalRef
          .update({'proposalSubmittedByWorkerIds': existingWorkerIds});
      print('proposal Submitted by worker ID successfully');
    } catch (e) {
      print('Error while updating submit worker IDs $e');
    }
  }

  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if( _counter > 1){
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Job Details',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: LoaderOverlay(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade200,
                      width: 2.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(0, 6),
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.workRequestdata!.requestTitle.toString(),
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        richText('Description: ',
                            widget.workRequestdata!.workDescription.toString()),
                        const SizedBox(height: 16),
                        richText('City: ',
                            widget.workRequestdata!.location.toString()),
                        const SizedBox(height: 16),
                        Row(
                          children: widget.workRequestdata!.imageUrls!
                              .map((imageAddress) {
                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FullScreenImagePage(
                                                    imageUrl: imageAddress,
                                                  )));
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: imageAddress,
                                      fit: BoxFit.cover,
                                      width: 128,
                                      height: 128,
                                      placeholder: (context, url) =>
                                          new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          new Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter rate for work completion',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                InputField(
                  hintText: 'Rate',
                  suffixIcon: const SizedBox(),
                  controller: rateController,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter material required for complete work',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                InputField(
                  hintText: 'Material',
                  suffixIcon: const SizedBox(),
                  controller: materialController,
                ),
                const SizedBox(height: 16),
                CounterWidget(
                  value: _counter,
                  onDecrement: _decrementCounter,
                  onIncrement: _incrementCounter,
                ),
                const SizedBox(height: 16),
                customButton(
                  title: "Submit",
                  fontSize: 18,
                  onTap: () async {
                    context.loaderOverlay.show();
                    WorkerProposalModel rproposal = WorkerProposalModel(
                      proposerId: widget.workRequestdata!.proposerId,
                      proposerName: widget.workRequestdata!.proposerName,
                      proposerDeviceToken:
                          widget.workRequestdata!.proposerDeviceToken,
                      location: Constants.userModel!.city,
                      workRequestPostId:
                          widget.workRequestdata!.proposalRequestId,
                      workDescription: widget.workRequestdata!.workDescription,
                      selectedCategory:
                          widget.workRequestdata!.selectedCategory,
                      imageUrls: widget.workRequestdata!.imageUrls,
                      workerName: Constants.userModel!.name,
                      workerID: Constants.userModel!.userId,
                      workerDeviceToken: Constants.userModel!.userToken,
                      proposalTitle: widget.workRequestdata!.requestTitle,
                      material: materialController.text.trim(),
                      rate: rateController.text.trim(),
                      timestamp: widget.workRequestdata!.timestamp,
                      estimatedTime: _counter.toString(),
                    );
                    print(rproposal.proposalId);
                    await proposalRepo.storeWorkRequestProposal(rproposal);

                    updateSubmittedByWorkerIds(Constants.userModel!.userId);

                    APIsCall.sendNotification(
                        '${Constants.userModel!.name} Just submitted proposal on your work request: ${widget.workRequestdata!.requestTitle}',
                        widget.workRequestdata!.proposerDeviceToken,
                        'Proposal Received');
                    context.loaderOverlay.hide();
                    showSubmittedPopup();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
