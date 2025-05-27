import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _message = "Dashboard";

  @override
  void initState() {
    super.initState();
    _testFirestore();
  }

  Future<void> _testFirestore() async {
    try {
      // Write a test document
      await _firestore.collection('test').doc('welcome').set({'text': 'Hello ClariFi!'});
      
      // Read the test document
      DocumentSnapshot doc = await _firestore.collection('test').doc('welcome').get();
      
      setState(() {
        _message = doc['text'] ?? 'No data found';
      });
    } catch (e) {
      setState(() {
        _message = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(_message, style: TextStyle(fontSize: 24)),
    );
  }
}
