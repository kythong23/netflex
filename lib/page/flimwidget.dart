import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflex/config/api_service.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/detail_widget.dart';
import 'package:provider/provider.dart';

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
        return Container(
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
        );
      }
  );

}
