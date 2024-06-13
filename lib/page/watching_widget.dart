import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:chewie/chewie.dart';

class WatchingWidget extends StatefulWidget {
  const WatchingWidget({Key? key}) : super(key: key);

  @override
  State<WatchingWidget> createState() => _WatchingWidgetState();
}

class _WatchingWidgetState extends State<WatchingWidget> {
  late Future<String?> _fetchVideoUrl;
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _fetchVideoUrl = _getVideoUrl();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: '',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  Future<String?> _getVideoUrl() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/2/videos?api_key=30c4f987a253f40576d52debe75c3aea'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      if (results.isNotEmpty) {
        return results[0]['key'];
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
                _youtubePlayerController.load(videoKey);
                return YoutubePlayer(
                  controller: _youtubePlayerController,
                  showVideoProgressIndicator: true,
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
    _youtubePlayerController.dispose();
    super.dispose();
  }
}
