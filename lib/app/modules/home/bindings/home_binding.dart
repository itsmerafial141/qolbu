import 'package:get/get.dart';
import 'package:qolbu/app/controllers/juz_controller.dart';
import 'package:qolbu/app/controllers/surah_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SurahController>(() => SurahController());
    Get.lazyPut<JuzController>(() => JuzController());
  }
}
