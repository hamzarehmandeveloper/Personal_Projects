
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'db_manager.dart';

class AddDonner extends StatefulWidget {
  const AddDonner({Key? key}) : super(key: key);

  @override
  _AddDonnerState createState() => _AddDonnerState();
}

class _AddDonnerState extends State<AddDonner> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  String currentCategory = "";
  String lastDate = "";
  // var imageEncoded;
  List<String> allCategoryData = [ "A+","A-","B+","B-","AB+","AB-","O","O-"];
  final dbHelper = DatabaseHelper.instance;
  // late Future<Uint8List> imageBytes;
  // final SignatureController _controller = SignatureController(
  //   penStrokeWidth: 5,
  //   penColor: Colors.red,
  //   exportBackgroundColor: Colors.blue,
  // );

// INITIALIZE. RESULT IS A WIDGET, SO IT CAN BE DIRECTLY USED IN BUILD METHOD


  @override
  void initState() {
    super.initState();
    // _query();
    // var _signatureCanvas = Signature(
    //   controller: _controller,
    //   width: 300,
    //   height: 300,
    //   backgroundColor: Colors.lightBlueAccent,
    // );
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          centerTitle: true,
          title: const Text("Add Donner"),
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
                            if (formGlobalKey.currentState!.validate()) {
                              _insert();
                            }
                          },
                          child: const Text(
                            "Save",
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
      DatabaseHelper.columnMobile: _mobileNumber.text,
      DatabaseHelper.columnAddress: _address.text,
      DatabaseHelper.columnCategory: currentCategory,
    };

    final id = await dbHelper.insertDonner(row);
    if (kDebugMode) {
      print('inserted row id: $id');
    }
    // _query();
    Navigator.pop(context);
  }

  // void _query() async {
  //   final allRows = await dbHelper.queryAllRows();
  //   if (kDebugMode) {
  //     print('query all rows:');
  //   }
  //   for (var element in allRows) {
  //     allCategoryData.add(element["name"]);
  //   }
  //   setState(() {});
  // }
}
