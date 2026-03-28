// FILE: lib/features/stitch/stitch_aggregator.dart

import '../../data/mock/dummy_data.dart';

class StitchAggregator {
  /// Aggregates selected messages into a single 'Stitch' object.
  /// Designed to be 'Smart' by prioritizing important context.
  static Map<String, dynamic> createStitch(List<String> messageIds) {
    // Filtering our dummy data for the selected IDs
    final selectedMessages = DummyData.chatList
        .where((chat) => messageIds.contains(chat['id']))
        .toList();

    return {
      "stitchId": DateTime.now().millisecondsSinceEpoch.toString(),
      "title":
          "Stitched Summary - ${DateTime.now().day}/${DateTime.now().month}",
      "messages": selectedMessages,
      "metadata": {
        "isLiquidFormatted": true,
        "generationMode": "Adaptive",
      }
    };
  }
}
