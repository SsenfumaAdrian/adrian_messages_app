// FILE: lib/ui/screens/liquid_call_screen.dart

import 'package:flutter/material.dart';
import '../components/liquid_glass_button.dart';
import '../components/liquid_glass_container.dart';

class LiquidCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background - Deep space with subtle moving gradients
          Container(color: const Color(0xFF020205)),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                        "https://api.dicebear.com/7.x/avataaars/svg?seed=Adrian")),
                const SizedBox(height: 20),
                const Text("Calling...",
                    style: TextStyle(
                        fontFamily: 'Inter-Medium', color: Colors.white54)),
                const Text("Adrian",
                    style: TextStyle(fontFamily: 'Inter-Bold', fontSize: 32)),
                const SizedBox(height: 100),

                // Call Action Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LiquidGlassButton(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.call_end,
                            color: Colors.redAccent, size: 30)),
                    const SizedBox(width: 30),
                    LiquidGlassButton(
                        onTap: () {},
                        child: const Icon(Icons.videocam_rounded, size: 30)),
                    const SizedBox(width: 30),
                    LiquidGlassButton(
                        onTap: () {},
                        child: const Icon(Icons.mic_off_rounded, size: 30)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
