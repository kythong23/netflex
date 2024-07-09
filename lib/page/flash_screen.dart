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
class SetupdataWidget extends StatelessWidget {
  const SetupdataWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: initializeDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Trạng thái đang chờ, có thể hiển thị một widget tạm thời
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Đã xảy ra lỗi
          return Text('Error: ${snapshot.error}');
        } else {
          // Kết quả đã sẵn sàng, có thể sử dụng cơ sở dữ liệu ở đây
          Database database = snapshot.data!;
          return LoginScreen(database: database);
        }
      },
    );
  }
}
class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds:2),() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=> const SetupdataWidget(),
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