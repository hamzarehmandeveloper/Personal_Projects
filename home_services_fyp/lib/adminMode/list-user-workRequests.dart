import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../FireStore_repo/work_request_&_proposal_repo.dart';
import '../Widget/richText.dart';
import '../models/workRequestModel.dart';

class ListWorkRequests extends StatefulWidget {
  final String? UserID;
  const ListWorkRequests({Key? key, required this.UserID}) : super(key: key);

  @override
  State<ListWorkRequests> createState() => _ListWorkRequestsState();
}

WorkRequestRepo requestRepo = WorkRequestRepo();
List<dynamic> proposalList = [];

class _ListWorkRequestsState extends State<ListWorkRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Details'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final updatePropodals = await requestRepo
              .fetchUserWorkRequests(widget.UserID!);
          setState(() {
            proposalList = updatePropodals;
          });
        },
        child: FutureBuilder<List<dynamic>>(
            future: requestRepo.fetchUserWorkRequests(widget.UserID!),
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
                return proposalList.isNotEmpty?
                     ListView.builder(
                      itemCount: proposalList.length,
                      itemBuilder: (context, index) {
                        return ProposalListItem(
                          proposal: proposalList[index],
                        );
                      },
                    )
                :const Center(child: Text('No data exit for this user'),);
              }
            }),
      ),
    );
  }
}


class ProposalListItem extends StatelessWidget {
  final WorkRequestProposal proposal;

  ProposalListItem({super.key, required this.proposal});

  Timestamp setDate() {
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
        child: Column(
          children: [
            ListTile(
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              title: Text(
                proposal.requestTitle.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  richText('Description: ', proposal.workDescription.toString()),
                  const SizedBox(height: 5),
                  richText('Location: ', proposal.location.toString()),
                  const SizedBox(height: 4),
                  richText('Date: ', setDate().toDate().toString()),
                  const SizedBox(
                    height: 4,
                  ),
                  richText('Submitted by: ', proposal.proposerName.toString()),
                  const SizedBox(
                    height: 10,
                  ),
                  proposal.imageUrls!.isNotEmpty
                      ? Row(
                    children: proposal.imageUrls!.map((imageAddress) {
                      return Expanded(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: imageAddress,
                              fit: BoxFit.cover,
                              width: 128,
                              height: 128,
                              placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                      : SizedBox(),
                ],
              ),
              onTap: () {},)
          ],
        ),
      ),
    );
  }
}

