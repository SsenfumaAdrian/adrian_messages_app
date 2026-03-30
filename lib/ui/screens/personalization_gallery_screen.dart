// FILE: lib/ui/screens/personalization_gallery_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class PersonalizationGalleryScreen extends StatefulWidget {
  const PersonalizationGalleryScreen({super.key});
  @override
  State<PersonalizationGalleryScreen> createState() => _State();
}

class _State extends State<PersonalizationGalleryScreen> {
  int _theme = 0, _bubble = 0, _wallpaper = 0;
  double _fontSize = 14;
  bool _compactMode = false;

  @override
  Widget build(BuildContext ctx) => AppShell(
      activeRoute: LiquidRouter.personalization,
      title: 'Personalization',
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Live preview
            _SHead('Preview'),
            const SizedBox(height: 12),
            Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: _wallpaperColors[_wallpaper]),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Stack(children: [
                      if (_wallpaper == 1)
                        Container(
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(colors: [
                          Color(0xFF060D1F),
                          Color(0xFF0E1733),
                          Color(0xFF1A237E)
                        ]))),
                      if (_wallpaper == 2)
                        Container(
                            decoration: const BoxDecoration(
                                gradient: RadialGradient(colors: [
                          Color(0xFF1A0038),
                          Color(0xFF2D006E)
                        ], radius: 1.5))),
                      Positioned(
                          left: 16,
                          bottom: 60,
                          child: _BubblePreview(
                              text: 'Hey! How are you?',
                              me: false,
                              style: _bubble,
                              fontSize: _fontSize)),
                      Positioned(
                          right: 16,
                          bottom: 10,
                          child: _BubblePreview(
                              text: 'Doing great, thanks 🙌',
                              me: true,
                              style: _bubble,
                              fontSize: _fontSize)),
                    ]))),
            const SizedBox(height: 24),

            // Theme picker
            _SHead('Theme'),
            const SizedBox(height: 12),
            Row(
                children: ['Light', 'Dark', 'Amoled']
                    .asMap()
                    .entries
                    .map((e) => GestureDetector(
                        onTap: () => setState(() => _theme = e.key),
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                                color: _theme == e.key
                                    ? Palette.primary
                                    : Palette.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(e.value,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: _theme == e.key
                                        ? Colors.white
                                        : Palette.onSurfaceVariant)))))
                    .toList()),
            const SizedBox(height: 24),

            // Bubble style
            _SHead('Bubble Style'),
            const SizedBox(height: 12),
            Row(
                children: ['Rounded', 'Square', 'Minimal']
                    .asMap()
                    .entries
                    .map((e) => GestureDetector(
                        onTap: () => setState(() => _bubble = e.key),
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                                color: _bubble == e.key
                                    ? Palette.primary
                                    : Palette.surfaceContainerHigh,
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(e.value,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: _bubble == e.key
                                        ? Colors.white
                                        : Palette.onSurfaceVariant)))))
                    .toList()),
            const SizedBox(height: 24),

            // Wallpaper
            _SHead('Wallpaper'),
            const SizedBox(height: 12),
            SizedBox(
                height: 80,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _wallpaperNames.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (_, i) => GestureDetector(
                        onTap: () => setState(() => _wallpaper = i),
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: _wallpaperColors[i],
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: _wallpaper == i
                                        ? Palette.primary
                                        : Colors.transparent,
                                    width: 2.5)),
                            child: Center(
                                child: Text(_wallpaperNames[i],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600))))))),
            const SizedBox(height: 24),

            // Font size
            _SHead('Font Size'),
            const SizedBox(height: 8),
            Row(children: [
              const Text('A',
                  style: TextStyle(fontSize: 12, color: Palette.outline)),
              Expanded(
                  child: SliderTheme(
                      data: SliderTheme.of(ctx).copyWith(
                          trackHeight: 3,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8),
                          activeTrackColor: Palette.primary,
                          inactiveTrackColor: Palette.surfaceContainerHigh,
                          thumbColor: Palette.primary),
                      child: Slider(
                          value: _fontSize,
                          min: 12,
                          max: 18,
                          onChanged: (v) => setState(() => _fontSize = v)))),
              const Text('A',
                  style: TextStyle(
                      fontSize: 18,
                      color: Palette.outline,
                      fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 20),

            // Compact mode
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                    color: Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(children: [
                  const Icon(Icons.compress_rounded,
                      color: Palette.primary, size: 20),
                  const SizedBox(width: 12),
                  const Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text('Compact Mode',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Palette.onSurface)),
                        Text('Reduce padding between messages',
                            style: TextStyle(
                                fontSize: 11, color: Palette.onSurfaceVariant)),
                      ])),
                  Switch.adaptive(
                      value: _compactMode,
                      onChanged: (v) => setState(() => _compactMode = v),
                      activeColor: Palette.primary),
                ])),
            const SizedBox(height: 28),

            // Save button
            GestureDetector(
                onTap: () {},
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Palette.primary, Color(0xFF2C3E9E)]),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Palette.primary.withOpacity(0.28),
                              blurRadius: 18,
                              offset: const Offset(0, 6))
                        ]),
                    child: const Center(
                        child: Text('Save Preferences',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 15))))),
            const SizedBox(height: 32),
          ])));

  static const _wallpaperColors = [
    Palette.surfaceContainerLow,
    Color(0xFF060D1F),
    Color(0xFF1A0038),
    Color(0xFF003333),
    Palette.primaryContainer
  ];
  static const _wallpaperNames = [
    'Default',
    'Night\nBlue',
    'Deep\nPurple',
    'Forest',
    'Navy'
  ];
}

class _BubblePreview extends StatelessWidget {
  const _BubblePreview(
      {required this.text,
      required this.me,
      required this.style,
      required this.fontSize});
  final String text;
  final bool me;
  final int style;
  final double fontSize;
  @override
  Widget build(BuildContext ctx) {
    final r = style == 0
        ? 18.0
        : style == 1
            ? 4.0
            : 12.0;
    return Container(
        constraints: const BoxConstraints(maxWidth: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
            color: me ? Palette.primary : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(r),
                topRight: Radius.circular(r),
                bottomLeft: Radius.circular(me ? r : 2),
                bottomRight: Radius.circular(me ? 2 : r))),
        child: Text(text,
            style: TextStyle(
                fontSize: fontSize,
                color: me ? Colors.white : Palette.onSurface)));
  }
}

Widget _SHead(String t) => Text(t,
    style: TextStyle(
        fontFamily: Palette.fontDisplay,
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Palette.primary));
