import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/models/worker_proposals_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../Constants.dart';
import '../models/proposal_model.dart';
import '../models/user_model.dart';
import '../models/workRequestModel.dart';
import '../usersMode/screens/perposal_selection_screen.dart';
import '../usersMode/screens/progress_screen.dart';

class ServiceFinderServices extends StatefulWidget {
  ServiceFinderServices({
    super.key,
  });

  @override
  State<ServiceFinderServices> createState() => _ServiceFinderServicesState();
}

class _ServiceFinderServicesState extends State<ServiceFinderServices>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<WorkerProposalModel> acceptedRequests = [];
  List<WorkRequestProposal> pendingRequests = [];

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
    List<WorkerProposalModel> workerProposals = [];
    print(Constants.userModel!.isWorker.toString()+Constants.userModel!.userId!);
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('WorkerProposals')
          .where('proposerId', isEqualTo: Constants.userModel!.userId!)
          .where('isAccept', isEqualTo: true)
          .get();
      print('doc lenght : ${(querySnapshot.docs.length)}');

      final workerProposals = querySnapshot.docs.map((doc) {
        print(doc.data());
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

  Future<List<WorkRequestProposal>> fetchPendingWorkData() async {
    List<WorkRequestProposal> workerProposals = [];
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('WorkRequests')
          .where('proposerId', isEqualTo: Constants.userModel!.userId)
          .where('isAccept', isEqualTo: false)
          .get();

      final workerProposals = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return WorkRequestProposal.fromJson(data, doc.id);
      }).toList();
      print('feaaatched Successfully');

      return workerProposals;
    } catch (e) {
      print('Errorrrr fetching worker data: $e');
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
          child: FutureBuilder(
              future: fetchAcceptedWorkData(),
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
                  acceptedRequests = snapshot.data!;
                  return ListView.builder(
                    itemCount: acceptedRequests.length,
                    itemBuilder: (context, index) {
                      print(index);
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            leading:
                                Icon(MdiIcons.briefcase, color: Colors.black),
                            title: Text(
                                acceptedRequests[index]
                                    .proposalTitle
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                  acceptedRequests[index]
                                      .workDescription
                                      .toString(),
                                  style: TextStyle(color: Colors.black)),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserSideWorkStatusScreen(
                                            proposalId: acceptedRequests[index]
                                                .proposalId
                                                .toString(),
                                          )));
                              ;
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
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
          child: FutureBuilder(
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
                  pendingRequests = snapshot.data!;
                  return ListView.builder(
                    itemCount: pendingRequests.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                            leading:
                                Icon(MdiIcons.briefcase, color: Colors.black),
                            title: Text(
                                pendingRequests[index].requestTitle.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Text(
                                  pendingRequests[index]
                                      .workDescription
                                      .toString(),
                                  style: TextStyle(color: Colors.black)),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProposalSelectionScreen(
                                            proposalProposalId:
                                                pendingRequests[index]
                                                    .proposalRequestId
                                                    .toString(),
                                          )));
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ]),
    );
  }
}
