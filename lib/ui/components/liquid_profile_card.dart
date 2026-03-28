// FILE: lib/ui/components/liquid_profile_card.dart

import 'package:flutter/material.dart';
import 'liquid_glass_container.dart';

class LiquidProfileCard extends StatelessWidget {
  final String userName;
  final String status;
  final String avatarUrl;

  const LiquidProfileCard({
    Key? key,
    required this.userName,
    required this.status,
    required this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      borderRadius: 35,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // The Avatar with a refractive 'Glow' ring
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.blueAccent.withOpacity(0.5), width: 2),
            ),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white10,
              backgroundImage: NetworkImage(avatarUrl),
            ),
          ),
          const SizedBox(height: 20),
          // Using Inter-Bold for the Name
          Text(
            userName,
            style: const TextStyle(
              fontFamily: 'Inter-Bold',
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          // Using Inter-Regular for the Status
          Text(
            status,
            style: const TextStyle(
              fontFamily: 'Inter-Regular',
              fontSize: 14,
              color: Colors.white54,
            ),
          ),
        ],
      ),
    );
  }
}
