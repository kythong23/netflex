import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflex/config/api_service.dart';
import 'package:netflex/config/const.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/detail_widget.dart';

Widget slideposter(Future<List<Map<String,dynamic>>> listPoster) {
  return FutureBuilder<List<Movies>>(
    future: fetchMovies(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator(); // Hiển thị tiến trình chờ
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
Widget slidetrending(List<Movies> listPoster){
  return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        enlargeCenterPage: false,
        height: 200,
        viewportFraction: 0.45,
      ),
      items: listPoster.map((imgposter) =>
          Container(
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
          )).toList());
}

