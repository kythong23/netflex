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
  bool _isInitialized = false;
  Duration? _savePosition;

  void _Pausevideo(){
    setState(() {
      _savePosition = _videoPlayerController.value.position;
      _videoPlayerController.pause();
    });
  }
  @override
  void initState() {
    super.initState();
    _videoPlayerController =  VideoPlayerController.networkUrl(Uri.parse(widget.link))
      ..initialize().then((_) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoPlay: true,
            looping: false,
            fullScreenByDefault: true,
          );
          _isInitialized = true;
        });
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Watching"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: ()async {
            if (_chewieController != null) {
              _Pausevideo();
              await _chewieController.pause();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        height: 350,
        width: 500,
        color: Colors.black,
        child:(widget.link!=null)?
          Container(
          height: 350,
          width: 500,
          color: Colors.black,
          child:_isInitialized? Chewie(
            controller: _chewieController,
          ):const Center(
            child: CircularProgressIndicator(),
          ),
        )
              : const Center(
          child: CircularProgressIndicator(),
        )
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
