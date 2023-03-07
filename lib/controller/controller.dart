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
    await fetchItem(1);
    super.onInit();
    scrollController.addListener(scrollListener);
  }

  fetchItem(int start) async {
    try {
      loading(true);
      itemList.clear();
      var response = await Services.fetchItem(start);

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
      }
    } finally {
      loading(false);
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print('Call');
    } else {
      print('Don`t Call');
    }
  }
}
