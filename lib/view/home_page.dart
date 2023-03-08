import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controller.dart';
import 'components/card_view.dart';

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
              padding: const EdgeInsets.all(10),
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
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: GridView.count(
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              childAspectRatio: (itemWidth / itemHeight),
                              children: List.generate(
                                  c.loading.value
                                      ? c.categoryModel.length + 1
                                      : c.categoryModel.length, (index) {
                                final releaseDate = c.categoryModel[index].releaseDate
                                    ?.substring(0, 4);
                                final voteAverage1 =
                                    c.categoryModel[index].voteAverage.toString()[0];
                                final voteAverage2 = num.tryParse(
                                        '${c.categoryModel[index].voteAverage}')
                                    ?.toDouble();
                                final voteAverageFix = voteAverage2.toString()[2];
                                if (index < c.categoryModel.length) {
                                  return CardItem(
                                    c: c,
                                    releaseDate: releaseDate,
                                    voteAverage1: voteAverage1,
                                    voteAverageFix: voteAverageFix,
                                    index: index,
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                            ),
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

