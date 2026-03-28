// FILE: lib/ui/screens/stitch_gallery_screen.dart

import 'package:flutter/material.dart';
import '../components/liquid_glass_container.dart';

class StitchGalleryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0E),
      appBar: AppBar(
        title: const Text("Your Stitches",
            style: TextStyle(fontFamily: 'Inter-Bold')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Memories stitched in glass.",
              style:
                  TextStyle(fontFamily: 'Inter-Medium', color: Colors.white54),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.8),
              itemCount: 5, // Representing dummy stitched items
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
                  child: LiquidGlassContainer(
                    borderRadius: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.auto_awesome_motion,
                            size: 60, color: Colors.blueAccent),
                        const SizedBox(height: 30),
                        Text(
                          "Stitch #${index + 1}",
                          style: const TextStyle(
                              fontFamily: 'Inter-Bold', fontSize: 22),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            "A collection of thoughts and media merged into a refractive summary.",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        const Spacer(),
                        const Text("TAP TO OPEN",
                            style: TextStyle(letterSpacing: 2, fontSize: 10)),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
