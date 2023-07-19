import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import '../Widget/custom_button.dart';
import '../animation/FadeAnimation.dart';

class SubmitWorkScreen extends StatefulWidget {
  @override
  _SubmitWorkScreenState createState() => _SubmitWorkScreenState();
}

class _SubmitWorkScreenState extends State<SubmitWorkScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _workDescription;
  String? _selectedCategory;
  List<XFile> _images = [];
  late final AnimationController _controller;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _images = pickedImages;
      });
    }
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
          title: Text('Submitted'),
          content: Text('Your work description has been submitted.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
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
              padding: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
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
            children: <Widget>[
              const Text(
                'Enter job descriptions',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff1f1f5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff94959b),
                    ),
                    border: const OutlineInputBorder(
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
              SizedBox(height: 16),
              const Text(
                'Select category',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff1f1f5),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  hint: Text(
                    'Select a category',
                    style: TextStyle(color: Color(0xff94959b)),
                  ),
                  items: <String>[
                    'House cleaners',
                    'Furniture assemblers',
                    'Painters',
                    'Electricians',
                    'Plumbers',
                    'HVAC technicians',
                    'Gardeners',
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
              SizedBox(height: 16),
              const Text(
                'Please enter relevant image\nimage should be clear',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              TextButton.icon(
                onPressed: _pickImages,
                icon: Icon(
                  Icons.photo_library,
                  color: Color(0xff94959b),
                ),
                label: Text(
                  'Add Images',
                  style: TextStyle(color: Color(0xff94959b)),
                ),
              ),
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              customButton(
                title: 'Submit',
                onTap: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  print(_workDescription);
                  // Handle form submission logic
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
