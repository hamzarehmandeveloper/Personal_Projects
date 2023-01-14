import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:blooddonationapp/AddDonner.dart';
import 'package:blooddonationapp/donnor_model.dart';
import 'package:blooddonationapp/editDonner.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'colors.dart';
import 'db_manager.dart';

class DonnerList extends StatefulWidget {
  const DonnerList({Key? key}) : super(key: key);

  @override
  _DonnerListState createState() => _DonnerListState();
}

class _DonnerListState extends State<DonnerList> {
  final dbHelper = DatabaseHelper.instance;
  List<DonnerModel> donnerData = [];
  List<DonnerModel> searchData = [];

  @override
  void initState() {
    super.initState();
    _query();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: MyColors.primaryColor,
          title: Text("Donner list"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  List<dynamic> excelList = [];

                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    var bytes = file.readAsBytesSync();
                    var excel = Excel.decodeBytes(bytes);

                    for (var table in excel.tables.keys) {
                      for (var row in excel.tables[table]!.rows) {
                        print(row[2]);
                      }
                    }
                  } else {
                    // User canceled the picker
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.greenAccent, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: MyColors.primaryColor, width: 1.0),
                  ),
                  hintText: 'Search',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                onChanged: (value) {
                  search(value);
                },
              ),
            ),
            (searchData.isEmpty)
                ? Expanded(
                    child: ListView.builder(
                    itemCount: donnerData.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.red.withOpacity(0.4),
                                  blurRadius: 5,
                                  spreadRadius: 3,
                                  offset: const Offset(3, 3)),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                            child: Text(
                                          donnerData[index].name + " " + "(" + donnerData[index].blood + ")",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Row(
                                          children: [
                                            const Text(
                                              "Address : ",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              donnerData[index].address,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Last Date : ",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              donnerData[index].lastDate.substring(0,10),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 150,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          try {
                                            if (donnerData[index]
                                                .mobile
                                                .isNotEmpty) {
                                              donnerData[index].mobile =
                                                  donnerData[index]
                                                      .mobile
                                                      .replaceAll(" ", "");
                                              if (await UrlLauncher.canLaunch("tel:"+
                                                  donnerData[index].mobile)) {
                                                await UrlLauncher.launch("tel:"+
                                                    donnerData[index].mobile);
                                              }
                                            }
                                          } catch (e) {
                                            print('Cannot launch url');
                                          }
                                        },
                                        icon: Icon(
                                          Icons.phone,
                                          color: Colors.green,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditDonner(
                                                        id: donnerData[index]
                                                            .id),
                                              )).whenComplete(() => _query());
                                        },
                                        child: IconButton(
                                          onPressed: null,
                                          icon: Icon(Icons.edit),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _delete(donnerData[index].id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                      // var item = donnerData[index];
                      // return Container(
                      //   color: MyColors.orangeTile,
                      //   padding: EdgeInsets.zero,
                      //   margin: EdgeInsets.zero,
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           SizedBox(
                      //             width: 20,
                      //           ),
                      //           Text("${item.name}"),
                      //           Text("${item['lname']}"),
                      //           Spacer(),
                      //           IconButton(
                      //             onPressed: null,
                      //             icon: Icon(Icons.edit),
                      //           ),
                      //           IconButton(
                      //             onPressed: () {
                      //               _delete(item['_id']);
                      //             },
                      //             icon: Icon(Icons.delete),
                      //           ),
                      //         ],
                      //       ),
                      //       const Divider(
                      //         color: MyColors.orangeDivider,
                      //         thickness: 1,
                      //       ),
                      //     ],
                      //   ),
                      // );
                    },
                  ))
                : Expanded(
                    child: ListView.builder(
                    itemCount: searchData.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  blurRadius: 5,
                                  spreadRadius: 3,
                                  offset: const Offset(3, 3)),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FittedBox(
                                            child: Text(
                                          searchData[index].name + " " + "(" + searchData[index].blood + ")",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Address : ",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              searchData[index].address,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Last Date : ",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              searchData[index].lastDate.substring(0,10),
                                            ),
                                            // Text(timestampToLocaltime(donnerData[index].lastDate)
                                            //   ,
                                            // ),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(

                                  child: Row(
                                    children: [
                                      IconButton(
                                      onPressed: () async {
                                        try {
                                          if (searchData[index]
                                              .mobile
                                              .isNotEmpty) {
                                            searchData[index].mobile =
                                                searchData[index]
                                                    .mobile
                                                    .replaceAll(" ", "");
                                            if (await UrlLauncher.canLaunch("tel:"+
                                                searchData[index].mobile)) {
                                              await UrlLauncher.launch("tel:"+
                                                  searchData[index].mobile);
                                            }
                                          }
                                        } catch (e) {
                                          print('Cannot launch url');
                                        }
                                      },
                                      icon: Icon(
                                        Icons.phone,
                                        color: Colors.green,
                                      ),
                                    ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EditDonner(
                                                        id: searchData[index]
                                                            .id),
                                              )).whenComplete(() => _query());
                                        },
                                        child: const IconButton(
                                          onPressed: null,
                                          icon: Icon(Icons.edit),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          _delete(searchData[index].id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                      // var item = donnerData[index];
                      // return Container(
                      //   color: MyColors.orangeTile,
                      //   padding: EdgeInsets.zero,
                      //   margin: EdgeInsets.zero,
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           SizedBox(
                      //             width: 20,
                      //           ),
                      //           Text("${item.name}"),
                      //           Text("${item['lname']}"),
                      //           Spacer(),
                      //           IconButton(
                      //             onPressed: null,
                      //             icon: Icon(Icons.edit),
                      //           ),
                      //           IconButton(
                      //             onPressed: () {
                      //               _delete(item['_id']);
                      //             },
                      //             icon: Icon(Icons.delete),
                      //           ),
                      //         ],
                      //       ),
                      //       const Divider(
                      //         color: MyColors.orangeDivider,
                      //         thickness: 1,
                      //       ),
                      //     ],
                      //   ),
                      // );
                    },
                  ))
          ],
        ),
      ),
    );
  }

  void _query() async {
    donnerData.clear();
    final allRows = await dbHelper.queryAllRowsofDonner();

    allRows.forEach((e) {
      donnerData.add(DonnerModel(
          id: e["id"] ?? 0,
          name: e["name"] ?? "",
          address: e["address"] ?? "",
          mobile: e["mobile"] ?? "",
          blood: e["cat"] ?? "",
          lastDate: e["email"] ?? ""));
      print(donnerData);
    });
    setState(() {});
  }

  String timestampToLocaltime(String givenTime) {
    var dateTime = DateTime.parse(givenTime);
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

  void _delete(int id) async {
    donnerData.clear();
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.deleteDonner(id);
    print('deleted $rowsDeleted row(s): row $id');
    _query();
  }

  void search(String value) {
    searchData.clear();
    donnerData.forEach((element) {
      String searchString =
          "" + element.blood + element.address + element.name + element.mobile;
      if (searchString.toLowerCase().contains(value) && value.isNotEmpty) {
        searchData.add(element);
      }
    });
    if (searchData.isEmpty) {
      Fluttertoast.showToast(
          msg: "No Record Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    setState(() {});
  }
}
