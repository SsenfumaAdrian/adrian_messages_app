// FILE: lib/core/navigation/liquid_router.dart

import 'package:flutter/material.dart';

class LiquidRouter {
  static Route createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // A 'Fade and Scale' transition to mimic liquid movement
        var curve = Curves.easeInOutCubic;
        var curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

        return FadeTransition(
          opacity: curvedAnimation,
          child: ScaleTransition(
            scale:
                Tween<double>(begin: 0.98, end: 1.0).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }
}
