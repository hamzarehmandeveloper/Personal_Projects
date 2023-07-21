import 'package:flutter/material.dart';
import 'package:home_services_fyp/Widget/custom_button.dart';
import 'package:home_services_fyp/Widget/input_field.dart';

class ProfessionalRegistrationScreen extends StatefulWidget {
  @override
  _ProfessionalRegistrationScreenState createState() =>
      _ProfessionalRegistrationScreenState();
}

class _ProfessionalRegistrationScreenState
    extends State<ProfessionalRegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController pictureController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professional Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Enter your personal information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Name',
                  suffixIcon: const SizedBox(),
                  controller: nameController,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'CNIC',
                  controller: cnicController,
                  suffixIcon: const SizedBox(),
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Address',
                  suffixIcon: const SizedBox(),
                  controller: addressController,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'City',
                  suffixIcon: const SizedBox(),
                  controller: cityController,
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Country',
                  controller: countryController,
                  suffixIcon: const SizedBox(),
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Mobile Number',
                  controller: mobileController,
                  suffixIcon: const SizedBox(),
                ),
                const SizedBox(height: 20),
                InputField(
                  hintText: 'Picture',
                  suffixIcon: const SizedBox(),
                  controller: pictureController,
                ),
                const SizedBox(height: 40),
                Center(
                  child: customButton(
                    title: 'Submit',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Submit registration form
                        // Code to handle registration form submission
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
