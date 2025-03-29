import 'package:get/get.dart';

class SaveController extends GetxController {
  static bool get isRegistered => Get.isRegistered<SaveController>();
  static SaveController get find {
    if (isRegistered) return Get.find<SaveController>();
    return Get.put(SaveController());
  }
}
