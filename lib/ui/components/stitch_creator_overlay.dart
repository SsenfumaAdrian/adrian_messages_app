// FILE: lib/ui/components/stitch_creator_overlay.dart

import 'package:flutter/material.dart';
import 'liquid_glass_container.dart';
import 'liquid_glass_button.dart';

class StitchCreatorOverlay extends StatelessWidget {
  final int count;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const StitchCreatorOverlay({
    super.key,
    required this.count,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: LiquidGlassContainer(
        borderRadius: 30,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Text(
              "$count Messages Selected",
              style: const TextStyle(
                  fontFamily: 'Inter-SemiBold', color: Colors.blueAccent),
            ),
            const Spacer(),
            TextButton(
              onPressed: onCancel,
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.white54)),
            ),
            const SizedBox(width: 10),
            LiquidGlassButton(
              onTap: onConfirm,
              child: const Text("Stitch Together"),
            ),
          ],
        ),
      ),
    );
  }
}
