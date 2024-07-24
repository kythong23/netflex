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
  List<Movies> getFilm = [];
  List<Movies> lstTrending = [];
  bool visible = false;
  late String? _genre;
  late String? _movies;
  late String? _tvShows;
  late String? _trending;
  bool reload= true;
  bool translating = true;
  List<String?> _afterTrans= [];
  Future transLate()async{
    _genre =await translate("Genre",context);
    _movies =await translate("Movies",context);
    _tvShows =await translate("TV Shows",context);
    _trending =await translate("Trending Movies",context);
    setState((){
      translating = !translating;
    });
  }
  Future<List<Movies>> getAllFilm() async {
    Future<List<Movies>> futureMovies = fetchMovies();
    getFilm = await futureMovies;
    return getFilm;
  }
  Future transGenre()async{
    List<Genre> _espisode= await fetchGenres();
    for(var e in _espisode){
      _afterTrans.add(await translate(e.genreName!, context));
    }
  }
  @override
  void initState() {
    super.initState();
    lstTrending = getFlim(3);
    getAllFilm();
    transLate();
    transGenre();
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
                      MaterialPageRoute(builder: (context) => SearchScreen(allfilm: getFilm)),
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
                                        visible = !visible;
                                      });
                                    },
                                    child: Container(
                                      height: 43,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: notifier.isDark ? Colors.white : Colors.black, // Đặt màu nền
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child:
                                      (!translating)?Text(_genre!, textAlign: TextAlign.center,
                                          style: TextStyle(color: notifier.isDark ? Colors.black : Colors.white,)): Text("Loading"),
                                    ),
                                  ),
                                ),
                              SizedBox(width: 10), // Khoảng cách giữa các container
                              Expanded(
                                child: Container(
                                  height: 43,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: notifier.isDark ? Colors.white : Colors.black, // Đặt màu nền
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child:
                                  (!translating)?Text(_movies!, textAlign: TextAlign.center,
                                      style: TextStyle(color: notifier.isDark ? Colors.black : Colors.white,)): Text("Loading"),
                                ),
                              ),
                              SizedBox(width: 10), // Khoảng cách giữa các container
                              Expanded(
                                child: Container(
                                  height: 43,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: notifier.isDark ? Colors.white : Colors.black, // Đặt màu nền
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: (!translating)?Text(_tvShows!, textAlign: TextAlign.center,
                                      style: TextStyle(color: notifier.isDark ? Colors.black : Colors.white,
                                      overflow: TextOverflow.ellipsis)): Text("Loading"),
                                ),
                              ),
                            ],
                          ),
                          slideposter(context),
                           Row(
                            children: [
                              (!translating)?Text(_trending!, textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,)): Text("Loading"),
                            ],
                          ),
                          slidetrending(lstTrending, context),
                        ],
                      ),
                      Visibility(
                        visible: visible,
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
                                        List<String?> listgenre = _afterTrans;
                                        return Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: [
                                            for (var genrename in listgenre)
                                              listGenre(genrename,this.context),
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
