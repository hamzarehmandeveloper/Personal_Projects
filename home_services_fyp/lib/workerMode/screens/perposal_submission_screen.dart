import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/FireStore_repo/worker_proposal_repo.dart';
import 'package:home_services_fyp/models/workRequestModel.dart';
import 'package:home_services_fyp/models/worker_proposals_model.dart';
import 'package:lottie/lottie.dart';

import '../../Constants.dart';
import '../../FireStore_repo/APIsCall.dart';
import '../../Widget/custom_button.dart';
import '../../Widget/input_field.dart';
import '../../Widget/richText.dart';

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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
      body: Padding(
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
                      richText('Description: ',widget.workRequestdata!.workDescription.toString()),
                      const SizedBox(height: 16),
                      richText('City: ',widget.workRequestdata!.location.toString()),
                      /*Row(
                        children: widget.workRequestdata!.imageUrls.map((imageAddress) {
                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.asset(imageAddress),
                            ),
                          );
                        }).toList(),
                      ),*/
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InputField(
                hintText: 'Rate',
                suffixIcon: const SizedBox(),
                controller: rateController,
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 5),
              InputField(
                hintText: 'Material',
                suffixIcon: const SizedBox(),
                controller: materialController,
              ),
              const SizedBox(height: 16),
              customButton(
                title: "Submit",
                onTap: () async {
                  WorkerProposalModel rproposal = WorkerProposalModel(
                    proposerId: widget.workRequestdata!.proposerId,
                    proposerName: widget.workRequestdata!.proposerName,
                    proposerDeviceToken: widget.workRequestdata!.proposerDeviceToken,
                    location: Constants.userModel!.city,
                    workRequestPostId: widget.workRequestdata!.proposalRequestId,
                    workDescription: widget.workRequestdata!.workDescription,
                    selectedCategory: widget.workRequestdata!.selectedCategory,
                    imageUrls: widget.workRequestdata!.imageUrls,
                    workerName: Constants.userModel!.name,
                    workerID: Constants.userModel!.userId,
                    workerDeviceToken: Constants.userModel!.userToken,
                    proposalTitle: widget.workRequestdata!.requestTitle,
                    material: materialController.text.trim(),
                    rate: rateController.text.trim(),
                    timestamp: widget.workRequestdata!.timestamp,
                  );
                  print(rproposal.proposalId);
                  await proposalRepo.storeWorkRequestProposal(rproposal);
                  APIsCall.sendNotification(
                      '${Constants.userModel!.name} Just submitted proposal on your work request: ${widget.workRequestdata!.requestTitle}', widget.workRequestdata!.proposerDeviceToken, 'Proposal Received');
                  showSubmittedPopup();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
