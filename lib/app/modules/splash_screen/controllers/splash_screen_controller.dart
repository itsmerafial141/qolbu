import 'package:get/get.dart';
import 'package:qolbu/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  static bool get isRegistered => Get.isRegistered<SplashScreenController>();
  static SplashScreenController get find {
    if (isRegistered) return Get.find<SplashScreenController>();
    return Get.put(SplashScreenController());
  }

  void onTapMulai() {
    Get.toNamed(Routes.NAVIGATION);
  }
}
