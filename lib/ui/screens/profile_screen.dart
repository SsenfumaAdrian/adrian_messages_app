// FILE: lib/ui/screens/profile_screen.dart

import 'package:flutter/material.dart';
import '../components/liquid_profile_card.dart';
import '../components/liquid_glass_container.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Your Identity",
            style: TextStyle(fontFamily: 'Inter-Bold')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const LiquidProfileCard(
              userName: "Adrian",
              status: "Developing the future of messaging...",
              avatarUrl:
                  "https://api.dicebear.com/7.x/avataaars/svg?seed=Adrian",
            ),
            const SizedBox(height: 30),

            // Privacy 'Ghost Mode' Toggle
            LiquidGlassContainer(
              borderRadius: 20,
              child: SwitchListTile(
                title: const Text("Ghost Mode",
                    style: TextStyle(fontFamily: 'Inter-SemiBold')),
                subtitle:
                    const Text("Invisible to everyone, encrypted for you."),
                value: true,
                onChanged: (val) {},
                activeColor: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 15),

            // Storage Statistics Stitch
            LiquidGlassContainer(
              borderRadius: 20,
              child: const ListTile(
                leading: Icon(Icons.storage_rounded, color: Colors.white70),
                title: Text("Stitch Storage"),
                trailing: Text("1.2 GB / 5 GB",
                    style: TextStyle(color: Colors.white38)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
