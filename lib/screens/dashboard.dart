import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _message = "Dashboard";

  final List<Map<String, dynamic>> transactions = [
    {"title": "Groceries", "amount": 40, "date": "May 28"},
    {"title": "Electricity Bill", "amount": 120, "date": "May 27"},
    {"title": "Coffee", "amount": 15, "date": "May 26"},
  ];

  @override
  void initState() {
    super.initState();
    _testFirestore();
  }

  Future<void> _testFirestore() async {
    try {
      await _firestore.collection('test').doc('welcome').set({
        'text': 'Hello ClariFi!',
      });
      DocumentSnapshot doc = await _firestore
          .collection('test')
          .doc('welcome')
          .get();
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
    double totalSpent = transactions.fold(0, (sum, tx) => sum + tx["amount"]);
    double budget = 300;
    double remaining = budget - totalSpent;

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Text(_message, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            Text(
              "Weekly Spending",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 200, child: _buildBarChart()),

            SizedBox(height: 20),
            _buildBudgetCard(totalSpent, budget, remaining),

            SizedBox(height: 20),
            Text(
              "Recent Transactions",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            ...transactions.map(
              (tx) => ListTile(
                leading: Icon(Icons.attach_money, color: Colors.deepPurple),
                title: Text(tx["title"]),
                subtitle: Text(tx["date"]),
                trailing: Text(
                  "- \$${tx["amount"]}",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final barData = List.generate(
      7,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: [50, 60, 30, 80, 20, 100, 40][index].toDouble(),
            color: Colors.deepPurple,
            width: 15,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );

    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        barGroups: barData,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text(
                ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][value
                    .toInt()],
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, _) => Text("\$${value.toInt()}"),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetCard(double totalSpent, double budget, double remaining) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      color: Colors.deepPurple.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Monthly Budget",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: totalSpent / budget,
              color: Colors.deepPurple,
              backgroundColor: Colors.deepPurple.shade100,
            ),
            SizedBox(height: 8),
            Text("Spent: \$${totalSpent.toStringAsFixed(2)}"),
            Text("Remaining: \$${remaining.toStringAsFixed(2)}"),
          ],
        ),
      ),
    );
  }
}
