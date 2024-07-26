import 'dart:io';
import 'package:flutter/services.dart';
import 'package:netflex/config/const.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'movies.dart';

getFlim(int amount){
  List<Movies> film = [];
  for(int i = 1 ; i<=amount; i++){
      film.add(Movies(
        title: "phim""$i",
        img: "${url_img}poster$i.jpg"
        )
      );
  }
  return film;
}
getFlim1(int amount){
  List<Movies> film = [];
  for(int i = 4 ; i<=amount; i++){
    film.add(Movies(
        title: "phim""$i",
        img: "${url_img}poster$i.jpg"
    )
    );
  }
  return film;
}
Future<List<Map<String, dynamic>>> queryAllMovies(Database database) async {
  return await database.query('movies');
}
Future<Database> initializeDatabase() async {
  // Lấy đường dẫn đến thư mục databases
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "netflex.db");

  // Kiểm tra xem tệp cơ sở dữ liệu đã tồn tại chưa
  var exists = await databaseExists(path);

  if (!exists) {
    // Nếu chưa tồn tại, sao chép tệp từ assets vào thư mục databases
    try {
      await Directory(dirname(path)).create(recursive: true);

      // Sao chép từ asset
      ByteData data = await rootBundle.load(join("assets", "netflex.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Ghi tệp vào hệ thống tệp
      await File(path).writeAsBytes(bytes, flush: true);
    } catch (e) {
      print("Error copying database: $e");
    }
  } else {
    print("Database already exists");
  }
  // Mở cơ sở dữ liệu
  return openDatabase(path);
}