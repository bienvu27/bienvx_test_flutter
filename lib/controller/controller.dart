import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/category_model.dart';
import 'package:http/http.dart' as http;

import '../service/services.dart';

class Controller extends GetxController {
  final categoryModel = <CategoryModel>[].obs;

  // ===============================================
  final loading = true.obs;
  var itemList = List<CategoryModel>.empty(growable: true).obs;
  int page = 1;
  List posts = [];

  ScrollController scrollController = ScrollController();

  Future<void> fetchCategory() async {
    try {
      loading.value = true;
      final response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/discover/movie?api_key=26763d7bf2e94098192e629eb975dab0&page=1'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final rawData =
            List<Map<String, dynamic>>.from(Map<String, dynamic>.from(
          json.decode(response.body),
        )['results']);
        final listResult = rawData.map(
          (e) => CategoryModel.fromJson(e),
        );
        categoryModel.value = listResult.toList();
        update();
      } else {
        throw Exception('Failed to get data');
      }
    } catch (e) {
      throw e.toString();
    } finally {
      loading.value = false;
    }
  }

  @override
  void onInit() async {
    // await fetchCategory();
    await fetchItem(page);
    super.onInit();
    scrollController.addListener(scrollLister);
  }

  fetchItem(int start) async {
    try {
      loading(true);
      var response = await Services.fetchItem(start);
      print(Services.fetchItem(start));

      if (response.statusCode == 200) {
        final rawData =
            List<Map<String, dynamic>>.from(Map<String, dynamic>.from(
          json.decode(response.body),
        )['results']);
        final listResult = rawData.map(
          (e) => CategoryModel.fromJson(e),
        );
        categoryModel.value = listResult.toList();
        posts = posts + listResult.toList();
        update();
      }
    } finally {
      loading(false);
    }
  }

  Future<void> scrollLister() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      loading.value = true;
      page = page + 1;
      print(page);
      await fetchItem(page);
      loading.value = false;
      update();
      print('Call');
    } else {
      print('Don`t Call');
    }

  }
}
