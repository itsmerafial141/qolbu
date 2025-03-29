import 'package:get/get.dart';

class ReciteController extends GetxController {
  static bool get isRegistered => Get.isRegistered<ReciteController>();
  static ReciteController get find {
    if (isRegistered) return Get.find<ReciteController>();
    return Get.put(ReciteController());
  }
}
