// FILE: lib/ui/components/liquid_avatar_group.dart

import 'package:flutter/material.dart';

class LiquidAvatarGroup extends StatelessWidget {
  final List<String> urls;
  const LiquidAvatarGroup({Key? key, required this.urls}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 100,
      child: Stack(
        children: List.generate(urls.length, (index) {
          return Positioned(
            left: index * 20.0,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(urls[index]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
