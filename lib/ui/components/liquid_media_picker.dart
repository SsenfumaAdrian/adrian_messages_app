// FILE: lib/ui/components/liquid_media_picker.dart

import 'package:flutter/material.dart';
import 'liquid_glass_container.dart';

class LiquidMediaPicker extends StatelessWidget {
  final List<String> mockImages =
      List.generate(12, (i) => "https://picsum.photos/200?random=$i");

  LiquidMediaPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      borderRadius: 40,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2))),
          const Padding(
            padding: EdgeInsets.all(20.0),
            child: Text("Stitch Media",
                style: TextStyle(fontFamily: 'Inter-Bold', fontSize: 18)),
          ),
          SizedBox(
            height: 300,
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: mockImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(mockImages[index], fit: BoxFit.cover),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
