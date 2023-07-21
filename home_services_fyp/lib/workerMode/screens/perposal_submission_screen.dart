import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../Widget/custom_button.dart';
import '../../Widget/input_field.dart';

class JobDetailsScreen extends StatefulWidget {
  final String jobTitle;
  final String description;
  final String location;
  final List<String> proposalImages;
  @override
  const JobDetailsScreen({
    Key? key,
    required this.jobTitle,
    required this.description,
    required this.location,
    required this.proposalImages,
  }) : super(key: key);
  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController materialController = TextEditingController();
  final TextEditingController completionTimeController = TextEditingController();


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
          content: const Text('Your Perposal has been submitted.',),
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
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text('Job Details',style: TextStyle(color: Colors.black),),
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
                        widget.jobTitle,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.location,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: widget.proposalImages.map((imageAddress) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.asset(imageAddress),
                            ),
                          );
                        }).toList(),
                      ),
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
              InputField(
                hintText: 'Estimated Completion time',
                suffixIcon: const SizedBox(),
                controller: materialController,
              ),
              const SizedBox(height: 16),
              customButton(
                title: "Save",
                onTap: () {
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
