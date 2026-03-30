// FILE: lib/ui/components/liquid_video_player.dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'liquid_glass_container.dart';

class LiquidVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const LiquidVideoPlayer({super.key, required this.videoUrl});

  @override
  _LiquidVideoPlayerState createState() => _LiquidVideoPlayerState();
}

class _LiquidVideoPlayerState extends State<LiquidVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(_controller),
                // Liquid Controls
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: LiquidGlassContainer(
                    borderRadius: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(_controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                          onPressed: () => setState(() =>
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play()),
                        ),
                        Expanded(
                          child: VideoProgressIndicator(_controller,
                              allowScrubbing: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
