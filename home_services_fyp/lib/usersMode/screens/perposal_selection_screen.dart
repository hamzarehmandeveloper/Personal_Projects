import 'package:flutter/material.dart';
import 'package:home_services_fyp/usersMode/screens/work_description_screen.dart';

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
        itemCount: 5, // replace with actual number of proposals
        itemBuilder: (BuildContext context, int index) {
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
                    offset: const Offset(0, 6),
                    blurRadius: 10.0,
                  ),
                ],
                borderRadius: BorderRadius.circular(14.0),
              ),
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Rate: \$100', // replace with actual rate
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Material: Pipes, fittings, etc.',
                        // replace with actual material
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Time: 2 days', // replace with actual time
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
      bottomNavigationBar: _selectedIndex == null
          ? null
          : BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  child: const Text('Select Proposal'),
                  onPressed: () {
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
