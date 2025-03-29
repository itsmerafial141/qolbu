import 'package:get/get.dart';

import '../controllers/memorize_controller.dart';

class MemorizeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MemorizeController>(
      () => MemorizeController(),
    );
  }
}
