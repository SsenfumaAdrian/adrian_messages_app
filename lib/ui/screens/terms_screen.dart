import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Terms & Conditions",
              style: TextStyle(fontFamily: 'Inter-Bold'))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Expanded(
              child: SingleChildScrollView(
                child: Text(
                    "By using Adrian Messages, you agree to our encrypted data protocols. Your privacy is absolute...",
                    style: TextStyle(fontSize: 14, height: 1.6)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen())),
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text("I Agree & Enter",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Inter-Bold')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
