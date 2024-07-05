import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ComingSoonWidget extends StatelessWidget{
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
                month,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                ),
              ),
              Text(
                day,
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
              CachedNetworkImage(imageUrl: imageUrl),
              Row(
                children: [
                  SizedBox(
                    width: size.width*0.5,
                    height: size.height*0.2,
                    child: CachedNetworkImage(
                      imageUrl: logoUrl,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  const Column(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                      Text(
                       "Remind me",
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
                  const Column(
                    children: [
                      Icon(
                        Icons.notifications_none_rounded,
                        size: 25,
                        color: Colors.white,
                      ),
                      Text(
                        "Info",
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
                  Text(
                    "Coming on $month $day",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    overview,
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