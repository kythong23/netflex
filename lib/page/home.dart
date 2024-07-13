import 'package:flutter/material.dart';
import 'package:netflex/page/news.dart';
import 'package:netflex/page/profile.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/defaultwidget.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});
  @override
  State<MyHome> createState() => _MyHomeState();
}
class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _loadWidget(int index) {
    switch (index) {
      case 0:
        return DefautlWidget();
      case 1:
        return const NewWidget();
      case 2:
        {
          return MyProfile();
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
    return Consumer<UiProvider>(
      builder: (context, UiProvider notifier, child) {
        return Scaffold(
          // backgroundColor: Colors.black,
          body: _loadWidget(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? const Icon(Icons.home,)
                    : const Icon(Icons.home_outlined,),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? const Icon(
                    Icons.supervised_user_circle)
                    : const Icon(
                  Icons.supervised_user_circle_outlined,
                ),
                label: 'News',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? const Icon(Icons.person,)
                    : const Icon(Icons.person_outline,),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: notifier.isDark ? Colors.white : Colors.red,
            unselectedItemColor: notifier.isDark ? Colors.grey : Colors.black54,
            backgroundColor: notifier.isDark ? Colors.black : Color.fromRGBO(
                238, 238, 238, 1.0),
            onTap: _onItemTapped,
          ),
        );
      },
    );
  }
}
