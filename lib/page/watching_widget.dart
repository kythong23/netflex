import 'package:flutter/material.dart';
import 'package:netflex/data/episode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class WatchingWidget extends StatefulWidget {
  final Episode episode;
  const WatchingWidget({super.key,required this.episode});

  @override
  State<WatchingWidget> createState() => _WatchingWidgetState();
}

class _WatchingWidgetState extends State<WatchingWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isInitialized = false;
  Duration? _savePosition;

  void _Pausevideo() async{
    _savePosition = _videoPlayerController.value.position;
    SharedPreferences prefs =await SharedPreferences.getInstance();
    await prefs.setInt("Movie ${widget.episode.movieId} ${widget.episode.name}", _savePosition!.inMilliseconds);
    setState(() {
      _videoPlayerController.pause();
    });
  }
  Future<void> initializeController()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    int? videotime = await prefs.getInt("Movie ${widget.episode.movieId} ${widget.episode.name}");
    if(videotime != null ){
      _savePosition = Duration(milliseconds: videotime!);
      _videoPlayerController =  VideoPlayerController.networkUrl(Uri.parse(widget.episode.link!))
        ..initialize().then((_) {
          setState(() {
            _videoPlayerController.seekTo(_savePosition!);
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: true,
              looping: false,
              fullScreenByDefault: false,
            );
            _isInitialized = true;
          });
        });
    }
    else {
      _videoPlayerController =
      VideoPlayerController.networkUrl(Uri.parse(widget.episode.link!))
        ..initialize().then((_) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoPlayerController,
              autoPlay: true,
              looping: false,
              fullScreenByDefault: false,
            );
            _isInitialized = true;
          });
        });
    }
  }
  @override
  void initState() {
    super.initState();
    initializeController();
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
        child:(widget.episode.link != null)?
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
