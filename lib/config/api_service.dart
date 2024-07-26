import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:netflex/data/episode.dart';
import 'package:netflex/data/favormovie.dart';
import 'package:netflex/data/moviegenres.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/data/user.dart';
import 'package:netflex/data/user_signin.dart';
import 'package:netflex/provider/provider.dart';
import 'package:provider/provider.dart';
import '../api/google_signin_api.dart';
import '../data/genres.dart';

Future<List<Movies>> fetchMovies() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5042/api/Movies'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Movies.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Movie');
  }
}
Future<Movies> fetchMoviesById(int id) async {
  List<Movies> allMovies = await fetchMovies();
  Movies moviesById = allMovies.firstWhere((element) => element.id == id);
  return moviesById;
}
Future<List<MovieGenres>> fetchMovieGenres() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5042/api/MovieGenres'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => MovieGenres.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load MovieGenres');
  }
}
Future<List<MovieGenres>> fetchMoviesByGenre(int id) async {
  List<MovieGenres> allGenre = await fetchMovieGenres();
  List<MovieGenres> movieByGenre = allGenre.where((e) => e.genreId == id).toList();
  return movieByGenre;
}
Future<List<Genre>> fetchGenres() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5042/api/Genres'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Genre.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Genre');
  }
}
Future<List<Episode>> fetchEpisode() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5042/api/Episodes'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Episode.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Episode');
  }
}
Future<List<Episode>> fetchEpisodesByMovieId(int id) async {
  List<Episode> allEpisodes = await fetchEpisode();
  List<Episode> filteredEpisodes = allEpisodes.where((episode) => episode.movieId == id).toList();
  return filteredEpisodes;
}

Future<bool> checkEmail(String email) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5042/api/Users/exists/$email'));

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<bool> createUser(User user) async{
  final response = await http.post(
    Uri.parse('http://10.0.2.2:5042/api/Users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );
  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }

}

Future<bool> checkUser(UserSignIn user) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:5042/api/Users/signin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
Future<bool> addFavor(FavorMovies favorMovies) async{
  final response = await http.post(
    Uri.parse('http://10.0.2.2:5042/api/FavorMovies'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(favorMovies.toJson()),
  );
  if (response.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}
Future<List<FavorMovies>> fetchFavor() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5042/api/FavorMovies'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => FavorMovies.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load FavorMovies');
  }
}
Future<List<FavorMovies>> fetchFavorByUserId(int id) async {
  List<FavorMovies> allFavors = await fetchFavor();
  List<FavorMovies> favorByUser = allFavors.where((e) => e.userId == id).toList();
  return favorByUser;
}
Future<User?> fetchUserByEmail(String email) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5042/api/Users/signin/$email'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return User.fromJson(data);
  } else {
    return null;
  }
}
Future<bool> deleteFavorMovie(int? id) async {
  final response = await http.delete(
    Uri.parse('http://10.0.2.2:5042/api/FavorMovies/$id'),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
Future<String?> translate(String text,BuildContext context)async{
  String? lang = Provider.of<LanguageProvider>(context, listen: false).lang;
  var t =  await GoogleTrans.translator.translate(text, to: lang!);
  return t.toString();
}