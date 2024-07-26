import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  int selectedIndex= -1;
  List<Movies> getFilm = [];
  List<Movies> lstTrending = [];
  List<Movies> lstTrending1 = [];
  bool visible = false;
  late Future<String?> t;
  late String? _trending;
  late String? newRelease;
  List<Genre> genreList = [];
  bool reload= true;
  bool translating = true;
  Future transLate()async{
    _trending =await translate("Trending Movies",context);
    newRelease =await translate("New Release",context);
    setState((){
      translating = !translating;
    });
  }
  Future<List<Movies>> getAllFilm() async {
    Future<List<Movies>> futureMovies = fetchMovies();
    getFilm = await futureMovies;
    return getFilm;
  }
  Future addGenre(Genre e,List<Genre> list,Future<String?> t)async{
    list.add(Genre(
      genreId: e.genreId,
      genreName:await t,
    ));
  }
  Future transGenre()async{
    List<Genre> genre= await fetchGenres();
    List<Genre>afterTrans=[];
    for(int i = 0; i <=2; i++){
      Genre e = genre[i];
      t = translate(e.genreName!,context);
      await addGenre(e,afterTrans,t);
    }
    genreList = afterTrans;
  }
  @override
  void initState() {
    super.initState();
    lstTrending = getFlim(3);
    lstTrending1 = getFlim1(6);
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
              automaticallyImplyLeading: false,
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
            body:Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), // Giảm padding hoặc điều chỉnh theo ý muốn
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FutureBuilder(
                                    future: transGenre(),
                                    builder: (context,snapshot){
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return(genreList.isEmpty)? const CircularProgressIndicator():
                                        Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: [
                                            for (var genrename in genreList)
                                              listGenreCate(genrename,this.context),
                                          ],
                                        ); // Hiển thị tiến trình chờ
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
                                      } else {
                                        List<Genre> listgenre =genreList;
                                        return Wrap(
                                          spacing: 10,
                                          runSpacing: 10,
                                          children: [
                                            for (var genrename in listgenre)
                                              listGenreCate(genrename,this.context),
                                          ],
                                        );
                                      }
                                    }),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            (selectedIndex==-1)?Column(
                                children:[
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
                                  Row(
                                    children: [
                                      (!translating)?Text(newRelease!, textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,)): Text("Loading"),
                                    ],
                                  ),
                                  slidetrending(lstTrending1, context),
                                ]
                            ):
                            Column(
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height*0.75,
                                  child: FutureBuilder(
                                      future: fetchMoviesByGenre(selectedIndex),
                                      builder: (context,snapshot){
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return Center(child: const CircularProgressIndicator()); // Hiển thị tiến trình chờ
                                        } else if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
                                        } else {
                                          return  ListView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context,index){
                                                return ListMovieByGenre(movieId: snapshot.data![index].movieId,);
                                              });
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        );
      },
    );
  }
  Widget listGenreCate(Genre genre, BuildContext context){
    return Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return InkWell(
            onTap: (){
              if(selectedIndex!=genre.genreId){
                setState(() {
                  selectedIndex = genre.genreId!;
                });
              }
              else{
                setState(() {
                  selectedIndex = -1;
                });
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              width: 120,
              height: 43,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: notifier.isDark ? Colors.black : Colors.redAccent, // Đặt màu nền
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child:
              (!translating)?Text(genre.genreName!, textAlign: TextAlign.center,
                  style: TextStyle(color: notifier.isDark ? Colors.white : Colors.white, overflow: TextOverflow.ellipsis)): Text("Loading"),
            ),
          );
        });
  }
}