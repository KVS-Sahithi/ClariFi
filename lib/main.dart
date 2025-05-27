import 'package:flutter/material.dart';
import 'screens/dashboard.dart';
import 'screens/learn.dart';
import 'screens/invest.dart';
import 'screens/community.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ClariFiApp());
}

class ClariFiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClariFi',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: ClariFiHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ClariFiHome extends StatefulWidget {
  @override
  _ClariFiHomeState createState() => _ClariFiHomeState();
}

class _ClariFiHomeState extends State<ClariFiHome> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    LearnScreen(),
    InvestScreen(),
    CommunityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Invest'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
        ],
      ),
    );
  }
}
