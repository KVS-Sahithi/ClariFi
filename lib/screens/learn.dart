import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LearnScreen extends StatefulWidget {
  const LearnScreen({super.key});

  @override
  _LearnScreenState createState() => _LearnScreenState();
}

class _LearnScreenState extends State<LearnScreen> {
  double _progress = 0.4;

  List<bool> _expanded = [];

  final List<Map<String, dynamic>> topics = [
    {
      "title": "💰 Saving Habits",
      "desc": "Learn how to build strong savings with the 50-30-20 rule.",
      "animation":
          "https://lottie.host/4f77c537-88ee-49f7-9230-bbd8d65563bb/dGo4rMekRw.json",
    },
    {
      "title": "🏦 SIP & Mutual Funds",
      "desc": "Understand SIPs, mutual funds, risk profiles, and returns.",
      "animation":
          "https://lottie.host/3cb5c13b-3ed4-4b80-85de-9f69cd21b237/NvRjhdE6Xe.json",
    },
    {
      "title": "🏠 Gold Schemes",
      "desc": "Explore gold savings schemes, digital gold, and benefits.",
      "animation":
          "https://lottie.host/55dba3e1-34b9-47ad-8b0c-1634cc9d6e56/4rGc3PHEbY.json",
    },
    {
      "title": "📊 Credit Score & Loans",
      "desc": "Importance of credit score and how loans affect it.",
      "animation":
          "https://lottie.host/29ebd7e3-e6b4-4d7e-8993-86c2e8c91f1e/bZlJsdMpVX.json",
    },
    {
      "title": "🛡 Emergency Funds",
      "desc": "Learn to prepare for unexpected life events.",
      "animation":
          "https://lottie.host/089a5b2a-c353-4cfd-94fd-6d40c1a84f8a/oLmCPweIX9.json",
    },
  ];

  @override
  void initState() {
    super.initState();
    _expanded = List<bool>.filled(topics.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn & Grow 🌟'),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: _progress,
            color: Colors.deepPurple,
            backgroundColor: Colors.deepPurple.shade100,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Your Learning Progress",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, i) => Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: ExpansionTile(
                  initiallyExpanded: _expanded[i],
                  onExpansionChanged: (expanded) =>
                      setState(() => _expanded[i] = expanded),
                  title: Text(
                    topics[i]['title'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(topics[i]['desc']),
                    ),
                    Container(
                      height: 150,
                      child: Lottie.network(topics[i]['animation']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        onPressed: () {
                          setState(() {
                            _progress += 0.1;
                            if (_progress > 1.0) _progress = 1.0;
                          });
                        },
                        child: Text("Mark as Learned"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
