import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflex/config/const.dart';
import 'package:netflex/page/profile.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/film.dart';
import 'flimwidget.dart';

class DefautlWidget extends StatefulWidget {
  const DefautlWidget({super.key});

  @override
  State<DefautlWidget> createState() => _DefautlWidgetState();
}

class _DefautlWidgetState extends State<DefautlWidget> {
  List<Film> lstposter = [];
  List<Film> lsttrending = [];

  @override
  void initState() {
    lstposter = getFlim(3);
    lsttrending = getFlim(3);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Welcome to NexFlex',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
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
