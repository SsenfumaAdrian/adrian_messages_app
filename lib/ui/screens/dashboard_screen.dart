// FILE: lib/ui/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import '../components/liquid_glass_container.dart';
import '../../data/mock/dummy_data.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Dynamic Mesh Gradient Background
          Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          )),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text("Adrian Messages",
                      style: Theme.of(context).textTheme.displayLarge),
                  SizedBox(height: 20),

                  // The Refractive Search Bar
                  LiquidGlassContainer(
                    borderRadius: 15,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.white70),
                        hintText: "Search your world...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  // The Scrollable Message List
                  Expanded(
                    child: ListView.builder(
                      itemCount: DummyData.chatList.length,
                      itemBuilder: (context, index) {
                        final chat = DummyData.chatList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: LiquidGlassContainer(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(chat['name'],
                                  style: TextStyle(fontFamily: 'Inter-Bold')),
                              subtitle: Text(chat['lastMessage']),
                              trailing: Text(chat['time']),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
