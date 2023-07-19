import 'package:flutter/material.dart';
import 'package:home_services_fyp/screens/work_description_screen.dart';

// Proposal Selection Screen
class ProposalSelectionScreen extends StatefulWidget {
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
        title: Text('Select Proposal'),
      ),
      body: ListView.builder(
        itemCount: 5, // replace with actual number of proposals
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.all(16),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Proposal ${index + 1}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Rate: \$100', // replace with actual rate
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Material: Pipes, fittings, etc.',
                      // replace with actual material
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Time: 2 days', // replace with actual time
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: _selectedIndex == null
          ? null
          : BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  child: Text('Select Proposal'),
                  onPressed: () {
                    // TODO: Save selected proposal
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubmitWorkScreen()));
                  },
                ),
              ),
            ),
    );
  }
}
