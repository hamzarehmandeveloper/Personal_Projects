import 'package:flutter/material.dart';
import 'package:home_services_fyp/screens/perposal_selection_screen.dart';

class JobDetailsScreen extends StatefulWidget {
  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _rate = '';
  String _material = '';
  String _completionTime = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'Job Description',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Job description and details...',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Rate'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a rate';
                  }
                  return null;
                },
                onSaved: (value) => _rate = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Material'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter material information';
                  }
                  return null;
                },
                onSaved: (value) => _material = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Estimated Completion Time'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an estimated completion time';
                  }
                  return null;
                },
                onSaved: (value) => _completionTime = value!,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Call API to submit the proposal with _rate, _material, and _completionTime
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProposalSelectionScreen()));
                },
                child: Text('Submit Proposal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
