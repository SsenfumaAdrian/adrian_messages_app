// FILE: lib/ui/screens/desktop_layout_wrapper.dart

import 'package:flutter/material.dart';
import '../components/liquid_glass_container.dart';
import 'dashboard_screen.dart';
import 'chat_room_screen.dart';

class DesktopLayoutWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Global background mesh
          Container(color: const Color(0xFF050508)),

          Row(
            children: [
              // Sidebar: The Chat List Pane
              SizedBox(
                width: 350,
                child: DashboardScreen(), // Reusing mobile logic but in a pane
              ),

              // Main View: The Active Stitch/Chat Pane
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LiquidGlassContainer(
                    borderRadius: 30,
                    child:
                        const ChatRoomScreen(chatName: "Select a Conversation"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
