// FILE: lib/main.dart

import 'package:flutter/material.dart';
import 'core/theme/liquid_theme.dart';
import 'ui/screens/liquid_splash_screen.dart';

void main() {
  runApp(const AdrianMessagesApp());
}

class AdrianMessagesApp extends StatelessWidget {
  const AdrianMessagesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adrian Messages',
      debugShowCheckedModeBanner: false,
      theme: LiquidTheme.darkTheme,
      // Starts with Splash animation, then flows to Onboarding
      home: LiquidSplashScreen(),
    );
  }
}
