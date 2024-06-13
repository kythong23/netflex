import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:netflex/page/home.dart';
import 'package:sqflite/sqflite.dart';

import '../data/data.dart';


class FlashScreen extends StatefulWidget {
  const FlashScreen ({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}
class SetupdataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Database>(
      future: initializeDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Trạng thái đang chờ, có thể hiển thị một widget tạm thời
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Đã xảy ra lỗi
          return Text('Error: ${snapshot.error}');
        } else {
          // Kết quả đã sẵn sàng, có thể sử dụng cơ sở dữ liệu ở đây
          Database database = snapshot.data!;
          return MyHome(database: database);
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
    Future.delayed(Duration(seconds:2),() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_)=> SetupdataWidget(),
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