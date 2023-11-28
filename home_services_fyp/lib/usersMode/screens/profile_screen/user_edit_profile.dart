import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/profile.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Constants.dart';
import '../../../FireStore_repo/user_repo.dart';
import '../../../Validators.dart';
import '../../../Widget/custom_button.dart';
import '../../../Widget/input_field.dart';

class UserEditProfile extends StatefulWidget {
  const UserEditProfile({super.key});

  @override
  _UserEditProfileState createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  late User currentUser;
  UserRepo userRepo = UserRepo();
  String? imageUrl;
  String city='';
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
          const Text(
            'Enter Name',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          InputField(
            hintText: Constants.userModel!.name,
            suffixIcon: const SizedBox(),
            controller: nameController,
              textFieldValidator: (value) {
                if (!Validators().validateName(
                    nameController.text.trim())) {
                  return 'Please enter a valid name';
                } else {
                  return null;
                }
              }
          ),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            hint: const Text(
              'Select a City',
              style: TextStyle(color: Color(0xff94959b)),
            ),
            items: <String>[
              'Vehari',
              'Multan',
              'Lahore',
              'Karachi',
              'Islamabad',
              'Haroonabad',
              'Faisalabad',
              'Bahawalpur',
              'Rawalpindi',
              'Bahawalnager',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                city = value!;
              });
            },
            validator: (String? value) {
              if (value == null) {
                return 'Please select a city';
              }
              return null;
            },
            value: Constants.userModel!.city,
          ),
          const SizedBox(height: 20),
          customButton(
            title: "Save",
            fontSize: 18,
            onTap: () async {
              final String name = nameController.text.trim();
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
