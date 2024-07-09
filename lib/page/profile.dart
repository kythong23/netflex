import 'package:flutter/material.dart';
import 'package:netflex/config/const.dart';
import 'package:netflex/page/flimwidget.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/page/settingwidget.dart';
class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<Movies> lstposter = [];
  List<Movies> lsttrending = [];

  @override
  void initState() {
    lstposter = getFlim(3);
    lsttrending = getFlim(3);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(26, 26, 26, 100),
      appBar: AppBar(
        title: const Text("My profile", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            Navigator.pop(context,MaterialPageRoute(builder: (context)=> SettingWidget()));
          }, icon: const Icon(Icons.menu),color: Colors.white,),
          IconButton(onPressed: (){

          }, icon: const Icon(Icons.search),color: Colors.white,)
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
                    Image.asset("${url_img}profileicon.jpg", height: 100,),
                  ),
                  const Text("MyName",
                    style: TextStyle(color: Colors.white),),
                  const SizedBox(height: 10,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.note_alt,color: Colors.white,),
                      Text("Manage Profile",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  const SizedBox(height: 25,),
                  const Row(
                    children: [
                      Text("Trailers You've Watched",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  slidetrending(lsttrending,context),
                  const Row(
                    children: [
                      Text("Continue Watching",
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                    ],
                  ),
                  slidetrending(lsttrending,context),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
