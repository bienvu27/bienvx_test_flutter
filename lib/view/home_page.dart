import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    final double itemWidth = size.width / 2;
    return Scaffold(
      body: SingleChildScrollView(
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
                  builder: (controller){
                    final data = controller.categoryModel;
                    return GridView.count(
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      childAspectRatio: (itemWidth / itemHeight),
                      children: [
                        ...?data.map((e) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 8), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500/${e.posterPath}',
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
                                        '2006',
                                        style: TextStyle(
                                            color: Colors.white10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        e.originalTitle ?? '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800),
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: const [
                                            Text(
                                              '9',
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            Text('.'),
                                            Text('9', style: TextStyle(fontSize: 15)),
                                          ],
                                        )),
                                  ))
                            ],
                          ),
                        ),)

                      ],
                    );
                  })
              

            ],
          ),
        )),
      ),
    );
  }
}
