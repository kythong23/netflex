import 'package:netflex/config/const.dart';
import 'package:flutter/widgets.dart';
import 'film.dart';
import 'dart:ui';

getFlim(int amount){
  List<Film> film = [];
  for(int i = 1 ; i<=amount; i++){
      film.add(Film(
        name: "phim"+"$i",
        img: url_img+"poster"+"$i"+".jpg"
        )
      );
  }
  return film;
}