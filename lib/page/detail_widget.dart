import 'package:flutter/material.dart';
import 'package:netflex/config/api_service.dart';
import 'package:netflex/data/episode.dart';
import 'package:netflex/page/moviebutton_page.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/watching_widget.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../provider/provider.dart';
class DetailWidget extends StatefulWidget {
  final Movies movies;
  const DetailWidget({super.key,required this.movies});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  late YoutubePlayerController _controller;
  late Episode defaultepisode ;
  @override
  Widget build(BuildContext context) {
    Movies movies = widget.movies;
    return Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child){
          return Scaffold(
            // backgroundColor: Colors.black,
              body: Stack(
                  children:[
                    SingleChildScrollView(
                      child: SafeArea(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.arrow_back,
                                        // color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){},
                                      child: const Icon(
                                        Icons.favorite_border,
                                        // color: Colors.white,
                                        size: 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 16 / 9, // Tỷ lệ khung hình 16:9
                                        child: Container(
                                          color: Colors.black,
                                          child:(widget.movies.trailer! !=" ")
                                              ?YoutubePlayer(controller: _controller)
                                              :Container(),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          Container(
                                            height: 60,
                                            width: MediaQuery.of(context).size.width *0.9,
                                            decoration: BoxDecoration(
                                                color: notifier.isDark ? Colors.white : Colors.black,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => WatchingWidget(episode: defaultepisode,),
                                                ));
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                      Icons.play_arrow,
                                                      size: 40,
                                                      color: notifier.isDark ? Colors.black : Colors.white
                                                  ),
                                                  SizedBox(width: 8), // Khoảng cách giữa icon và text
                                                  Text(
                                                    'Play',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: notifier.isDark ? Colors.black : Colors.white
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              const MovieButtonPage(),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movies.title!,
                                      style: const TextStyle(
                                        // color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height:15),
                                    ReadMoreText(
                                      movies.description?? "No description",
                                      style: const TextStyle(
                                        // color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      trimMode: TrimMode.Line,
                                      trimLines: 2,
                                      // colorClickableText: Colors.pink,
                                      trimCollapsedText: 'Show more',
                                      trimExpandedText: 'Show less',
                                      moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height:15),
                                    FutureBuilder(
                                        future: fetchEpisodesByMovieId(widget.movies.id!),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const CircularProgressIndicator(); // Hiển thị tiến trình chờ
                                          } else if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
                                          } else {
                                            List<Episode> listepisode = snapshot.data!;
                                            return Wrap(
                                              spacing: 10,
                                              children: [
                                                for (var episode in listepisode)
                                                  listEpisode(episode,this.context,listepisode),
                                              ],
                                            );
                                          }
                                        }
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Recommended",
                                      style: TextStyle(
                                        // color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 15),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for ( int i =1; i <4; i++)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.asset(
                                            "assets/images/poster$i.jpg",
                                            height: 200,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    )
                    ,]
              ));
        }
    );
  }
  Widget listEpisode (Episode episode,BuildContext context,List<Episode> listepisode){
    if(listepisode.length == 1 ){
      defaultepisode = episode;
    }
    if(episode.name! == "Tập 1"){
      defaultepisode = episode;
    };
    return ElevatedButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute
        (builder: (context)=>WatchingWidget(episode: episode,)));
    },
      child: Text(
        episode.name!,
        style:
        const TextStyle(
          color: Colors.white,
        ),
      ),);
  }

  @override
  void initState() {
    super.initState();
    if(widget.movies.trailer != null ){
      final videoid = YoutubePlayer.convertUrlToId(widget.movies.trailer!);
      _controller = YoutubePlayerController(initialVideoId: videoid!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
    }
    else {
      widget.movies.trailer = " ";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}