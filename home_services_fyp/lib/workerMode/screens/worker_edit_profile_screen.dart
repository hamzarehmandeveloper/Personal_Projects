import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import '../../../Widget/custom_button.dart';
import '../../Constants.dart';
import '../../FireStore_repo/user_repo.dart';
import '../../Widget/profile_edit_screens_textfield.dart';
import '../../buttomBar/workerBottombar.dart';
import 'dart:io';

class WorkerEditProfileScreen extends StatefulWidget {
  @override
  _WorkerEditProfileScreenState createState() =>
      _WorkerEditProfileScreenState();
}

class _WorkerEditProfileScreenState extends State<WorkerEditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  String skill='';
  final TextEditingController aboutController = TextEditingController();
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
    return FutureBuilder(
      future: userRepo.fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Text('Error fetching user data: ${snapshot.error}');
        } else {
          return SafeArea(
            child: Scaffold(
                body: LoaderOverlay(
                  child: NestedScrollView(
              headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                        child: Text(
                          'Register \nas a Worker',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ];
              },
              body: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const SizedBox(height: 10),
                    ProfileWidget(
                      imagePath: imageUrl,
                      isEdit: true,
                      onClicked: () async {
                        uploadProfilePic();
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Full Name',
                      text: Constants.userModel?.name,
                      onChanged: (name) {
                        print(name);
                      },
                      controller: nameController,
                    ),

                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'City',
                      text: Constants.userModel?.city,
                      onChanged: (name) {},
                      controller: cityController,
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Mobile Number',
                      text: Constants.userModel?.phoneNo,
                      onChanged: (name) {},
                      controller: mobileNumberController,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Skill',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xfff1f1f5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        hint: Text(
                          Constants.userModel!.skill == null ? 'Select a category': Constants.userModel!.skill.toString(),
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
                            skill = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                        value: skill.isNotEmpty ? skill : null,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'About',
                      text: Constants.userModel?.about,
                      maxLines: 5,
                      onChanged: (about) {},
                      controller: aboutController,
                    ),
                    const SizedBox(height: 24),
                    customButton(
                      title: "Save",
                      onTap: () async {
                        final String email = emailController.text.trim();
                        final String name = nameController.text.trim();
                        final String city = cityController.text.trim();
                        final String phoneNo = mobileNumberController.text.trim();
                        final String skillToAdd = skill;
                        final String about = aboutController.text.trim();
                        context.loaderOverlay.show();
                        print(userRepo.currentUser);
                        try {
                          await userRepo.firestore.collection('Users').doc(userRepo.currentUser).update({
                            "email": email!=""?email:Constants.userModel?.email,
                            "name" : name!=""?name:Constants.userModel?.name,
                            "city" : city!=""?city:Constants.userModel?.city,
                            "phoneNo" : phoneNo!=""?phoneNo:Constants.userModel?.phoneNo,
                            "skill" : skillToAdd!=""?skillToAdd:Constants.userModel?.skill,
                            "about" : about!=""?about:Constants.userModel?.about,
                          }).whenComplete(() {
                            context.loaderOverlay.hide();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WorkerTabContainer()));
                          });
                        } catch (e) {
                          context.loaderOverlay.hide();
                          print('Error updating user data: $e');
                        }
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
              ),
            ),
                )),
          );
        }
      },
    );
  }
}
