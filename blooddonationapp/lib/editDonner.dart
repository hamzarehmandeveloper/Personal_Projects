

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:blooddonationapp/donnor_model.dart';

import 'DonnerList.dart';
import 'colors.dart';
import 'db_manager.dart';

class EditDonner extends StatefulWidget {
  int id;
  EditDonner({Key? key, required this.id}) : super(key: key);
  @override
  _EditDonnerState createState() => _EditDonnerState();
}

class _EditDonnerState extends State<EditDonner> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  String currentCategory = "";
  String lastDate = "";
  List<String> allCategoryData = [ "A+","A-","B+","B-","AB+","AB-","O","O-"];
  final dbHelper = DatabaseHelper.instance;


// INITIALIZE. RESULT IS A WIDGET, SO IT CAN BE DIRECTLY USED IN BUILD METHOD


  @override
  void initState() {
    super.initState();
    _query(widget.id);

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          centerTitle: true,
          title: const Text("Edit Donner"),
        ),
        body: ListView(
          children: [
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formGlobalKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'Name',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _firstName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter First Name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'Mobile Number',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _mobileNumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Mobile Number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.greenAccent, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: MyColors.primaryColor, width: 1.0),
                          ),
                          hintText: 'Address',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                        ),
                        controller: _address,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: MyColors.primaryColor),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            items: allCategoryData
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(value),
                                ),
                              );
                            }).toList(),
                            onChanged: (selectedItem) => setState(() {
                              currentCategory = selectedItem!;
                            }),
                            hint: const Text("Select Category "),
                            value: currentCategory.isEmpty ? null : currentCategory,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      TextButtonTheme(
                        data: TextButtonThemeData(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyColors.primaryColor),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            DatePicker.showDatePicker(context,
                                showTitleActions: true,
                                minTime: DateTime(2018, 3, 5),

                                theme: const DatePickerTheme(
                                    headerColor: MyColors.primaryColor,
                                    backgroundColor: Colors.white,
                                    itemStyle: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    doneStyle:
                                    TextStyle(color: Colors.white, fontSize: 16)),
                                onChanged: (date) {
                                  print('change $date in time zone ' +
                                      date.toString());
                                  lastDate= date.toString();
                                  setState(() {

                                  });
                                }, onConfirm: (date) {
                                  print('confirm $date');
                                  lastDate = date.toString();
                                  setState(() {

                                  });
                                }, currentTime: DateTime.now(), locale: LocaleType.en);
                          },
                          child: const Text(
                            "Pick Last Date",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      TextButtonTheme(
                        data: TextButtonThemeData(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                MyColors.primaryColor),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (formGlobalKey.currentState!.validate()) {
                              _update(widget.id);
                            }
                          },
                          child: const Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _insert() async {

    // row to insert
    Map<String, dynamic> row = {DatabaseHelper.columnName: _firstName.text,
      DatabaseHelper.columnLastDate: lastDate,
      DatabaseHelper.columnMobile: _mobileNumber.text,
      DatabaseHelper.columnAddress: _address.text,
      DatabaseHelper.columnCategory: currentCategory,
    };

    final id = await dbHelper.insertDonner(row);
    if (kDebugMode) {
      print('inserted row id: $id');
    }
    // _query();
    Navigator.push(context, MaterialPageRoute(builder: (_)=>DonnerList()));
  }

void _query(id) async {
  List<Map> result = await dbHelper.getDonner(id);
  if(result.isNotEmpty){
    DonnerModel donner = DonnerModel(
        id: result[0]["id"] ?? 0,
        name: result[0]["name"] ?? "",
        address: result[0]["address"] ?? "",
        mobile: result[0]["mobile"] ?? "",
        blood: result[0]["cat"] ?? "",
        lastDate: result[0]["email"] ?? "");

    _firstName.text = donner.name;
    _address.text = donner.address;
    _mobileNumber.text = donner.mobile;
    currentCategory = donner.blood;
    lastDate = donner.lastDate;
  }


  setState(() {});
}
  void _update(int rowId) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: _firstName.text,
      DatabaseHelper.columnLastDate: lastDate,
      DatabaseHelper.columnMobile: _mobileNumber.text,
      DatabaseHelper.columnAddress: _address.text,
      DatabaseHelper.columnCategory: currentCategory,
    };

    final id = await dbHelper.updateDonner(row:row,id: rowId);
    Navigator.pop(context);
  }
}


