import 'package:adrian_messages/ui/components/marble_background.dart';
import 'package:adrian_messages/ui/screens/auth/layouts/desktop_layout.dart';
import 'package:adrian_messages/ui/screens/auth/layouts/mobile_layout.dart';
import 'package:adrian_messages/ui/screens/auth/layouts/tablet_layout.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _swirlCtrl;

  @override
  void initState() {
    super.initState();
    _swirlCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _swirlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFF060D1F), // Deep Navy
      body: Stack(
        fit: StackFit.expand,
        children: [
          MarbleBackground(controller: _swirlCtrl),
          const ColoredBox(color: Color.fromARGB(20, 4, 12, 40)),
          _buildResponsiveLayout(size),
        ],
      ),
    );
  }

  Widget _buildResponsiveLayout(Size size) {
    if (size.width >= 900) return DesktopLayout(size: size);
    if (size.width < 600) return const MobileLayout();
    return const TabletLayout();
  }
}
