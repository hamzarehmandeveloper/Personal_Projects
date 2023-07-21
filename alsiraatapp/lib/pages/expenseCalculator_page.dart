import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistanceCalculatorPage extends StatefulWidget {
  @override
  _DistanceCalculatorPageState createState() => _DistanceCalculatorPageState();
}

class _DistanceCalculatorPageState extends State<DistanceCalculatorPage> {
  String city1 = '';
  String city2 = '';
  double totalDistance = 0.0;
  String error = '';

  Future<double> calculateDistance() async {
    final apiKey = 'AIzaSyD8PJaBsDTC9qi0Co8LBj5gnUQ_MpONu-Y';
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?origins=$city1&destinations=$city2&key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rows = data['rows'] as List<dynamic>;
      if (rows.isNotEmpty) {
        final elements = rows[0]['elements'] as List<dynamic>;
        if (elements.isNotEmpty) {
          final distance = elements[0]['distance']['value'];
          return distance.toDouble() / 1000; // Convert distance to kilometers
        }
      }
    }

    throw Exception('Failed to calculate distance');
  }

  void calculateButtonPressed() async {
    try {
      final distance = await calculateDistance();
      setState(() {
        totalDistance = distance;
        error = '';
      });
    } catch (e) {
      setState(() {
        error = 'Error calculating distance. Please check the city names and try again.';
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Distance Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  city1 = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'City 1',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  city2 = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'City 2',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: calculateButtonPressed,
              child: Text('Calculate'),
            ),
            SizedBox(height: 16.0),
            if (error.isNotEmpty) Text(
              error,
              style: TextStyle(color: Colors.red),
            ),
            if (totalDistance != 0.0) Text(
              'Total Distance: $totalDistance km',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

