import 'package:get/get.dart';

class RetainController extends GetxController {
  static bool get isRegistered => Get.isRegistered<RetainController>();
  static RetainController get find {
    if (isRegistered) return Get.find<RetainController>();
    return Get.put(RetainController());
  }
}
