import 'package:flutter/material.dart';
import 'package:home_services_fyp/workerMode/screens/perposal_submission_screen.dart';

import '../../Widget/input_field.dart';
import '../../models/workRequestModel.dart';


class WHomePage extends StatefulWidget {
  const WHomePage({Key? key}) : super(key: key);

  @override
  _WHomePageState createState() => _WHomePageState();
}

class _WHomePageState extends State<WHomePage> {
  final TextEditingController searchController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: const Text(
            'Dashboard',
            style: TextStyle(color: Colors.black, fontSize: 28),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {

              },
              icon: Icon(
                Icons.person_2_rounded,
                color: Colors.grey.shade700,
                size: 30,
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.square(60),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hintText: 'Search',
                suffixIcon: const SizedBox(),
                controller: searchController,
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: requestModel.length,
          itemBuilder: (context, index) {
            return ProposalListItem(proposal: requestModel[index]);
          },
        ),
    );
  }
}

class ProposalListItem extends StatelessWidget {
  final WorkRequestModel proposal;

  const ProposalListItem({super.key, required this.proposal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade200,
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(0, 6),
            blurRadius: 10.0,
          ),
        ],
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          title: Text(
            proposal.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(proposal.description),
              const SizedBox(height: 4),
              Text("Location: ${proposal.location}"),
              Text("Date: ${proposal.date.toLocal()}"),
              const SizedBox(height: 10,),
              Row(
                children: proposal.images.map((imageAddress) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Image.asset(imageAddress),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> JobDetailsScreen(jobTitle :proposal.title,description: proposal.description,location: proposal.location,proposalImages: proposal.images,)));
          },
        ),
      ),
    );
  }
}
