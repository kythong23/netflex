import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflex/page/home.dart';


class FlashScreen extends StatefulWidget {
  const FlashScreen ({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState(){
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds:2),() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=> const MyHome(),
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
              Image.asset(
                'assets/images/logo.jpg',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3), // Apply a color filter directly
                colorBlendMode: BlendMode.darken, // Blend mode to merge with the background
              ),
            ],
          ),

        ),

      ),
    );
  }
}