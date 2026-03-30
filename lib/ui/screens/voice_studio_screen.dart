// FILE: lib/ui/screens/voice_studio_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class VoiceStudioScreen extends StatefulWidget {
  const VoiceStudioScreen({super.key});
  @override
  State<VoiceStudioScreen> createState() => _State();
}

class _State extends State<VoiceStudioScreen>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  double _progress = 0.28;
  late final AnimationController _waveCtrl;
  late final Animation<double> _wave;

  @override
  void initState() {
    super.initState();
    _waveCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat(reverse: true);
    _wave = CurvedAnimation(parent: _waveCtrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _waveCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) => AppShell(
      activeRoute: LiquidRouter.voiceStudio,
      title: 'Voice Studio',
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // Library sidebar
        Container(
            width: 260,
            color: Palette.surfaceContainerLow,
            child: Column(children: [
              const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(children: [
                    Text('Library',
                        style: TextStyle(
                            fontFamily: Palette.fontDisplay,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Palette.primary)),
                    Spacer(),
                    Icon(Icons.add_circle_outline_rounded,
                        color: Palette.primary, size: 20),
                  ])),
              Expanded(
                  child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (_, i) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: i == 0
                                  ? Palette.primary.withOpacity(0.10)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(children: [
                            Icon(Icons.graphic_eq_rounded,
                                color:
                                    i == 0 ? Palette.primary : Palette.outline,
                                size: 18),
                            const SizedBox(width: 10),
                            Expanded(
                                child: Text('Recording ${i + 1}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: i == 0
                                            ? Palette.primary
                                            : Palette.onSurfaceVariant))),
                            Text('${(i + 1) * 47}s',
                                style: const TextStyle(
                                    fontSize: 10, color: Palette.outline)),
                          ])))),
            ])),

        // Main player
        Expanded(
            child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Waveform display
                      Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Palette.primary, Color(0xFF3949AB)]),
                              borderRadius: BorderRadius.circular(24)),
                          child: AnimatedBuilder(
                              animation: _wave,
                              builder: (_, __) => CustomPaint(
                                  painter: _WavePainter(
                                      progress: _progress,
                                      wave: _wave.value)))),
                      const SizedBox(height: 20),

                      // Time
                      const Row(children: [
                        Text('03:45',
                            style: TextStyle(
                                fontFamily: Palette.fontDisplay,
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: Palette.onSurface)),
                        Text(' / 12:45',
                            style: TextStyle(
                                fontSize: 18, color: Palette.outline)),
                      ]),
                      const SizedBox(height: 16),

                      // Scrubber
                      SliderTheme(
                          data: SliderTheme.of(ctx).copyWith(
                              trackHeight: 4,
                              thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 8),
                              activeTrackColor: Palette.primary,
                              inactiveTrackColor: Palette.surfaceContainerHigh,
                              thumbColor: Palette.primary),
                          child: Slider(
                              value: _progress,
                              onChanged: (v) => setState(() => _progress = v))),
                      const SizedBox(height: 20),

                      // Controls
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _CtrlBtn(
                                icon: Icons.skip_previous_rounded,
                                onTap: () {},
                                size: 40),
                            const SizedBox(width: 16),
                            GestureDetector(
                                onTap: () =>
                                    setState(() => _isPlaying = !_isPlaying),
                                child: Container(
                                    width: 68,
                                    height: 68,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          Palette.primary,
                                          Color(0xFF3949AB)
                                        ]),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Palette.primary
                                                  .withOpacity(0.35),
                                              blurRadius: 20,
                                              offset: const Offset(0, 6))
                                        ]),
                                    child: Icon(
                                        _isPlaying
                                            ? Icons.pause_rounded
                                            : Icons.play_arrow_rounded,
                                        color: Colors.white,
                                        size: 32))),
                            const SizedBox(width: 16),
                            _CtrlBtn(
                                icon: Icons.skip_next_rounded,
                                onTap: () {},
                                size: 40),
                            const SizedBox(width: 24),
                            _CtrlBtn(icon: Icons.speed_rounded, onTap: () {}),
                            const SizedBox(width: 12),
                            _CtrlBtn(
                                icon: Icons.bookmark_border_rounded,
                                onTap: () {}),
                            const SizedBox(width: 12),
                            _CtrlBtn(
                                icon: Icons.ios_share_rounded, onTap: () {}),
                          ]),
                      const SizedBox(height: 28),

                      // AI tools
                      const Text('AI Tools',
                          style: TextStyle(
                              fontFamily: Palette.fontDisplay,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Palette.primary)),
                      const SizedBox(height: 12),
                      const Wrap(spacing: 10, runSpacing: 10, children: [
                        _AiChip(
                            label: 'Transcribe',
                            icon: Icons.subtitles_outlined),
                        _AiChip(
                            label: 'Summarise', icon: Icons.summarize_outlined),
                        _AiChip(
                            label: 'Translate', icon: Icons.translate_rounded),
                        _AiChip(
                            label: 'Remove Noise',
                            icon: Icons.noise_aware_outlined),
                      ]),
                    ]))),
      ]));
}

class _WavePainter extends CustomPainter {
  const _WavePainter({required this.progress, required this.wave});
  final double progress, wave;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    final path = Path();
    for (var x = 0.0; x < size.width; x++) {
      final t = x / size.width;
      final y = size.height / 2 +
          30 *
              (t < progress ? 1 : 0.3) *
              (0.5 + 0.5 * wave) *
              (0.5 - (t - 0.5).abs());
      x == 0
          ? path.moveTo(x, size.height / 2 + y)
          : path.lineTo(x, size.height / 2 - y);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_WavePainter o) =>
      o.progress != progress || o.wave != wave;
}

class _CtrlBtn extends StatelessWidget {
  const _CtrlBtn({required this.icon, required this.onTap, this.size = 36});
  final IconData icon;
  final VoidCallback onTap;
  final double size;
  @override
  Widget build(BuildContext ctx) => GestureDetector(
      onTap: onTap,
      child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
              color: Palette.surfaceContainerHigh, shape: BoxShape.circle),
          child: Icon(icon, color: Palette.primary, size: size * 0.5)));
}

class _AiChip extends StatelessWidget {
  const _AiChip({required this.label, required this.icon});
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext ctx) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Palette.primary.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ]),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 16, color: Palette.primary),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Palette.onSurface)),
      ]));
}
