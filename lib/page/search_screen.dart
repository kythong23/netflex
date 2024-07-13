import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflex/page/flimwidget.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../data/movies.dart';
import '../provider/provider.dart';

class SearchScreen extends StatefulWidget{
  final List<Movies> allfilm;
  const SearchScreen ({super.key,required this.allfilm});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movies> allfilm =[];
  List<Movies> searchResult = [] ;
  @override
  void initState() {
    allfilm = widget.allfilm;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
      builder: (context, UiProvider notifier,child){
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.black,
            elevation: 0.0,
            iconTheme: const IconThemeData(),
            title: const Text("Search for a movie", style: TextStyle(
              fontWeight: FontWeight.bold,
            )
            ),
          ),
          body:
          Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value){
                      setState(() {
                        searchResult = allfilm.where((element) => element.title!.toLowerCase().contains(value)).toList();
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.8),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "The Dark Knight",
                      prefixIcon: const Icon(Icons.search),
                      // prefixIconColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ), Container(
                    // color: Colors.white,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: searchResult.length,
                        itemBuilder: (context,index ){
                          return itemListView(searchResult[index],this.context);
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
