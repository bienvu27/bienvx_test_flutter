import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controller.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.c,
    required this.releaseDate,
    required this.voteAverage1,
    required this.voteAverageFix, required this.index,
  });

  final Controller c;
  final String? releaseDate;
  final String voteAverage1;
  final String voteAverageFix;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${c.categoryModel[index].posterPath}',
                height: 500,
                width: 200,
                fit: BoxFit.cover,
              )),
          Positioned(
              left: 5,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    releaseDate ?? '',
                    style: const TextStyle(
                        color: Colors.white70, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: Get.size.width / 3,
                    child: Text(
                      c.categoryModel[index].originalTitle ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              )),
          Positioned(
              right: 10,
              top: 10,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Color(0xfff2831b),
                      Color(0xfff2831b),
                      Color(0xffe16b5c),
                      Color(0xffca485c),
                    ],
                  ),
                ),
                child: CircleAvatar(
                    radius: 20, // Im
                    backgroundColor: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          voteAverage1,
                          style: const TextStyle(fontSize: 25),
                        ),
                        const Text('.'),
                        Text(voteAverageFix,
                            style: const TextStyle(fontSize: 15)),
                      ],
                    )),
              ))
        ],
      ),
    );
  }
}
