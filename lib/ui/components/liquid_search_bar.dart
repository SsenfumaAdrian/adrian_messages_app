// FILE: lib/ui/components/liquid_search_bar.dart

import 'package:flutter/material.dart';
import 'liquid_glass_container.dart';

class LiquidSearchBar extends StatefulWidget {
  final Function(String) onSearch;
  const LiquidSearchBar({super.key, required this.onSearch});

  @override
  _LiquidSearchBarState createState() => _LiquidSearchBarState();
}

class _LiquidSearchBarState extends State<LiquidSearchBar> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // Subtle glow when focused to create the 'Liquid' feel
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (_isFocused)
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 2,
            )
        ],
      ),
      child: LiquidGlassContainer(
        borderRadius: 20,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Focus(
          onFocusChange: (hasFocus) => setState(() => _isFocused = hasFocus),
          child: TextField(
            onChanged: widget.onSearch,
            style: const TextStyle(
                fontFamily: 'Inter-Medium', color: Colors.white),
            decoration: const InputDecoration(
              hintText: "Search conversations...",
              hintStyle: TextStyle(color: Colors.white38),
              icon: Icon(Icons.search_rounded, color: Colors.white70),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
