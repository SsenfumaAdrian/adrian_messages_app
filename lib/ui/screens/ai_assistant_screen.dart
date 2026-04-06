// FILE: lib/ui/screens/ai_assistant_screen.dart
import 'dart:async' show unawaited;

import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../components/app_scaffold.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final _ctrl   = TextEditingController();
  final _scroll = ScrollController();
  final _msgs   = <_Msg>[
    const _Msg(
      text: 'Good morning. You have 3 unread messages and a meeting at 2 PM.'
            ' How can I assist you today?',
      isAI: true,
    ),
  ];
  bool _thinking = false;

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _msgs.add(_Msg(text: text, isAI: false));
      _thinking = true;
      _ctrl.clear();
    });

    // unawaited — fire-and-forget response simulation
    unawaited(
      Future.delayed(Duration(milliseconds: 1200), () {
        if (!mounted) return;
        setState(() {
          _thinking = false;
          _msgs.add(_Msg(
            text: 'I\'ve analysed your request about "$text". '
                  'Let me pull the relevant context from your conversations and files.',
            isAI: true,
          ));
        });
        // unawaited scroll-to-bottom
        unawaited(
          Future.delayed(Duration(milliseconds: 100), () {
            if (_scroll.hasClients) {
              unawaited(_scroll.animateTo(
                _scroll.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              ));
            }
          }),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Adrian AI',
      showBack: false,
      child: Column(children: [
        // ── Quick action chips ───────────────────────────────
        SizedBox(
          height: 52,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              'Summarise my week',
              'Draft a message',
              'Find a file',
              'Schedule meeting',
            ].map((s) => GestureDetector(
              onTap: () {
                _ctrl.text = s;
                _send();
              },
              child: Container(
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Palette.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  s,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Palette.primary,
                  ),
                ),
              ),
            )).toList(),
          ),
        ),

        // ── Message list ─────────────────────────────────────
        Expanded(
          child: ListView.builder(
            controller: _scroll,
            padding: EdgeInsets.all(16),
            itemCount: _msgs.length + (_thinking ? 1 : 0),
            itemBuilder: (_, i) {
              if (_thinking && i == _msgs.length) return const _ThinkingDots();
              return _Bubble(msg: _msgs[i]);
            },
          ),
        ),

        // ── Input bar ────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: Palette.surface,
            boxShadow: [
              BoxShadow(
                color: Palette.primary.withValues(alpha: 0.05),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: TextField(
                      controller: _ctrl,
                      onSubmitted: (_) => _send(),
                      style: const TextStyle(fontSize: 14, color: Palette.onSurface),
                      decoration: const InputDecoration(
                        hintText: 'Ask Adrian anything...',
                        hintStyle: TextStyle(color: Palette.outline),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Palette.primary, Color(0xFF3949AB)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────────────────────
class _Msg {
  const _Msg({required this.text, required this.isAI});
  final String text;
  final bool isAI;
}

// ─────────────────────────────────────────────────────────────
// CHAT BUBBLE
// ─────────────────────────────────────────────────────────────
class _Bubble extends StatelessWidget {
  const _Bubble({required this.msg});
  final _Msg msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: msg.isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.75,
        ),
        decoration: BoxDecoration(
          color: msg.isAI ? Palette.surfaceContainerLowest : Palette.primary,
          borderRadius: BorderRadius.only(
            topLeft:     Radius.circular(18),
            topRight:    Radius.circular(18),
            bottomLeft:  Radius.circular(msg.isAI ? 4 : 18),
            bottomRight: Radius.circular(msg.isAI ? 18 : 4),
          ),
          boxShadow: [
            BoxShadow(
              color: Palette.primary.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          msg.text,
          style: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: msg.isAI ? Palette.onSurface : Colors.white,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// THINKING INDICATOR
// ─────────────────────────────────────────────────────────────
class _ThinkingDots extends StatelessWidget {
  const _ThinkingDots();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Palette.surfaceContainerLowest,
          borderRadius: BorderRadius.only(
            topLeft:     Radius.circular(18),
            topRight:    Radius.circular(18),
            bottomRight: Radius.circular(18),
            bottomLeft:  Radius.circular(4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8, height: 8,
              decoration: BoxDecoration(
                color: Palette.accentCyan,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 8, height: 8,
              decoration: BoxDecoration(
                color: Palette.accentCyan.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 8, height: 8,
              decoration: BoxDecoration(
                color: Palette.accentCyan.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
