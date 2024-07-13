import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import 'comingsoon_widget.dart';

class NewWidget extends StatefulWidget {
  const NewWidget ({super.key});

  @override
  State<NewWidget> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget>{
  @override
  Widget build(BuildContext context) {
    return Consumer<UiProvider>(
        builder: (context,UiProvider notifier, child){
          return DefaultTabController(
              length: 2,
              child: SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      // backgroundColor: Colors.black,
                      title: const Text("News", style: TextStyle(
                        // color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      bottom: TabBar(
                        indicatorPadding: const EdgeInsets.fromLTRB(-10, 0, -10, 0),
                        dividerColor: notifier.isDark ? Colors.black : Colors.black,
                        isScrollable: false,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: notifier.isDark ? Colors.white : Colors.red,
                        ),
                        labelColor: notifier.isDark ? Colors.black : Colors.white,
                        labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        unselectedLabelColor: notifier.isDark ? Colors.white : Colors.black,
                        tabs: const [
                          Tab(
                            text: " 🍿 Coming Soon",
                          ),
                          Tab(
                            text: "🔥 Everyone's Watching",
                          )
                        ],
                      ),
                    ),
                    body: const TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              ComingSoonWidget(
                                imageUrl:
                                'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                                overview:
                                'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
                                logoUrl:
                                "https://s3.amazonaws.com/www-inside-design/uploads/2017/10/strangerthings_feature-983x740.jpg",
                                month: "Jun",
                                day: "19",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ComingSoonWidget(
                                imageUrl:
                                'https://www.pinkvilla.com/images/2022-09/rrr-review.jpg',
                                overview:
                                'A fearless revolutionary and an officer in the British force, who once shared a deep bond, decide to join forces and chart out an inspirational path of freedom against the despotic rulers.',
                                logoUrl:
                                "https://www.careerguide.com/career/wp-content/uploads/2023/10/RRR_full_form-1024x576.jpg",
                                month: "Mar",
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
                                'When a young boy vanishes, a small town uncovers a mystery involving secret experiments, terrifying supernatural forces, and one strange little girl.',
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
}
