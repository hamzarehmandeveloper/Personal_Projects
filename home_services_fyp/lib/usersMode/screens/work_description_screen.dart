import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/user_repo.dart';
import 'package:home_services_fyp/FireStore_repo/work_request_&_proposal_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import '../../Constants.dart';
import '../../Validators.dart';
import '../../Widget/custom_button.dart';
import '../../Widget/input_field.dart';
import '../../models/workRequestModel.dart';

class SubmitWorkScreen extends StatefulWidget {
  @override
  _SubmitWorkScreenState createState() => _SubmitWorkScreenState();
}

class _SubmitWorkScreenState extends State<SubmitWorkScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController(text: '');
  final TextEditingController descriptionController =
  TextEditingController(text: '');
  String? _selectedCategory;
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


  Future<List<String>?> _uploadImages(List<File> images) async {
    String uniqNum = DateTime.now().microsecondsSinceEpoch.toString();
    List<String> imageUrls = [];
    for (File imageFile in images) {
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('WorkRequestImages');
      Reference referenceImageToUpload = referenceDirImages.child('ProposalRequestPics$uniqNum');
      try {
        await referenceImageToUpload.putFile(imageFile);
        String imageUrl = await referenceImageToUpload.getDownloadURL();
        imageUrls.add(imageUrl);
        print('ImageURL: $imageUrl');
      } catch (error) {
        print('Error uploading image: $error');
      }
    }

    return imageUrls;
  }

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
        body: LoaderOverlay(
          child: NestedScrollView(
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
                InputField(
                  controller: titleController,
                  hintText: "Title",
                    textFieldValidator: (value) {
                      if (!Validators().validateName(
                          titleController.text.trim())) {
                        return 'Please enter a valid title';
                      } else {
                        return null;
                      }
                    }, suffixIcon: const SizedBox(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter work Description',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(
                      color: Color(0xff94959b),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))
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
                ),
                const SizedBox(height: 16),
                const Text(
                  'Select category',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
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
                        (image) => ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.file(File(image.path)),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                customButton(
                  title: 'Submit',
                  fontSize: 18,
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                      context.loaderOverlay.show();
                      List<String>? imageUrls = await _uploadImages(
                        _images.map((xFile) => File(xFile.path)).toList(),
                      );
                      WorkRequestProposal wrproposal = WorkRequestProposal(
                        proposerId: userRepo.auth.currentUser!.uid,
                        proposerName: Constants.userModel!.name,
                        workDescription: descriptionController.text.trim(),
                        selectedCategory: _selectedCategory,
                        imageUrls: imageUrls,
                        timestamp: Timestamp.now(),
                        requestTitle: titleController.text.trim(),
                        location: Constants.userModel!.city,
                        proposerDeviceToken: Constants.userModel!.userToken,
                      );
                      await repo.storeWorkRequestProposal(wrproposal);
                      context.loaderOverlay.hide();
                      _showSubmittedPopup();
                      titleController.clear();
                      descriptionController.clear();
                      setState(() {
                        _images = [];
                      });
                    }
                  },
                ),
              ],
            ),
          ),
      ),
    ),
        ));
  }
}
