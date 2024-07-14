import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflex/config/api_service.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/search_screen.dart';
import 'package:netflex/provider/provider.dart';
import 'package:provider/provider.dart';
import '../data/genres.dart';
import 'flimwidget.dart';

class DefautlWidget extends StatefulWidget {
  const DefautlWidget({super.key});

  @override
  State<DefautlWidget> createState() => _DefautlWidgetState();
}

class _DefautlWidgetState extends State<DefautlWidget> {
  List<Movies> getfilm = [];
  List<Movies> lsttrending = [];
  bool visibile = false;

  @override
  void initState() {
    lsttrending = getFlim(3);
    Future<List<Movies>> getallflim() async {
      Future<List<Movies>> futureMovies = fetchMovies();
      getfilm = await futureMovies;
      return getfilm;
    }
    getallflim();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (context, UiProvider notifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                    width: 100, // Điều chỉnh kích thước hình ảnh
                    height: 100, // Điều chỉnh kích thước hình ảnh
                  ),
                ),
                Spacer(), // Đẩy các phần tử khác sang bên phải
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen(allfilm: getfilm)),
                    );
                  },
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0), // Giảm padding hoặc điều chỉnh theo ý muốn
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: InkWell(
                                    onTap: (){
                                      setState(() {
                                        visibile = !visibile;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: notifier.isDark ? Colors.white : Colors.black, // Đặt màu nền
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Text(
                                        "Genre",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: notifier.isDark ? Colors.black : Colors.white,), // Đặt màu chữ
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(width: 10), // Khoảng cách giữa các container
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: notifier.isDark ? Colors.white : Colors.black, // Đặt màu nền
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    "Movies",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: notifier.isDark ? Colors.black : Colors.white), // Đặt màu chữ
                                  ),
                                ),
                              ),
                              SizedBox(width: 10), // Khoảng cách giữa các container
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: notifier.isDark ? Colors.white : Colors.black, // Đặt màu nền
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    "TV Shows",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: notifier.isDark ? Colors.black : Colors.white), // Đặt màu chữ
                                  ),
                                ),
                              ),
                            ],
                          ),
                          slideposter(context),
                          const Row(
                            children: [
                              Text(
                                "Trending Movies",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          slidetrending(lsttrending, context),
                        ],
                      ),
                      Visibility(
                        visible: visibile,
                        child: Positioned(
                          top: 45,
                          left: 0,
                          right: 0,
                          child: Wrap(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)),
                                  color: Colors.black,
                                ),
                                padding: EdgeInsets.only(top: 16, left: 10, right: 6, bottom: 16),
                                width: MediaQuery.of(context).size.width,
                                child: FutureBuilder(
                                    future: fetchGenres(),
                                    builder: (context,snapshot){
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const CircularProgressIndicator(); // Hiển thị tiến trình chờ
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
                                      } else {
                                        List<Genre> listgenre = snapshot.data!;
                                        return Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: [
                                            for (var genre in listgenre)
                                              listGenre(genre,this.context),
                                          ],
                                        );
                                      }
                                    }),
                              ),
                            ],),
                        ),
                      )],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
