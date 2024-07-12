import 'package:flutter/material.dart';
import 'package:netflex/config/api_service.dart';
import 'package:netflex/data/data.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/search_screen.dart';
import 'package:netflex/provider/provider.dart';
import 'package:provider/provider.dart';
import 'flimwidget.dart';

class DefautlWidget extends StatefulWidget {
  const DefautlWidget({super.key});
  @override
  State<DefautlWidget> createState() => _DefautlWidgetState();
}


class _DefautlWidgetState extends State<DefautlWidget> {
  List<Movies> getfilm = [];
  List<Movies> lsttrending = [];

  @override
  void initState() {
    super.initState();
    lsttrending = getFlim(3);
    Future<List<Movies>> getallflim()async{
      Future<List<Movies>> futureMovies = fetchMovies();
      getfilm = await futureMovies;
      return getfilm;
    }
    getallflim();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UiProvider>(
        builder: (context,UiProvider notifier, child){
          return Center(
              child:
              SingleChildScrollView(
                child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget> [
                      Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/logo.jpg",
                            width: 100,
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            "TV Shows",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            "Movies",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 25),
                          const Text(
                            "My List",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(Icons.search),
                            color: Colors.white,
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SearchScreen(allfilm: getfilm,)),
                              );
                            },
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                      slideposter(context),
                      const Row(
                        children: [
                          Text("Trending Movies",
                            style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,),
                          )
                        ],
                      ),
                      slidetrending(lsttrending,context),
                    ]),
              )
          );
        },
      )
    );
  }
}
