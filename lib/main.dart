// FILE: lib/main.dart

import 'package:adrian_messages/core/constants/palette.dart';
import 'package:adrian_messages/core/navigation/liquid_router.dart';
import 'package:flutter/material.dart';
import 'ui/screens/liquid_splash_screen.dart';

void main() {
  runApp(const AdrianMessagesApp());
}

class AdrianMessagesApp extends StatelessWidget {
  const AdrianMessagesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adrian Messages',
      debugShowCheckedModeBanner: false,
      theme: LiquidTheme.darkTheme,
      // Starts with Splash animation, then flows to Onboarding
      home: const LiquidSplashScreen(),
      initialRoute: LiquidRouter.splash,
      routes: LiquidRouter.routes,
      onGenerateRoute: LiquidRouter.onGenerateRoute,
      theme: Palette.lightTheme, // ← was using wrong dark theme
    );
  }
}
