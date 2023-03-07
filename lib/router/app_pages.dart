import 'package:get/get.dart';

import '../view/home_binding.dart';
import '../view/home_page.dart';
import 'app_routers.dart';

class AppPages {
  static var list = [
    GetPage(
        name: AppRouters.HOME_PAGE,
        page: () => const HomePage(),
        binding: HomeBinding())
  ];
}
