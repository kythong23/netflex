import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:timezone/data/latest.dart' as tz;

import '../config/api_service.dart';
import '../services/notifi_service.dart';

class ComingSoonWidget extends StatefulWidget {
  final String imageUrl;
  final String overview;
  final String logoUrl;
  final String month;
  final String day;

  const ComingSoonWidget({super.key,
    required this.imageUrl,
    required this.overview,
    required this.logoUrl,
    required this.month,
    required this.day
  });

  @override
  State<ComingSoonWidget> createState() => _ComingSoonWidgetState();
}

class _ComingSoonWidgetState extends State<ComingSoonWidget> {
  String? appbartitle="";
  late String? _comingOn;
  late String? _remind;
  late String? _info;
  late String? _month;
  bool translating = true;
  Future Translate()async{
    _remind =await translate("Remind me",context);
    _info =await translate("Info",context);
    _comingOn =await translate("Coming on",context);
    _month =await translate(widget.month,context);
    setState((){
      translating = !translating;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();
    NotificationService().initNotification();
    tz.initializeTimeZones();
    Translate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //The value of local varial
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 10,),
              Text(
                widget.month,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                widget.day,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white,
                  letterSpacing: 5,
                ),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(child: Column(
            children: [
              CachedNetworkImage(imageUrl: widget.imageUrl),
              Row(
                children: [
                  SizedBox(
                    width: size.width*0.5,
                    height: size.height*0.2,
                    child: CachedNetworkImage(
                      imageUrl: widget.logoUrl,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {NotificationService().showNotification(
                            title: 'Neflex',
                            body: 'Phim hiện đã ra mắt, mới bạn vào xem',
                          );}
                          , icon: Icon(
                        Icons.info_outline_rounded,
                        size: 25,
                        color: Colors.white,
                      )),
                      Text(
                        (!translating)?_remind!:"Loading",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                   Column(
                    children: [
                      IconButton(onPressed: (){},
                          icon: Icon(
                            Icons.notifications_none_rounded,
                            size: 25,
                            color: Colors.white,
                          ),),
                      Text(
                        (!translating)?_info!:"Loading",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (!translating)?Text(
                    "$_comingOn $_month ${widget.day}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ):Text("Loading"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.overview,
                    maxLines: 4,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}