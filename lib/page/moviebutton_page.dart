import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/data/user.dart';
import 'package:netflex/provider/provider.dart';
import 'package:provider/provider.dart';

import '../config/api_service.dart';
import '../config/const.dart';
import '../data/favormovie.dart';

class MovieButtonPage extends StatelessWidget{
  final Movies movies;
  final User user;
  final BuildContext context;
  const MovieButtonPage({super.key,required this.movies, required this.user,required this.context});
  Future addFavMov()async{
    FavorMovies favorMovies = new FavorMovies();
    favorMovies.userId = user.userId;
    favorMovies.movieId = movies.id!;
    bool isExits = Provider.of<FavorProvider>(context,listen: false).checkExistFavorMovies(favorMovies);
    if(isExits){
      failDialog("ADD FAIL","Movie has exist in your list <3",context);
    }
    else{
      bool validate = await addFavor(favorMovies);
      if(validate) {
        List<FavorMovies> l = await fetchFavorByUserId(user.userId!);
        favorMovies = l.firstWhere((element) => element.movieId == movies.id);
        Provider.of<FavorProvider>(context,listen: false).addMovie(movies, favorMovies);
        ShowDialog("Add success",context);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: ()async{
              await addFavMov();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF292B37),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF292B37).withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF292B37),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF292B37).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: 35,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF292B37),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF292B37).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.download,
              color: Colors.white,
              size: 35,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF292B37),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF292B37).withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.share,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

}