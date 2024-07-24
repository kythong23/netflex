import 'package:flutter/material.dart';
import 'package:netflex/data/movies.dart';
import 'package:netflex/page/flimwidget.dart';
import 'package:netflex/provider/provider.dart';
import 'package:provider/provider.dart';

import '../config/api_service.dart';

class FavorWidget extends StatefulWidget {
  const FavorWidget({super.key});

  @override
  State<FavorWidget> createState() => _FavorWidgetState();
}

class _FavorWidgetState extends State<FavorWidget> {
  late Future<String?> title;
  late Future<String?> desc;
  String? appbar = "";
  bool translating = true;
  bool update = true;
  List<Movies> movies=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (!translating)?Text(appbar!, style: TextStyle(fontWeight: FontWeight.bold)): Text("Loading"),
        actions: [
          Consumer<FavorProvider>(
              builder: (context,value,child){
                return (value.selectedList.isNotEmpty)?InkWell(
                  onTap: (){
                    value.delRemove();
                    value.delInTime();
                    value.delAPI();
                    setState(() {
                      update=!update;
                    });
                  },
                  child: Row(
                    children: [
                      Text("Remove",style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(width: 10,),
                      Consumer<FavorProvider>(
                          builder: (context,value,child){
                            return Text('(${value.selectedList.length.toString()})');
                          }),
                      SizedBox(width: 40,)
                    ],
                  ),
                ):Container();
              }),
        ],
      ),
      body: FutureBuilder(
          future: transFavor(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);// Hiển thị tiến trình chờ
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}'); // Hiển thị thông báo lỗi nếu có lỗi
            } else {
              return Consumer<FavorProvider>(
                  builder: (context,value,child){
                    return ListView.builder(
                        itemCount: value.favorList.length,
                        itemBuilder: (context,index){
                          return ListFavor(m: value.moviesByIdList[index],value: value,index: index,favorMovies: value.favorList[index],);
                        });
                  });
            }
          })
    );
  }

  Future addMovie(Movies e,List<Movies> list,Future<String?> t,Future<String?> d)async{
    list.add(Movies(
        id: e.id,
        episode: e.episode,
        trailer: e.trailer,
        img: e.img,
        title:await t,
        description:await d));
  }
  Future transFavor()async{
    movies= Provider.of<FavorProvider>(context,listen: false).moviesByIdList;
    List<Movies>afterTrans=[];
      for(int i = 0;i<movies.length; i++){
       Movies e = movies[i];
       desc = translate(e.description!,context);
       title = translate(e.title!,context);
       await addMovie(e,afterTrans,title,desc);
    }
    Provider.of<FavorProvider>(context,listen: false).moviesByIdList=afterTrans;
  }
  Future transAppbar()async{
    appbar = await translate("My list", context);
    setState(() {
      translating=!translating;
    });
  }
  @override
  void initState() {
    super.initState();
    transAppbar();
    transFavor();
  }
}
