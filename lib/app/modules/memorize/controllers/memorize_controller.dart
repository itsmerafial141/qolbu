import 'package:get/get.dart';

class MemorizeController extends GetxController {
  static bool get isRegistered => Get.isRegistered<MemorizeController>();
  static MemorizeController get find {
    if (isRegistered) return Get.find<MemorizeController>();
    return Get.put(MemorizeController());
  }
}
