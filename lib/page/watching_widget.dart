import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class WatchingWidget extends StatefulWidget {
  final String link;
  const WatchingWidget({super.key,required this.link});

  @override
  State<WatchingWidget> createState() => _WatchingWidgetState();
}

class _WatchingWidgetState extends State<WatchingWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watching"),
      ),
      body: Container(
        height: 350,
        width: 500,
        color: Colors.black,
        child: (widget.link!=null)?
          Container(
          height: 350,
          width: 500,
          color: Colors.black,
          child: Chewie(
            controller: ChewieController(
              videoPlayerController:
              VideoPlayerController.networkUrl(Uri.parse(widget.link)),
              autoPlay: true,
              looping: false,
              fullScreenByDefault: true,
            ),
          ),
        )
              : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}
