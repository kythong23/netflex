import 'package:flutter/material.dart';
import 'package:netflex/config/const.dart';
import 'package:netflex/page/flimwidget.dart';
import 'package:netflex/data/film.dart';
import 'package:netflex/page/menuhome.dart';
import 'package:netflex/data/data.dart';
class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
        title: Text("My profile", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){

          }, icon: Icon(Icons.menu),color: Colors.white,),
          IconButton(onPressed: (){

          }, icon: Icon(Icons.search),color: Colors.white,)
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: // Đặt độ cong của viền
                    Image.asset(url_img+"profileicon.jpg", height: 100,),
                  ),
                  Text("MyName",
                    style: TextStyle(color: Colors.white),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note_alt,color: Colors.white,),
                      Text("Manage Profile",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      Text("Trailers You've Watched",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  slidetrending(lsttrending),
                  Row(
                    children: [
                      Text("Continue Watching",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  slidetrending(lsttrending),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: -20,
              left: 40,
              height: 100,
              width: 300,
              child: MenuHome())
        ],
      )
    );
  }
}
