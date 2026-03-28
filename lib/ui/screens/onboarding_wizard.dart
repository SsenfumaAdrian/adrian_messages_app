import 'package:flutter/material.dart';
import 'auth_screen.dart';

class OnboardingWizard extends StatelessWidget {
  final Color brandBlue = const Color(0xFF1A237E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Adrian Messages",
            style: TextStyle(fontFamily: 'Inter-Bold', color: brandBlue)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildBentoGrid(), // Simplified representation of your grid
            const SizedBox(height: 40),
            _buildTextContent(),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AuthScreen())),
                style: ElevatedButton.styleFrom(
                    backgroundColor: brandBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: const Text("Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Inter-Bold')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBentoGrid() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: brandBlue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(30)),
      child: const Center(
          child: Icon(Icons.grid_view_rounded,
              size: 100, color: Color(0xFF1A237E))),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Communication, elevated.",
            style: TextStyle(
                fontFamily: 'Inter-Bold',
                fontSize: 36,
                color: Color(0xFF1A237E))),
        const SizedBox(height: 16),
        Text("Military-grade encryption for those who value privacy.",
            style:
                TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6))),
      ],
    );
  }
}
