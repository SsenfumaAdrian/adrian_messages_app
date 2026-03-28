// FILE: lib/ui/screens/chat_room_screen.dart

import 'package:flutter/material.dart';
import '../components/liquid_glass_container.dart';
import '../components/liquid_glass_button.dart';

class ChatRoomScreen extends StatelessWidget {
  final String chatName;

  const ChatRoomScreen({Key? key, required this.chatName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(chatName, style: const TextStyle(fontFamily: 'Inter-Bold')),
        flexibleSpace: const LiquidGlassContainer(
            borderRadius: 0, child: SizedBox.expand()),
      ),
      body: Stack(
        children: [
          // Background remains constant for the liquid effect
          Container(color: const Color(0xFF0A0A0E)),

          Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 120, left: 16, right: 16),
                  children: [
                    _buildMessageBubble(
                        "Hey! Have you seen the new Liquid UI?", true),
                    _buildMessageBubble("It looks amazing. Very 2026.", false),
                  ],
                ),
              ),

              // Bottom Input Bar
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: LiquidGlassContainer(
                        borderRadius: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    LiquidGlassButton(
                      onTap: () {},
                      child: const Icon(Icons.send_rounded),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        constraints: const BoxConstraints(maxWidth: 280),
        child: LiquidGlassContainer(
          borderRadius: 20,
          child: Text(text),
        ),
      ),
    );
  }
}
