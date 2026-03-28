// FILE: lib/ui/screens/vault_screen.dart

import 'package:adrian_messages/ui/components/liquid_vault_card.dart';
import 'package:flutter/material.dart';


class VaultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050508), // Darker than dashboard
      appBar: AppBar(
        title: const Text("THE VAULT",
            style: TextStyle(fontFamily: 'Inter-Bold', letterSpacing: 2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),
          const Text(
            "Your crystallized conversations are stored here with zero-knowledge encryption.",
            style: TextStyle(color: Colors.white38, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          LiquidVaultCard(title: "Project Phoenix Stitch", onUnlock: () {}),
          LiquidVaultCard(title: "Private Family Thread", onUnlock: () {}),
          LiquidVaultCard(title: "Financial Notes", onUnlock: () {}),
        ],
      ),
    );
  }
}
