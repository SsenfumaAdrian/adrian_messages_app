// FILE: lib/features/search/global_stitch_search.dart

import 'package:flutter/material.dart';
import '../../ui/components/liquid_glass_container.dart';

class GlobalStitchSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = "")];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    // This 'stitches' together search results into a results view
    return Container(
      color: const Color(0xFF0A0A0E),
      child: Center(
        child: LiquidGlassContainer(
          child: Text("Searching for '$query' in your Stitches..."),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0A0E),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Recent Stitch #$index",
                style: const TextStyle(color: Colors.white)),
            onTap: () {},
          );
        },
      ),
    );
  }
}
