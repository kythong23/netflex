import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflex/page/profile.dart';
import 'package:netflex/page/home.dart';
class MenuHome extends StatefulWidget {
  const MenuHome({super.key});

  @override
  State<MenuHome> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(icon: Icon(Icons.home_outlined),color: Colors.white,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHome()),
                      );
                    },),
                  SizedBox(width: 100),
                  Text("Home",
                  style: TextStyle(color: Colors.white),)
                ],
              ),
              Column(
                children: [
                  IconButton(icon: Icon(Icons.backup_table),color: Colors.white,
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyProfile()),
                      );
                    },),
                  SizedBox(width: 100),
                  Text("News",
                    style: TextStyle(color: Colors.white),)
                ],
              ),
              Column(
                children: [
                  IconButton(icon: Icon(Icons.person_2_outlined),color: Colors.white,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfile()),
                    );
                  },),
                  SizedBox(width: 100),
                  Text("Profile",
                    style: TextStyle(color: Colors.white),)
                ],
              ),
            ],
        ),
      ),
    );
  }
}
