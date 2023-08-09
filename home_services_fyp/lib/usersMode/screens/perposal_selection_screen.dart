import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/models/proposal_model.dart';
import 'package:home_services_fyp/usersMode/screens/progress_screen.dart';

import '../../Constants.dart';
import '../../models/worker_proposals_model.dart';

class ProposalSelectionScreen extends StatefulWidget {
  String proposalProposalId;
  ProposalSelectionScreen({super.key,
  required this.proposalProposalId,
  });

  @override
  _ProposalSelectionScreenState createState() =>
      _ProposalSelectionScreenState();
}

class _ProposalSelectionScreenState extends State<ProposalSelectionScreen> {
  int? _selectedIndex;
  List<dynamic> proposalData = [];


  Future<List<WorkerProposalModel?>> fetchPendingWorkData() async {
    List<WorkerProposalModel> workerProposals = [];
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('WorkerProposals')
          .where('proposerId', isEqualTo: Constants.userModel!.userId)
          .where('workRequestPostId', isEqualTo: widget.proposalProposalId)
          .get();

      final workerProposals = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return WorkerProposalModel.fromJson(data, doc.id);
      }).toList();
      /*print(widget.proposalProposalId);
      print(Constants.userModel!.userId);
      print(workerProposals[0].proposalId);
      print('fecthed Successfully');*/
      return workerProposals;
    } catch (e) {
      print('Error fetching worker data: $e');
      return [];
    }
  }

  Future<void> confirmOrder(String? proposalId, String? requestId) async {
    print('this is request ID $requestId');
    print('this is proposal ID $proposalId');
    try {
      await FirebaseFirestore.instance
          .collection('WorkerProposals')
          .doc(proposalId)
          .update({'isAccept': true});
      await FirebaseFirestore.instance
          .collection('WorkRequests')
          .doc(requestId)
          .update({'isAccept': true});
      print('accepted');
      setState(() {

      });
    } catch (e) {
      print('Error updating proposal: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Select Proposal',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<WorkerProposalModel?>>(
          future: fetchPendingWorkData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching data.'),
              );
            } else {
              proposalData = snapshot.data!;
              return proposalData.isNotEmpty ? ListView.builder(
                itemCount: proposalData.length,
                itemBuilder: (BuildContext context, int index) {
                  WorkerProposalModel proposal = proposalData[index];
                  Timestamp proposalTime = proposal.timestamp;
                  print(proposal.proposalId);
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
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
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UserSideWorkStatusScreen(
                                          proposalId: proposal.proposalId.toString(),
                                        )));
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                proposal.proposalTitle.toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Rate : ${(proposal.rate.toString())} Rs',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Material Required : ${(proposal.material)}',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Estimated Time : ${(proposalTime.toDate())}',
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: proposal.isAccept == true
                                    ? null
                                    : () => confirmOrder(proposal.proposalId,proposal.workRequestPostId),
                                child: Text('Confirm Order'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ): Center(
                child: Text('No proposal yet for this post'),
              );
            }
          }),
    );
  }
}
