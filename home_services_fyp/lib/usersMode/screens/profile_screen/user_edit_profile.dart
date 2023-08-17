import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/models/user_model.dart';
import 'package:home_services_fyp/Widget/profile.dart';
import 'package:home_services_fyp/Widget/profile_edit_screens_textfield.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Constants.dart';
import '../../../FireStore_repo/user_repo.dart';
import '../../../Widget/custom_button.dart';

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key});

  @override
  _UserEditProfileState createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController fullnameController =
      TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  late User currentUser;
  UserRepo userRepo = UserRepo();
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    setState(() {
      imageUrl = Constants.userModel!.imagePath;
    });
  }

  Future<void> uploadProfilePic() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file =
        await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');
    if (file != null) {
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('UserProfilePictures');
      Reference referenceImageToUpload =
          referenceDirImages.child('profilepicture${Constants.userModel!.name}');
      try {
        await referenceImageToUpload.putFile(File(file.path));
        setState(() async {
          imageUrl = await referenceImageToUpload.getDownloadURL();
        });

        print('ImageURL:  $imageUrl');
      } catch (error) {
        print(error);
      }
    }
    else {
      setState(() {
        imageUrl = Constants.userModel!.imagePath;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    print('imagePath : ${Constants.userModel!.imagePath}');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          ProfileWidget(
            imagePath: imageUrl,
            isEdit: true,
            onClicked: () async {
              await uploadProfilePic();
            },
            email: Constants.userModel!.email,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: Constants.userModel!.name,
            controller: nameController,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'City',
            text: Constants.userModel!.city,
            controller: cityController,
          ),
          const SizedBox(height: 20),
          customButton(
            title: "Save",
            onTap: () async {
              final String name = nameController.text.trim();
              final String city = cityController.text.trim();
              try {
                await userRepo.firestore
                    .collection('Users')
                    .doc(Constants.userModel!.userId)
                    .update({
                  "name": name != "" ? name : Constants.userModel!.name,
                  "city": city != "" ? city : Constants.userModel!.city,
                  "imagePath": imageUrl,
                }).whenComplete(() => print("updated"));
              } catch (e) {
                print('Error updating user data: $e');
              }
              Constants.userModel = await userRepo.fetchUserData();

              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
