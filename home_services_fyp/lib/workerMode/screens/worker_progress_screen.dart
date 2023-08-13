import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:home_services_fyp/FireStore_repo/APIsCall.dart';
import 'package:home_services_fyp/FireStore_repo/worker_proposal_repo.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../models/worker_proposals_model.dart';

class WorkerSideWorkStatusScreen extends StatefulWidget {
  final String proposalId;

  WorkerSideWorkStatusScreen({required this.proposalId});

  @override
  State<WorkerSideWorkStatusScreen> createState() =>
      _WorkerSideWorkStatusScreenState();
}

class _WorkerSideWorkStatusScreenState
    extends State<WorkerSideWorkStatusScreen> {
  WorkerProposalModel? proposalData;
  WorkerProposalRepo repo = WorkerProposalRepo();

  @override
  void initState() {
    super.initState();
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
          'Worker Status',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: repo.fetchProposalData(widget.proposalId),
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
              proposalData = snapshot.data;
              Timestamp time = proposalData!.timestamp;
              return proposalData != null ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 95,
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
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                proposalData!.proposalTitle.toString(),
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Rate : ${(proposalData!.rate.toString())} Rs',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Estimated Time : ${(time.toDate())}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Material : ${(proposalData!.material)}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Location : ${(proposalData!.location.toString())}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              /*Row(
                          children: requestModel[widget.index]
                              .images
                              .map((imageAddress) {
                            return Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Image.asset(imageAddress),
                              ),
                            );
                          }).toList(),
                        ),*/
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      workTimeLine(
                        reachDestinationTime: proposalData!.workReachTime,
                        workInProgressTime: proposalData!.workStartTime,
                        finalizeTaskTime: proposalData!.workEndTime,
                        proposerDeviceToken: proposalData!.proposerDeviceToken,
                        proposerName: proposalData!.proposerName,
                        workerName: proposalData!.workerName,
                        proposalId: widget.proposalId,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ): const Center(
                child: Text('Something went wrong'),
              );
            }
          }),
    );
  }
}

Widget workTimeLine({
  dynamic reachDestinationTime,
  dynamic workInProgressTime,
  dynamic finalizeTaskTime,
  String? proposerDeviceToken,
  String? workerName,
  String? proposerName,
  String? proposalId,
}) {
  print( 'reach time $reachDestinationTime');
  Future<void> updateProposalMilestoneTimes() async {
    try {
      await FirebaseFirestore.instance
          .collection('WorkerProposals')
          .doc(proposalId)
          .update({
        'workReachTime': reachDestinationTime,
        'workStartTime': workInProgressTime,
        'workEndTime': finalizeTaskTime,
      });
      print('Milestone times updated successfully.');
    } catch (e) {
      print('Error updating milestone times: $e');
    }
  }
  return Center(
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isFirst: true,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF27AA69),
            padding: EdgeInsets.all(6),
          ),
          endChild: _RightChild(
            disabled: reachDestinationTime == null,
            asset: 'assets/images/demo.png',
            title: 'Reach On Destination',
            message: 'Worker is reached to destination to start work',
            onToggle: (val) {
              reachDestinationTime = val ? DateTime.now() : null;
              print(reachDestinationTime);
              updateProposalMilestoneTimes();
              APIsCall.sendNotification('$workerName is reached to destination to start work', proposerDeviceToken, 'Hey Mr. $proposerName');
            },
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFF000000),
            padding: EdgeInsets.all(6),
          ),
          endChild: Padding(
            padding: const EdgeInsets.only(bottom: 30.0, top: 30),
            child: _RightChild(
              disabled: workInProgressTime == null,
              asset: 'assets/images/demo.png',
              title: 'Work in progress',
              message: 'Worker is working on the task',
              onToggle: (val) {
                workInProgressTime = val ? DateTime.now() : null;
                print(workInProgressTime);
                updateProposalMilestoneTimes();
                APIsCall.sendNotification('$workerName start working', proposerDeviceToken, 'Hey Mr. $proposerName');
              },
            ),
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF27AA69),
          ),
          afterLineStyle: const LineStyle(
            color: Color(0xFF000000),
          ),
        ),
        TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.1,
          isLast: true,
          indicatorStyle: const IndicatorStyle(
            width: 20,
            color: Color(0xFFFF004A),
            padding: EdgeInsets.all(6),
          ),
          endChild: _RightChild(
            disabled: finalizeTaskTime == null,
            asset: 'assets/images/demo.png',
            title: 'Finalize the task',
            message: 'Your work is completed',
            onToggle: (val) {
              finalizeTaskTime = val ? DateTime.now() : null;
              print(finalizeTaskTime);
              updateProposalMilestoneTimes();
              APIsCall.sendNotification('$workerName work just completed your work. Please leave a review', proposerDeviceToken, 'Hey Mr. $proposerName');
            },
          ),
          beforeLineStyle: const LineStyle(
            color: Color(0xFF000000),
          ),
        ),
      ],
    ),
  );
}

class _RightChild extends StatefulWidget {
  _RightChild({
    Key? key,
    required this.asset,
    required this.title,
    required this.message,
    required this.disabled,
    required this.onToggle,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  late bool disabled;
  final Function(bool) onToggle;

  @override
  State<_RightChild> createState() => _RightChildState();
}

class _RightChildState extends State<_RightChild> {
  bool? localDisabled;

  @override
  void initState() {
    super.initState();
    localDisabled = widget.disabled;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: SizedBox(
        child: Row(
          children: <Widget>[
            Opacity(
              child: Image.asset(widget.asset, height: 50),
              opacity: localDisabled! ? 0.5 : 1,
            ),
            const SizedBox(width: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: localDisabled!
                            ? const Color(0xFFBABABA)
                            : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    FlutterSwitch(
                      width: 70.0,
                      height: 40.0,
                      toggleSize: 30.0,
                      value: !localDisabled!,
                      borderRadius: 30.0,
                      padding: 5.0,
                      showOnOff: true,
                      activeColor: Colors.black,
                      onToggle: (val) {
                        setState(() {
                          localDisabled = !val;
                          widget.onToggle(val);
                        });
                      },
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
