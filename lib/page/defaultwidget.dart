import 'package:flutter/material.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/search_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'flimwidget.dart';

class DefautlWidget extends StatefulWidget {
  const DefautlWidget({super.key,required this.database});
  final Database database;
  @override
  State<DefautlWidget> createState() => _DefautlWidgetState();
}

class _DefautlWidgetState extends State<DefautlWidget> {
  Future<List<Map<String,dynamic>>> lstposter = Future.value([]);
  List<Movies> lsttrending = [];

  @override
  void initState() {
    lstposter = queryAllMovies(widget.database); // In dữ liệu ra console để kiểm tra
    lsttrending = getFlim(3);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(26, 26, 26, 100),
      body:
      Center(
          child:
          SingleChildScrollView(
            child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children:<Widget> [
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/logo.jpg",
                        width: 100,
                      ),
                      SizedBox(width: 25),
                      Text(
                        "TV Shows",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "Movies",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 25),
                      Text(
                        "My List",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.white,
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SearchScreen()),
                          );
                        },
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  slideposter(lstposter),
                  Row(
                    children: [
                      Text("Trending Movies",
                        style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,),
                      )
                    ],
                  ),
                  slidetrending(lsttrending),
                ]),
          )
      ),
    );
  }
}
