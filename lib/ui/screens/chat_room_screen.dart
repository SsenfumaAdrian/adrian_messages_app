// FILE: lib/ui/screens/chat_room_screen.dart
// Full chat UI — light theme matching Stitch active_chat_view design
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/palette.dart';
import '../components/liquid_glass.dart';
import '../../core/navigation/liquid_router.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.chatName});
  final String chatName;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final _msgCtrl   = TextEditingController();
  final _scroll    = ScrollController();
  bool  _recording = false;

  final _messages = <_Msg>[
    _Msg(text: 'Hey! Have you seen the new UI?',   isMe: false, time: '10:30 AM'),
    _Msg(text: 'It looks amazing. Very 2026!',      isMe: true,  time: '10:31 AM'),
    _Msg(text: 'Adrian AI summarised our Q4 plan.',  isMe: false, time: '10:32 AM'),
    _Msg(text: 'Perfect. Share it to the Circle?',  isMe: true,  time: '10:32 AM'),
    _Msg(text: 'Already done 🚀',                   isMe: false, time: '10:33 AM'),
  ];

  @override
  void dispose() {
    _msgCtrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Msg(text: text, isMe: true,
          time: TimeOfDay.now().format(context)));
      _msgCtrl.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.surface,
      body: Column(children: [
        _ChatHeader(name: widget.chatName),
        Expanded(
          child: ListView.builder(
            controller: _scroll,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: _messages.length,
            itemBuilder: (_, i) => _BubbleTile(msg: _messages[i]),
          ),
        ),
        _InputBar(
          ctrl: _msgCtrl,
          recording: _recording,
          onSend: _send,
          onRecord: () => setState(() => _recording = !_recording),
        ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// CHAT HEADER
// ─────────────────────────────────────────────────────────────
class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: Palette.surface.withValues(alpha: 0.88),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(children: [
                // Back
                LiquidGlassBackButton(size: 40),
                // Avatar
                Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Palette.primary, Color(0xFF3949AB)]),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Center(
                    child: Text(name[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w800, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 10),
                // Name + status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: TextStyle(
                            fontFamily: Palette.fontDisplay,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Palette.primary,
                          )),
                      Row(children: [
                        Container(width: 7, height: 7,
                          decoration: const BoxDecoration(
                            color: Palette.accentCyan,
                            shape: BoxShape.circle)),
                        const SizedBox(width: 4),
                        const Text('Online',
                            style: TextStyle(fontSize: 11,
                                color: Palette.onSurfaceVariant)),
                      ]),
                    ],
                  ),
                ),
                // Action buttons
                _HdrBtn(icon: Icons.call_outlined,
                    onTap: () => Navigator.pushNamed(context,
                        LiquidRouter.callScreen,
                        arguments: {'name': name, 'isVideo': false})),
                _HdrBtn(icon: Icons.videocam_outlined,
                    onTap: () => Navigator.pushNamed(context,
                        LiquidRouter.callScreen,
                        arguments: {'name': name, 'isVideo': true})),
                _HdrBtn(icon: Icons.more_vert_rounded, onTap: () {}),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class _HdrBtn extends StatelessWidget {
  const _HdrBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override Widget build(BuildContext context) => LiquidGlassButton(
    icon: icon,
    size: 38,
    iconSize: 18,
    tint: Palette.primary,
    onTap: onTap,
  );
}

// ─────────────────────────────────────────────────────────────
// MESSAGE BUBBLE
// ─────────────────────────────────────────────────────────────
class _Msg {
  const _Msg({required this.text, required this.isMe, required this.time});
  final String text, time;
  final bool isMe;
}

class _BubbleTile extends StatelessWidget {
  const _BubbleTile({required this.msg});
  final _Msg msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: msg.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!msg.isMe) ...[
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Palette.primary, Color(0xFF3949AB)]),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Center(
                  child: Text('E',
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w800, fontSize: 11))),
            ),
            const SizedBox(width: 8),
          ],
          Column(
            crossAxisAlignment: msg.isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width * 0.68,
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: msg.isMe
                        ? Palette.primary
                        : Palette.surfaceContainerLowest,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(msg.isMe ? 18 : 4),
                      bottomRight: Radius.circular(msg.isMe ? 4 : 18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.primary.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(msg.text,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: msg.isMe
                            ? Colors.white
                            : Palette.onSurface,
                      )),
                ),
              ),
              const SizedBox(height: 3),
              Row(children: [
                Text(msg.time,
                    style: const TextStyle(
                        fontSize: 10, color: Palette.outline)),
                if (msg.isMe) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.done_all_rounded,
                      size: 12, color: Palette.accentCyan),
                ],
              ]),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// INPUT BAR
// ─────────────────────────────────────────────────────────────
class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.ctrl,
    required this.recording,
    required this.onSend,
    required this.onRecord,
  });
  final TextEditingController ctrl;
  final bool recording;
  final VoidCallback onSend, onRecord;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.surface,
        boxShadow: [
          BoxShadow(
            color: Palette.primary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: Row(children: [
            // Attachment
            _BarBtn(icon: Icons.attach_file_rounded, onTap: () {}),
            const SizedBox(width: 6),
            // Text field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Palette.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: TextField(
                  controller: ctrl,
                  maxLines: 4,
                  minLines: 1,
                  onSubmitted: (_) => onSend(),
                  style: const TextStyle(
                      fontSize: 14, color: Palette.onSurface),
                  decoration: const InputDecoration(
                    hintText: 'Type a message…',
                    hintStyle: TextStyle(
                        color: Palette.outline, fontSize: 14),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            // Send / mic
            GestureDetector(
              onTap: onSend,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 44, height: 44,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Palette.primary, Color(0xFF3949AB)]),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Palette.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _BarBtn extends StatelessWidget {
  const _BarBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;
  @override Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 38, height: 38,
      decoration: BoxDecoration(
        color: Palette.surfaceContainerHigh,
        shape: BoxShape.circle),
      child: Icon(icon, color: Palette.primary, size: 20),
    ),
  );
}
