import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:netflex/page/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../data/data.dart';
import './signupwidget.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen ({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}
class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds:2),() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=> LoginScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Stack(
            children: [
              Lottie.asset('assets/netflex.json'),
            ],
          ),
        ),
      ),
    );
  }

}