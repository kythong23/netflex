import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class WatchingWidget extends StatefulWidget {
  const WatchingWidget({Key? key}) : super(key: key);

  @override
  State<WatchingWidget> createState() => _WatchingWidgetState();
}

class _WatchingWidgetState extends State<WatchingWidget> {
  late Future<String?> _fetchVideoUrl;
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // Đặt hướng màn hình ngang


    _fetchVideoUrl = _getVideoUrl();
  }

  Future<String?> _getVideoUrl() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/2/videos?api_key=30c4f987a253f40576d52debe75c3aea'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      if (results.isNotEmpty) {
        return "https://vip.opstream17.com/20240418/5285_d02f1264/index.m3u8";
        // Assuming the first result is a YouTube video, you can modify this according to your API response
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Watching"),
      ),
      body: Container(
        height: 350,
        width: 500,
        color: Colors.black,
        child: FutureBuilder<String?>(
          future: _fetchVideoUrl,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final String? videoKey = snapshot.data;
              if (videoKey != null) {
                _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoKey));
                _chewieController = ChewieController(
                  videoPlayerController: _videoPlayerController,
                  autoPlay: true,
                  looping: false,
                  fullScreenByDefault: true,
                );
                return Chewie(
                  controller: _chewieController,
                );
              } else {
                return Center(
                  child: Text('No video found'),
                );
              }
            }
          },
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
