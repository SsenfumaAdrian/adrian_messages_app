// FILE: lib/ui/components/liquid_notification_toast.dart

import 'package:flutter/material.dart';
import 'liquid_glass_container.dart';

class LiquidNotificationToast extends StatelessWidget {
  final String title;
  final String body;

  const LiquidNotificationToast({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        alignment: Alignment.topCenter,
        child: LiquidGlassContainer(
          borderRadius: 25,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.blueAccent),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontFamily: 'Inter-Bold', fontSize: 14)),
                    Text(body,
                        style: const TextStyle(
                            fontFamily: 'Inter-Regular',
                            fontSize: 12,
                            color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
