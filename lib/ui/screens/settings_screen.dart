// FILE: lib/ui/screens/settings_screen.dart

import 'package:flutter/material.dart';
import '../components/liquid_glass_container.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0E),
      appBar: AppBar(
        title: const Text("Preferences",
            style: TextStyle(fontFamily: 'Inter-Bold')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSettingsCard(Icons.person_outline, "Account Profile",
              "Manage your liquid identity"),
          _buildSettingsCard(Icons.blur_on, "Glass Intensity",
              "Adjust the UI refraction levels"),
          _buildSettingsCard(Icons.security_rounded, "Privacy & Encryption",
              "State-of-the-art E2EE"),
          const SizedBox(height: 40),
          const Center(
            child: Text("Adrian Messages v1.0.0 (Beta)",
                style: TextStyle(color: Colors.white24)),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: LiquidGlassContainer(
        child: ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title:
              Text(title, style: const TextStyle(fontFamily: 'Inter-SemiBold')),
          subtitle: Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.white60)),
          trailing: const Icon(Icons.chevron_right, color: Colors.white30),
        ),
      ),
    );
  }
}
