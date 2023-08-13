import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/workerMode/screens/worker_progress_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../Constants.dart';
import '../../models/workRequestModel.dart';
import '../../models/worker_proposals_model.dart';

class WorkerServices extends StatefulWidget {
  const WorkerServices({super.key});

  @override
  State<WorkerServices> createState() => _WorkerServicesState();
}

class _WorkerServicesState extends State<WorkerServices>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<WorkerProposalModel> acceptedRequests = [];
  List<WorkerProposalModel> pendingRequests = [];

  @override
  void initState() {
    super.initState();
    print('hello');
    _tabController = TabController(length: 2, vsync: this);
    init();
    print('hello');
  }

  init() async {
    acceptedRequests = await fetchAcceptedWorkData();
    pendingRequests = await fetchPendingWorkData();
    print(acceptedRequests);
    print(pendingRequests);
  }


  Future<List<WorkerProposalModel>> fetchAcceptedWorkData() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('WorkerProposals')
          .where('workerID', isEqualTo: Constants.userModel!.userId)
          .where('isAccept', isEqualTo: true)
          .get();

      final workerProposals = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return WorkerProposalModel.fromJson(data, doc.id);
      }).toList();
      print('fecthed Successfully');
      return workerProposals;
    } catch (e) {
      print('Error fetching worker data: $e');
      return [];
    }
  }
  Future<List<WorkerProposalModel>> fetchPendingWorkData() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('WorkerProposals')
          .where('workerID', isEqualTo: Constants.userModel!.userId)
          .where('isAccept', isEqualTo: false)
          .get();

      final workerProposals = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return WorkerProposalModel.fromJson(data, doc.id);
      }).toList();
      print('fetched Successfully');

      return workerProposals;
    } catch (e) {
      print('Error fetching worker data: $e');
      return [];
    }
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Services',
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 30),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Tab(
                    child: Text(
                      'In Progress',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Tab(
                    child: Text(
                      'Pending',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    )),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        RefreshIndicator(
          onRefresh: () async {
            final updatedAcceptedProposal = await fetchAcceptedWorkData();
            final updatedPendingProposal = await fetchPendingWorkData();
            setState(() {
              acceptedRequests = updatedAcceptedProposal;
              pendingRequests = updatedPendingProposal;
            });
          },
          child: ListView.builder(
            itemCount: acceptedRequests.length,
            itemBuilder: (context, index) {
              print(index);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    title: Text(
                        acceptedRequests[index].proposalTitle.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                          acceptedRequests[index].workDescription.toString(),
                          style: TextStyle(color: Colors.black)),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WorkerSideWorkStatusScreen(
                                proposalId: acceptedRequests[index].proposalId.toString(),
                              )));
                      ;
                    },
                  ),
                ),
              );
            },
          ),
        ),
        RefreshIndicator(
          onRefresh: () async {
            final updatedAcceptedProposal = await fetchAcceptedWorkData();
            final updatedPendingProposal = await fetchPendingWorkData();
            setState(() {
              acceptedRequests = updatedAcceptedProposal;
              pendingRequests = updatedPendingProposal;
            });
          },
          child: ListView.builder(
            itemCount: pendingRequests.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                    title: Text(
                        pendingRequests[index].proposalTitle.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                          pendingRequests[index].workDescription.toString(),
                          style: TextStyle(color: Colors.black)),
                    ),
                    onTap: () {
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProposalSelectionScreen(proposalProposalId: pendingRequests[index].proposalRequestId.toString(),)));*/
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

