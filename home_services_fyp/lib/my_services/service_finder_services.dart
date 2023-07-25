import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../models/workRequestModel.dart';
import '../usersMode/screens/perposal_selection_screen.dart';
import '../usersMode/screens/progress_screen.dart';


class ServiceFinderServices extends StatelessWidget {
  ServiceFinderServices({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('My Services',style: TextStyle(color: Colors.black, fontSize: 28),),
      ),
      body: ListView.builder(
        itemCount: requestModel.length, // Replace with the actual number of service requests
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 2.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(0, 6),
                    blurRadius: 10.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: ListTile(
                leading: Icon(MdiIcons.briefcase, color: Colors.black),
                title: Text(requestModel[index].title,
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(requestModel[index].description, style: TextStyle(color: Colors.black)),
                ),
                onTap: () {
                  requestModel[index].orderStatus=='confirm'?Navigator.push(context, MaterialPageRoute(builder: (context)=> WorkStatusScreen(index: index,))):Navigator.push(context, MaterialPageRoute(builder: (context)=> ProposalSelectionScreen()));;
                },
              ),
            ),
          );
        },
      ),
    );
  }
}