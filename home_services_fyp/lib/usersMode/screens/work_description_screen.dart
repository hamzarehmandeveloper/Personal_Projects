import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/FireStore_repo/work_request_&_proposal_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../../Constants.dart';
import '../../Widget/custom_button.dart';
import '../../models/workRequestModel.dart';

class SubmitWorkScreen extends StatefulWidget {
  @override
  _SubmitWorkScreenState createState() => _SubmitWorkScreenState();
}

class _SubmitWorkScreenState extends State<SubmitWorkScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _workDescription;
  String? _selectedCategory;
  String? _workTitle;
  List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();
  WorkRequestRepo repo = WorkRequestRepo();

  Future<void> _pickImages() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _images = pickedImages;
      });
    }
  }

  UserRepo userRepo = UserRepo();

  @override
  void initState() {
    super.initState();
  }

  void _showSubmittedPopup() {
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
          content: const Text('Your work description has been submitted.'),
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
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
              child: Text(
                'Post job \nTo hire a worker',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ];
      },
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              const Text(
                'Enter work title',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Title",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff94959b),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter a work Title';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _workTitle = value;
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter work Description',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff94959b),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter a work description';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _workDescription = value;
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Select category',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  hint: const Text(
                    'Select a category',
                    style: TextStyle(color: Color(0xff94959b)),
                  ),
                  items: <String>[
                    'Cleaning',
                    'Plumber',
                    'Electrician',
                    'Painter',
                    'Carpenter',
                    'Gardener',
                    'Tailor',
                    'Maid',
                    'Driver',
                    'Cook',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (String? value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                  value: _selectedCategory,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please enter relevant image\nimage should be clear',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              TextButton.icon(
                onPressed: _pickImages,
                icon: const Icon(
                  Icons.photo_library,
                  color: Color(0xff94959b),
                ),
                label: const Text(
                  'Add Images',
                  style: TextStyle(color: Color(0xff94959b)),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: _images
                    .map(
                      (image) => SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.file(File(image.path)),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              customButton(
                title: 'Submit',
                onTap: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  print(_workDescription);

                  WorkRequestProposal wrproposal = WorkRequestProposal(
                    proposerId: userRepo.auth.currentUser!.uid,
                    proposerName: Constants.userModel!.name,
                    workDescription: _workDescription,
                    selectedCategory: _selectedCategory,
                    imageUrls: ['assets/icons/plumber.png', 'assets/icons/plumber.png'],
                    timestamp: Timestamp.now(),
                    requestTitle: _workTitle,
                    location: Constants.userModel!.city,
                    proposerDeviceToken: Constants.userModel!.userToken,
                  );
                  await repo.storeWorkRequestProposal(wrproposal);
                  _showSubmittedPopup();
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
