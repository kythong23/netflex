import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflex/config/const.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/film.dart';
import 'flimwidget.dart';
import 'menuhome.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<Film> lstposter = [];
  List<Film> lsttrending = [];

  @override
  void initState() {
    lstposter = getFlim(3);
    lsttrending = getFlim(3);
  }

  @override
  void setState(VoidCallback fn) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Welcome to NexFlex',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child:
            Stack(
              children: [
                Column(
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
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                Positioned(
                  bottom: 0,
                    left: 40,
                    height: 100,
                    width: 300,
                    child: MenuHome())
              ],
            ),

      ),
    );
  }
}
