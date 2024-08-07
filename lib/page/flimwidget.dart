import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflex/config/api_service.dart';
import 'package:netflex/data/favormovie.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/detail_widget.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../data/genres.dart';
import '../provider/provider.dart';
Widget slideposter(BuildContext context) {
  return FutureBuilder<List<Movies>>(
    future: fetchMovies(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator(); // Hiển thị tiến trình chờ
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
      } else {
        // Xử lý kết quả từ Future và hiển thị CarouselSlider
        List<Movies> listPoster = snapshot.data!;
        return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            height: 300,
          ),
          items: listPoster
              .map((e) => GestureDetector(
            onTap: (){
              Movies movies = e;
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailWidget(movies: movies)));
            },
            child:Container(
              margin: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  e.img!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ))
              .toList(),
        );
      }
    },
  );
}
Widget slidetrending(List<Movies> listPoster,BuildContext context){
  return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: false,
        height: 200,
        viewportFraction: 0.45,
      ),
      items: listPoster.map((imgposter) =>
          GestureDetector(
            onTap:(){

            },
            child: Container(
              margin: const EdgeInsets.all(5.0),
              height: 500,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(
                      imgposter.img!,
                      fit: BoxFit.cover,
                      height: 500,
                    ),
                  ],
                ),
              ),
            ),
          )
      ).toList());
}
Widget itemListView (Movies movies,BuildContext context){
  return Consumer<UiProvider>(
      builder: (context,UiProvider notifier, child){
        return InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailWidget(movies: movies)));
          },
          child: Container(
              color: Colors.black12,
              child:
              Row(
                children: [
                  Image.network(
                    width: 100,
                    height: 100,
                    movies.img!,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(width: 10,),
                  Text(movies.title!,
                    style: TextStyle(
                      // color: Colors.white,
                    ),),
                ],
              )
          ),
        );
      }
  );
}
Widget listGenre (String? name,BuildContext context){
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16)
    ),
    child: Text(name!,
      style: TextStyle(
          color: Colors.white
      ),),
  );
}
class ListMovieByGenre extends StatefulWidget {
  final int? movieId;
  const ListMovieByGenre({super.key,required this.movieId});

  @override
  State<ListMovieByGenre> createState() => _ListMovieByGenreState();
}

class _ListMovieByGenreState extends State<ListMovieByGenre> {
  bool isCheck=false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchMoviesById(widget.movieId!),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // Hiển thị tiến trình chờ
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
          } else {
            Movies m = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(m.img!,height: 180,width: 120,fit: BoxFit.cover,),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    constraints: BoxConstraints(
                      maxWidth: 230,
                      maxHeight: 180,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.title!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),),
                        SizedBox(height: 10,),
                        Text(
                          m.description!,
                          style: const TextStyle(
                            // color: Colors.white,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Row(
                          children: [
                            ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailWidget(movies: m)));
                            },
                              child: Text('Watch Now'),
                            ),
                            Spacer(),
                            Icon(Icons.favorite),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }});

  }
}
class ListFavor extends StatefulWidget {
  final int index;
  final FavorProvider value;
  final Movies m;
  final FavorMovies favorMovies;
  const ListFavor({super.key,required this.m,required this.value,required this.index,required this.favorMovies});

  @override
  State<ListFavor> createState() => _ListFavor();
}

class _ListFavor extends State<ListFavor> {
  bool isCheck=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.m.img!,height: 180,width: 120,fit: BoxFit.cover,),
          Container(
            margin: EdgeInsets.only(left: 10),
            constraints: BoxConstraints(
              maxWidth: 230,
              maxHeight: 180,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.m.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                SizedBox(height: 10,),
                Text(
                  widget.m.description!,
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                Row(
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailWidget(movies: widget.m)));
                    },
                      child: Text('Watch Now'),
                    ),
                    Spacer(),
                    Icon(Icons.favorite),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
            child: Checkbox(
                value: isCheck,
                activeColor: Colors.orangeAccent,
                onChanged: (newValue){
                  setState(() {
                    isCheck = newValue!;
                  });
                  if(isCheck){
                    widget.value.addRemove(widget.index,widget.favorMovies);
                  }
                  else{
                    widget.value.minusRemove(widget.index,widget.favorMovies);
                  }
                }),
          ),
        ],
      ),
    );
  }
}

