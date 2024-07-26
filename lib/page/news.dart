import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/api_service.dart';
import '../provider/provider.dart';
import 'comingsoon_widget.dart';

class NewWidget extends StatefulWidget {
  const NewWidget ({super.key});

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget>{
  String? appbartitle="";
  late String? _coming;
  late String? _everywatch;
  late String? _overview1;
  late String? _overview2;
  late String? _overview3;
  bool translating = true;
  Future Translate()async{
    appbartitle =await translate("News",context);
    _coming =await translate("Coming Soon",context);
    _everywatch =await translate("Everyone's Watching",context);
    _overview1 =await translate('When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',context);
    _overview2 =await translate('A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',context);
    _overview3 =await translate('When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',context);
    setState((){
      translating = !translating;
    });
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<UiProvider>(
        builder: (context,UiProvider notifier, child){
          return DefaultTabController(
              length: 2,
              child: SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      title:
                      (!translating)?Text(appbartitle!, style: TextStyle(
                        fontWeight: FontWeight.bold,)): Text("Loading"),
                      bottom: TabBar(
                        indicatorPadding: const EdgeInsets.fromLTRB(-10, 0, -10, 0),
                        dividerColor: notifier.isDark ? Colors.black : Colors.black,
                        isScrollable: false,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: notifier.isDark ? Colors.white : Colors.redAccent,
                        ),
                        labelColor: notifier.isDark ? Colors.black : Colors.white,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        unselectedLabelColor: notifier.isDark ? Colors.white : Colors.black,
                        tabs:  [
                          Tab(
                            text:(!translating)? " 🍿 ${_coming}":"Loading",
                          ),
                          Tab(
                            text: (!translating)?"🔥 ${_everywatch}":"Loading",
                          )
                        ],
                      ),
                    ),
                    body:  TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ComingSoonWidget(
                                imageUrl:
                                'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                                overview: (!translating)?_overview1!:"Loading",
                                logoUrl:
                                "https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg",
                                month: "June",
                                day: "19",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ComingSoonWidget(
                                imageUrl:
                                'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                                overview:
                                (!translating)?_overview2!:"Loading",
                                logoUrl:
                                "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
                                month: "March",
                                day: "07",
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ComingSoonWidget(
                                imageUrl:
                                'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                                overview:
                                (!translating)?_overview3!:"Loading",
                                logoUrl:
                                "https://logowik.com/content/uploads/images/stranger-things4286.jpg",
                                month: "Feb",
                                day: "20",
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                ),
              )
          );
        }
    );
  }

  @override
  void initState() {
    Translate();
  }
}
