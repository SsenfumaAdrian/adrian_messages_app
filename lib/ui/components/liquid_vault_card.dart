// FILE: lib/ui/components/liquid_glass_vault_card.dart

import 'package:flutter/material.dart';
import 'liquid_glass_container.dart';

class LiquidVaultCard extends StatelessWidget {
  final String title;
  final VoidCallback onUnlock;

  const LiquidVaultCard({super.key, required this.title, required this.onUnlock});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: LiquidGlassContainer(
        // Darker glass for higher security feel
        borderRadius: 20,
        child: ListTile(
          leading:
              const Icon(Icons.lock_outline_rounded, color: Colors.blueAccent),
          title: Text(
            title,
            style: const TextStyle(
                fontFamily: 'Inter-SemiBold', letterSpacing: 1.2),
          ),
          subtitle: const Text("Crystallized & Encrypted",
              style: TextStyle(fontSize: 10, color: Colors.white24)),
          trailing: IconButton(
            icon: const Icon(Icons.key_rounded, color: Colors.white38),
            onPressed: onUnlock,
          ),
        ),
      ),
    );
  }
}
