import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/dashboard.dart';
import 'screens/learn.dart';
import 'screens/invest.dart';
import 'screens/community.dart';
import 'screens/reminders.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ClariFiApp());
}

class ClariFiApp extends StatelessWidget {
  const ClariFiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClariFi',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const ClariFiHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ClariFiHome extends StatefulWidget {
  const ClariFiHome({super.key});

  @override
  State<ClariFiHome> createState() => _ClariFiHomeState();
}

class _ClariFiHomeState extends State<ClariFiHome> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    LearnScreen(),
    InvestScreen(),
    CommunityScreen(),
    RemindersScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
    BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Learn'),
    BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Invest'),
    BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
    BottomNavigationBarItem(icon: Icon(Icons.alarm), label: 'Reminders'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        destinations: _navItems
            .map(
              (item) =>
                  NavigationDestination(icon: item.icon!, label: item.label!),
            )
            .toList(),
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
