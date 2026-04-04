// FILE: lib/ui/screens/call_screen.dart
// Matches: high_end_call_interface_1 & _2
// Dark full-screen call UI with glassmorphism controls

import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../components/liquid_glass.dart';

class CallScreen extends StatefulWidget {
  const CallScreen(
      {super.key, required this.contactName, this.isVideo = false});
  final String contactName;
  final bool isVideo;
  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen>
    with SingleTickerProviderStateMixin {
  bool _muted = false, _videoOff = false, _speakerOn = true;
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1600))
      ..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.85, end: 1.0)
        .animate(CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkBackground,
      body: Stack(fit: StackFit.expand, children: [
        // Gradient bg
        Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF060D1F),
                Color(0xFF0E1733),
                Color(0xFF163A72)
              ]),
        )),

        // Radial glow behind avatar
        Center(
            child: AnimatedBuilder(
                animation: _pulse,
                builder: (_, __) => Container(
                      width: 280 * _pulse.value,
                      height: 280 * _pulse.value,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(colors: [
                            Palette.accentCyan.withValues(alpha: 0.08 * _pulse.value),
                            Colors.transparent
                          ])),
                    ))),

        SafeArea(
            child: Column(children: [
          // Top bar
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(children: [
                LiquidGlassButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  size: 40,
                  iconSize: 16,
                  iconColor: Colors.white.withValues(alpha: 0.90),
                  onTap: () => Navigator.maybePop(context),
                ),
                const SizedBox(width: 10),
                const _GlassBadge(
                    label: 'End-to-End Encrypted',
                    icon: Icons.lock_rounded,
                    color: Palette.accentCyan),
                const Spacer(),
                Text(_callDuration(),
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ])),

          const Spacer(),

          // Avatar + name
          Column(children: [
            AnimatedBuilder(
                animation: _pulse,
                builder: (_, child) => Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [Palette.primary, Color(0xFF3949AB)]),
                          boxShadow: [
                            BoxShadow(
                                color: Palette.accentCyan
                                    .withValues(alpha: 0.22 * _pulse.value),
                                blurRadius: 40 * _pulse.value,
                                spreadRadius: 4)
                          ]),
                      child: Center(
                          child: Text(widget.contactName[0].toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 42,
                                  fontWeight: FontWeight.w800))),
                    )),
            const SizedBox(height: 20),
            Text(widget.contactName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Text(widget.isVideo ? 'Video Call' : 'Voice Call',
                style: const TextStyle(color: Colors.white54, fontSize: 14)),
          ]),

          const Spacer(),

          // Control dock — glassmorphism pill
          Padding(
              padding: EdgeInsets.only(bottom: 48, left: 24, right: 24),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 28, vertical: 16),
                        decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(99),
                            border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _CallBtn(
                                  icon: _muted
                                      ? Icons.mic_off_rounded
                                      : Icons.mic_rounded,
                                  onTap: () => setState(() => _muted = !_muted),
                                  active: !_muted),
                              _CallBtn(
                                  icon: _videoOff
                                      ? Icons.videocam_off_rounded
                                      : Icons.videocam_rounded,
                                  onTap: () =>
                                      setState(() => _videoOff = !_videoOff),
                                  active: !_videoOff),
                              _CallBtn(
                                  icon: Icons.screen_share_outlined,
                                  onTap: () {}),
                              _CallBtn(
                                  icon: _speakerOn
                                      ? Icons.volume_up_rounded
                                      : Icons.volume_off_rounded,
                                  onTap: () =>
                                      setState(() => _speakerOn = !_speakerOn),
                                  active: _speakerOn),
                              // End call
                              GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                          color: Palette.error,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Palette.error
                                                    .withValues(alpha: 0.4),
                                                blurRadius: 16,
                                                offset: Offset(0, 4))
                                          ]),
                                      child: const Icon(Icons.call_end_rounded,
                                          color: Colors.white, size: 24))),
                            ]),
                      )))),
        ])),
      ]),
    );
  }

  String _callDuration() => '04:32';
}

class _GlassBadge extends StatelessWidget {
  const _GlassBadge(
      {required this.label, required this.icon, required this.color});
  final String label;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) => ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.1))),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(icon, size: 14, color: color),
                const SizedBox(width: 6),
                Text(label,
                    style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.w600)),
              ]))));
}

class _CallBtn extends StatelessWidget {
  const _CallBtn({required this.icon, required this.onTap, this.active = true});
  final IconData icon;
  final VoidCallback onTap;
  final bool active;
  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active
                  ? Colors.white.withValues(alpha: 0.12)
                  : Colors.white.withValues(alpha: 0.06)),
          child: Icon(icon,
              color: active ? Colors.white : Colors.white38, size: 22)));
}
