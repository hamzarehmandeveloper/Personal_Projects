import 'package:flutter/material.dart';
import 'package:home_services_fyp/models/proposal_model.dart';
import 'package:home_services_fyp/usersMode/screens/progress_screen.dart';

class ProposalSelectionScreen extends StatefulWidget {
  const ProposalSelectionScreen({super.key});

  @override
  _ProposalSelectionScreenState createState() =>
      _ProposalSelectionScreenState();
}

class _ProposalSelectionScreenState extends State<ProposalSelectionScreen> {
  int? _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: const Text('Select Proposal',style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: ListView.builder(
        itemCount: proposals.length,
        itemBuilder: (BuildContext context, int index) {
          var proposal = proposals[index];
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
                            builder: (context) => WorkStatusScreen(index: index,)));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        proposal.title,
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
                        'Estimated Time : ${(proposal.estimatedTime)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}


