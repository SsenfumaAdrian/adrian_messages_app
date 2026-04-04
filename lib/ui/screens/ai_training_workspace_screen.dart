// FILE: lib/ui/screens/ai_training_workspace_screen.dart
import 'package:flutter/material.dart';
import '../../core/constants/palette.dart';
import '../../core/navigation/liquid_router.dart';
import '../components/app_shell.dart';

class AiTrainingWorkspaceScreen extends StatefulWidget {
  const AiTrainingWorkspaceScreen({super.key});
  @override
  State<AiTrainingWorkspaceScreen> createState() => _State();
}

class _State extends State<AiTrainingWorkspaceScreen> {
  final _inputCtrl = TextEditingController();
  final _outputCtrl = TextEditingController();
  int _epoch = 0;
  bool _training = false;

  @override
  void dispose() {
    _inputCtrl.dispose();
    _outputCtrl.dispose();
    super.dispose();
  }

  void _startTraining() async {
    setState(() {
      _training = true;
      _epoch = 0;
    });
    for (var i = 1; i <= 5; i++) {
      await Future.delayed(Duration(milliseconds: 600));
      if (mounted) setState(() => _epoch = i);
    }
    if (mounted) setState(() => _training = false);
  }

  @override
  Widget build(BuildContext ctx) => AppShell(
      activeRoute: LiquidRouter.aiTraining,
      title: 'AI Training Workspace',
      child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Header
            Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Palette.primary, Color(0xFF3949AB)]),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withValues(alpha: 0.28),
                          blurRadius: 20,
                          offset: Offset(0, 8))
                    ]),
                child: Row(children: [
                  const Icon(Icons.psychology_rounded,
                      color: Colors.white, size: 36),
                  const SizedBox(width: 14),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        const Text('Adrian Training Workspace',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w800)),
                        const Text(
                            'Fine-tune Adrian\'s responses to your communication style',
                            style:
                                TextStyle(color: Colors.white60, fontSize: 12)),
                        const SizedBox(height: 10),
                        if (_training) ...[
                          Text('Training epoch $_epoch / 5',
                              style: const TextStyle(
                                  color: Palette.accentCyan,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                  value: _epoch / 5,
                                  minHeight: 5,
                                  backgroundColor: Colors.white24,
                                  color: Palette.accentCyan)),
                        ] else if (_epoch == 5)
                          const Text('✓ Training complete!',
                              style: TextStyle(
                                  color: Palette.accentCyan,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)),
                      ])),
                ])),
            const SizedBox(height: 24),

            // Example pairs
            _sectionHead('Training Examples'),
            const SizedBox(height: 12),
            ...[
              (
                'User asked for a project update',
                'Adrian replied with a concise 3-bullet summary with action items'
              ),
              (
                'User said "I\'m overwhelmed"',
                'Adrian responded with empathy and offered to reprioritise the task list'
              ),
              (
                'User requested a meeting',
                'Adrian found 3 open slots and sent a calendar invite automatically'
              ),
            ].map((ex) => Container(
                margin: EdgeInsets.only(bottom: 12),
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withValues(alpha: 0.04),
                          blurRadius: 8)
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                color: Palette.primary,
                                shape: BoxShape.circle)),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(ex.$1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Palette.onSurface))),
                      ]),
                      const SizedBox(height: 6),
                      Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Text(ex.$2,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Palette.onSurfaceVariant,
                                  height: 1.4))),
                    ]))),
            const SizedBox(height: 20),

            // Add example
            _sectionHead('Add Training Example'),
            const SizedBox(height: 12),
            Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Palette.primary.withValues(alpha: 0.04),
                          blurRadius: 10)
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Context / Prompt',
                          style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Palette.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      _TrainField(
                          ctrl: _inputCtrl,
                          hint:
                              'What situation or message triggers this behaviour?'),
                      const SizedBox(height: 14),
                      const Text('Desired Response',
                          style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Palette.onSurfaceVariant)),
                      const SizedBox(height: 8),
                      _TrainField(
                          ctrl: _outputCtrl,
                          hint: 'How should Adrian respond?'),
                      const SizedBox(height: 14),
                      Row(children: [
                        Expanded(
                            child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                        color: Palette.surfaceContainerHigh,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Center(
                                        child: Text('Add Example',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Palette.primary,
                                                fontSize: 13)))))),
                        const SizedBox(width: 10),
                        Expanded(
                            child: GestureDetector(
                                onTap: _training ? null : _startTraining,
                                child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: _training
                                                ? [
                                                    Palette.outline,
                                                    Palette.outline
                                                  ]
                                                : [
                                                    Palette.primary,
                                                    const Color(0xFF2C3E9E)
                                                  ]),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          if (!_training)
                                            BoxShadow(
                                                color: Palette.primary
                                                    .withValues(alpha: 0.28),
                                                blurRadius: 14,
                                                offset: Offset(0, 5))
                                        ]),
                                    child: Center(
                                        child: Text(
                                            _training
                                                ? 'Training...'
                                                : 'Start Training',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize: 13)))))),
                      ]),
                    ])),
            const SizedBox(height: 32),
          ])));
}

class _TrainField extends StatelessWidget {
  const _TrainField({required this.ctrl, required this.hint});
  final TextEditingController ctrl;
  final String hint;
  @override
  Widget build(BuildContext ctx) => TextField(
      controller: ctrl,
      maxLines: 3,
      style: const TextStyle(fontSize: 13, color: Palette.onSurface),
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Palette.outline, fontSize: 13),
          filled: true,
          fillColor: Palette.surfaceContainerLow,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Palette.primary, width: 1.5))));
}

Widget _sectionHead(String t) => Text(t,
    style: TextStyle(
        fontFamily: Palette.fontDisplay,
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Palette.primary));
