import 'dart:async' show unawaited;
// FILE: lib/main.dart
import 'package:flutter/material.dart';
import 'core/constants/palette.dart';
import 'core/navigation/liquid_router.dart';
import 'core/utils/nav_persistence.dart';
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
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      home: const _StartupGate(),
      routes: LiquidRouter.routesNoSplash,
      onGenerateRoute: LiquidRouter.onGenerateRoute,
    );
  }
}

// ── Startup gate ───────────────────────────────────────────────
// Checks SharedPreferences before showing splash.
// • First run / logged out → LiquidSplashScreen (normal flow)
// • Already logged in      → MainShell at last tab (no splash flicker)
class _StartupGate extends StatefulWidget {
  const _StartupGate();

  @override
  State<_StartupGate> createState() => _StartupGateState();
}

class _StartupGateState extends State<_StartupGate> {
  @override
  void initState() {
    super.initState();
    _route();
  }

  Future<void> _route() async {
    final loggedIn  = await NavPersistence.isLoggedIn();
    final tabIndex  = await NavPersistence.loadTab();

    if (!mounted) return;

    if (loggedIn) {
      // Skip splash — go straight to shell at the persisted tab
      unawaited(Navigator.pushReplacementNamed(
        context,
        LiquidRouter.shell,
        arguments: {'index': tabIndex},
      ));
    }
    // else: show LiquidSplashScreen (the default child below)
  }

  @override
  Widget build(BuildContext context) {
    // While the Future runs this shows the splash (which also plays its animation)
    return const LiquidSplashScreen();
  }
}
