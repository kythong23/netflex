import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:netflex/config/const.dart';
import 'package:netflex/page/profile.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/film.dart';
import 'package:netflex/page/defaultwidget.dart';

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
    var nameWidget = "Home";
    switch (index){
      case 0:
        return const DefautlWidget();
      case 1:
        nameWidget = "Contact";
        break;
      case 2:
        {

        }
      case 3:
        {
          return const MyProfile();
        }
      default:
        {
          return const DefautlWidget();
        }
    }
  }
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
      body: _loadWidget(_selectedIndex),
      bottomNavigationBar:  BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail),
              label: 'Contact'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Info'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
