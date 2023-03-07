import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: SingleChildScrollView(
        controller: c.scrollController,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.arrow_back_ios_new_outlined,
                  ),
                  Text(
                    'Back',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Popular list',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<Controller>(
                  init: Controller(),
                  builder: (controller) {
                    if (controller.loading.value) {
                      return const Center(child: Text('Not Data'));
                    } else {
                      return GridView.count(
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        childAspectRatio: (itemWidth / itemHeight),
                        children:
                        List.generate(c.loading.value ? c.categoryModel.length + 1 : c.categoryModel.length, (index) {
                          final releaseDate = c
                              .categoryModel[index].releaseDate
                              ?.substring(0, 4);
                          final voteAverage1 = c
                              .categoryModel[index].voteAverage
                              .toString()[0];
                          final voteAverage2 = num.tryParse(
                              '${c.categoryModel[index].voteAverage}')
                              ?.toDouble();
                          final voteAverageFix = voteAverage2.toString()[2];
                          if(index < c.categoryModel.length){
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 8), // changes position of shadow
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            releaseDate ?? '',
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          SizedBox(
                                            width: Get.size.width / 3,
                                            child: Text(
                                              c.categoryModel[index]
                                                  .originalTitle ??
                                                  '',
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
// age radius
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  voteAverage1,
                                                  style: const TextStyle(
                                                      fontSize: 25),
                                                ),
                                                const Text('.'),
                                                Text(voteAverageFix,
                                                    style: const TextStyle(
                                                        fontSize: 15)),
                                              ],
                                            )),
                                      ))
                                ],
                              ),
                            );
                          }else{
                            return const Center(child: CircularProgressIndicator(),);
                          }


                        }),
                      );
                    }
                  })
            ],
          ),
        )),
      ),
    );
  }
}
