import 'package:flutter/material.dart';
import 'home_screen.dart';

class LanguageSelector extends StatelessWidget {
  final Function(Locale) onLocaleSelected;

  const LanguageSelector({super.key, required this.onLocaleSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Language")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                onLocaleSelected(const Locale('en'));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text("English"),
            ),
            ElevatedButton(
              onPressed: () {
                onLocaleSelected(const Locale('te'));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text("తెలుగు"),
            ),
            ElevatedButton(
              onPressed: () {
                onLocaleSelected(const Locale('kn'));
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Text("ಕನ್ನಡ"),
            ),
          ],
        ),
      ),
    );
  }
}
