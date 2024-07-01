import 'package:flutter/material.dart';
import 'package:netflex/config/api_service.dart';
import 'package:netflex/data/episode.dart';
import 'package:netflex/page/moviebutton_page.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/watching_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class DetailWidget extends StatefulWidget {
  final Movies movies;
  const DetailWidget({super.key,required this.movies});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  late YoutubePlayerController _controller;
  @override
  Widget build(BuildContext context) {
    Movies movies = widget.movies;
    return Scaffold(
      backgroundColor: Color.fromARGB(26, 26, 26, 100),
      body: Stack(
        children:[
          Opacity(
            opacity: 0.4,
            child: Image.network(
              movies.img!,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          InkWell(
                            onTap: (){},
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9, // Tỷ lệ khung hình 16:9
                              child: Container(
                                color: Colors.black,
                                child:widget.movies!.trailer! !=" " ? Container():Container(),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      movies.img!,
                                      height: 125,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(right: 50,top: 70),
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: Colors.red,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child:
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute
                                        (builder: (context)=>WatchingWidget(link: " ",)));
                                    },
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    MovieButtonPage(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movies.title!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height:15),
                          Text(
                            movies.description?? "No description",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height:15),
                          FutureBuilder(
                              future: fetchEpisodesByMovieId(widget.movies!.id!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // Hiển thị tiến trình chờ
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
                                } else {
                                  List<Episode> listepisode = snapshot.data!;
                                  return Column(
                                    children: [
                                      for (var episode in listepisode)
                                        listEpisode(episode),
                                    ],
                                  );
                                }
                              }
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Recommended",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for ( int i =1; i <4; i++)
                            Padding(
                              padding: EdgeInsets.only(left: 10),
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
  Widget listEpisode (Episode episode){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute
              (builder: (context)=>WatchingWidget(link: episode.link!,)));
          },
              child: Text(
                episode.name!,
                style:
                TextStyle(
                  color: Colors.black,
                ),
              ),)
      ],),
    );
  }

  @override
  void initState() {
    super.initState();
    if(widget.movies.trailer != null ){
      final videoid = YoutubePlayer.convertUrlToId(widget.movies.trailer!);
      _controller = YoutubePlayerController(initialVideoId: videoid!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
        ),
      );
    }
    else
      widget.movies.trailer = " ";
  }
}