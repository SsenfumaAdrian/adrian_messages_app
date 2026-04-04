// FILE: lib/main.dart
import 'package:flutter/material.dart';
import 'core/constants/palette.dart';
import 'core/navigation/liquid_router.dart';

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
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      // Use initialRoute + routes only — do NOT also set home:
      // Having both home: and routes['/'] causes an assertion error at runtime
      initialRoute: LiquidRouter.splash,
      routes: LiquidRouter.routes,
      onGenerateRoute: LiquidRouter.onGenerateRoute,
    );
  }
}
