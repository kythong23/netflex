import 'package:flutter/material.dart';
import 'package:netflex/page/news.dart';
import 'package:netflex/page/profile.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/defaultwidget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});
  @override
  State<MyHome> createState() => _MyHomeState();
}
class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0 ;
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  _loadWidget (int index){
    switch (index){
      case 0:
        return DefautlWidget();
      case 1:
        return const NewWidget();
      case 2:
        {
          return const MyProfile();
        }
      default:
        {
          return DefautlWidget();
        }
    }
  }
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
      backgroundColor: Colors.black,
      body: _loadWidget(_selectedIndex),
      bottomNavigationBar:  BottomNavigationBar(
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0
                ? const Icon(Icons.home, color: Colors.white)
                : const Icon(Icons.home_outlined, color: Color.fromARGB(
                107, 107, 107, 100)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const Icon(Icons.supervised_user_circle, color: Colors.white)
                : const Icon(Icons.supervised_user_circle_outlined, color: Color.fromARGB(
                107, 107, 107, 100)),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const Icon(Icons.person, color: Colors.white)
                : const Icon(Icons.person_outline, color: Color.fromARGB(
                107, 107, 107, 100)),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(
            107, 107, 107, 100),
        backgroundColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
