import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class ProfessionalWorkerServices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Replace with the actual number of work requests
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Icon(MdiIcons.hammerWrench, color: Colors.black),
            title: Text('Work Request ${index + 1}',
                style: TextStyle(color: Colors.black)),
            subtitle: Text('Job description...', style: TextStyle(color: Colors.black)),
            onTap: () {
              // Add code to navigate to the work request details page
            },
          ),
        );
      },
    );
  }
}