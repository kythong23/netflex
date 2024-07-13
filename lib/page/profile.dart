import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflex/config/const.dart';
import 'package:netflex/page/flimwidget.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/page/settingwidget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/user.dart';
import '../provider/provider.dart';
class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<Movies> lstposter = [];
  List<Movies> lsttrending = [];
  late Future<User> futureUser;
  @override
  void initState() {
    super.initState();
    lstposter = getFlim(3);
    lsttrending = getFlim(3);
    futureUser = getUser();
  }
  Future<User> getUser()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    User user = User.fromJson(jsonDecode(pref.getString('user')!));
    return user;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
        builder: (context,UiProvider notifier, child){
          return  Scaffold(
            // backgroundColor: const Color.fromARGB(26, 26, 26, 100),
            appBar: AppBar(
              title: const Text("My profile", style: TextStyle(fontWeight: FontWeight.bold)),
              // backgroundColor: Colors.black,
              actions: [
                IconButton(onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> SettingWidget()));
                }, icon: const Icon(Icons.menu)),
                IconButton(onPressed: (){

                }, icon: const Icon(Icons.search))
              ],
            ),
            body:  Stack(
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: // Đặt độ cong của viền
                                      Image.asset("${url_img}profileicon.jpg", height: 100,),
                                    ),
                                    FutureBuilder(
                                    future: futureUser,
                                    builder: (context,snapshot){
                                      User user = new User();
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return CircularProgressIndicator();
                                      }
                                      else if(snapshot.hasError){
                                        return Text('Error: ${snapshot.error}');
                                      }
                                      else if(snapshot.hasData){
                                        user = snapshot.data!;
                                      }
                                      return Text(
                                        user.username!,
                                      );
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.note_alt,
                              // color: Colors.white,
                            ),
                            Text("Manage Profile",
                                style: TextStyle(
                                  // color: Colors.white
                                )
                            )
                          ],
                        ),
                        const SizedBox(height: 25,),
                        const Row(
                          children: [
                            Text("Trailers You've Watched",
                                style: TextStyle(
                                  // color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        slidetrending(lsttrending,context),
                        const Row(
                          children: [
                            Text("Continue Watching",
                                style: TextStyle(
                                  // color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        slidetrending(lsttrending,context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }
}

