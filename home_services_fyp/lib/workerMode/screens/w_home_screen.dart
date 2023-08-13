import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/usersMode/screens/conversation_screen.dart';
import 'package:home_services_fyp/workerMode/screens/perposal_submission_screen.dart';
import '../../Constants.dart';
import '../../FireStore_repo/APIsCall.dart';
import '../../FireStore_repo/work_request_&_proposal_repo.dart';
import '../../Widget/input_field.dart';
import '../../Widget/richText.dart';
import '../../models/workRequestModel.dart';


class WHomePage extends StatefulWidget {
  const WHomePage({Key? key}) : super(key: key);

  @override
  _WHomePageState createState() => _WHomePageState();
}

class _WHomePageState extends State<WHomePage> {
  final TextEditingController searchController = TextEditingController();
  WorkRequestRepo requestRepo = WorkRequestRepo();
  List<dynamic> proposalList = [];


  @override
  void initState() {
    super.initState();
  }


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
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ConversationsScreen()));
            },
            icon: Icon(
              Icons.message,
              color: Colors.grey.shade700,
              size: 30,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.square(60),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: InputField(
              hintText: 'Search',
              suffixIcon: const SizedBox(),
              controller: searchController,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final updatePropodals = await requestRepo.fetchWorkRequestProposals(Constants.userModel!.userId);
          setState(() {
            proposalList = updatePropodals;
          });
        },
        child: FutureBuilder<List<dynamic>>(
            future: requestRepo.fetchWorkRequestProposals(Constants.userModel!.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data.'),
                );
              } else {
                proposalList = snapshot.data!;
                return ListView.builder(
                  itemCount: proposalList.length,
                  itemBuilder: (context, index) {
                    return ProposalListItem(proposal: proposalList[index],);
                  },
                );
              }
            }
        ),
      ),
    );
  }
}

class ProposalListItem extends StatelessWidget {
  final WorkRequestProposal proposal;

  ProposalListItem({super.key, required this.proposal});

  Timestamp setDate (){
    Timestamp prosaltime = proposal.timestamp;
    return prosaltime;
  }


  @override
  Widget build(BuildContext context) {
    print(proposal.location);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
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
              offset: const Offset(0, 6),
              blurRadius: 10.0,
            ),
          ],
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0, vertical: 10.0),
          title: Text(
            proposal.requestTitle.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              richText('Description: ',proposal.workDescription.toString()),
              const SizedBox(height: 5),
              richText('Location: ',proposal.location.toString()),
              const SizedBox(height: 4),
              richText('Date: ' ,setDate().toDate().toString()),
              const SizedBox(height: 4,),
              richText('Submitted by: ', proposal.proposerName.toString()),
              const SizedBox(height: 10,),
              /*Row(
                children: proposal.images.map((imageAddress) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Image.asset(imageAddress),
                    ),
                  );
                }).toList(),
              ),*/
            ],
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                JobDetailsScreen(workRequestdata: proposal,)));
          },
        ),
      ),
    );
  }
}

