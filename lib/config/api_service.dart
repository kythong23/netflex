import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:netflex/data/episode.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/data/user.dart';
import 'package:netflex/data/user_signin.dart';

Future<List<Movies>> fetchMovies() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5042/api/Movies'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => Movies.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load Movie');
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

Future<User?> fetchUserByEmail(String email) async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5042/api/Users/signin/$email'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return User.fromJson(data);
  } else {
    return null;
  }
}