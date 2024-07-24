import 'package:flutter/material.dart';
import 'package:netflex/config/api_service.dart';
import 'package:netflex/data/favormovie.dart';
import 'package:netflex/data/movies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UiProvider extends ChangeNotifier{

  bool _isDark = false;
  bool get isDark => _isDark;

  late SharedPreferences storage;

  //Custom dark theme
  final darkTheme = ThemeData(
    primaryColor: Colors.black12,
    brightness: Brightness.dark,
    primaryColorDark: Colors.black12,
  );

  //Custom light theme
  final lightTheme = ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.light,
      primaryColorDark: Colors.white
  );

  //Now we want to save the last changed theme value


  //Dark mode toggle action
  changeTheme(){
    _isDark = !isDark;

    //Save the value to secure storage
    storage.setBool("isDark", _isDark);
    notifyListeners();
  }

  //Init method of provider
  init()async{
    //After we re run the app
    storage = await SharedPreferences.getInstance();
    _isDark = storage.getBool("isDark")??false;
    notifyListeners();
  }
}
class LanguageProvider extends ChangeNotifier{

  String? lang;

  late SharedPreferences storage;

  //Custom dark theme
  //Now we want to save the last changed theme value


  //Dark mode toggle action
  changeLang(){
    //Save the value to secure storage
    storage.setString("language", lang!);
    notifyListeners();
  }
  //Init method of provider
  init()async{
    //After we re run the app
    storage = await SharedPreferences.getInstance();
    lang = storage.getString("language")??"en";
    notifyListeners();
  }
}
class FavorProvider extends ChangeNotifier{
  int selectAmount=0;
  List<int> selectedList=[];
  List<int?> selectedFavorIdList=[];
  List<FavorMovies>favorList = [];
  List<Movies> moviesByIdList = [];
  Movies movies = Movies();
  int? userId;
  addRemove(int i,FavorMovies f){
    selectedList.add(i);
    selectedFavorIdList.add(f.favorId);
    notifyListeners();
  }
  minusRemove(int i,FavorMovies f){
    selectedList.remove(i);
    selectedFavorIdList.remove(f.favorId);
    notifyListeners();
  }
  bool checkExistFavorMovies(FavorMovies fav){
    bool check=false;
    for(var i in favorList){
      if (i.movieId==fav.movieId){
        check = true;
      }
    }
    return check;
  }
  addMovie(Movies m, FavorMovies f){
    moviesByIdList.add(m);
    favorList.add(f);
  }
  delRemove(){
    selectAmount = selectAmount-selectedList.length;
    notifyListeners();
  }
  getFavorAndMoviesList()async{
    favorList = await fetchFavorByUserId(userId!);
    for(var i in favorList){
      movies =await fetchMoviesById(i.movieId!);
      moviesByIdList.add(movies);
    }
    notifyListeners();
  }
  delAPI()async{
    for(var i in selectedFavorIdList){
      await deleteFavorMovie(i);
    }
  }
  delInTime(){
    selectedList.sort();
    List<int>sortList=selectedList.reversed.toList();
    for(var i in sortList){
      moviesByIdList.removeAt(i);
      favorList.removeAt(i);
    }
    selectedList.clear();
    notifyListeners();
  }
  clearAll(){
    favorList.clear();
    moviesByIdList.clear();
  }
}