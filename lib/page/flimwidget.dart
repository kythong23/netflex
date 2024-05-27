import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflex/config/const.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/film.dart';

Widget slideposter(List<Film> listPoster) {
  return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        height: 300,
      ),
      items: listPoster
          .map((imgposter) => Container(
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
              ))
          .toList());
}
Widget slidetrending(List<Film> listPoster){
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

