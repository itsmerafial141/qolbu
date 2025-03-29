import 'package:get/get.dart';

import '../controllers/retain_controller.dart';

class RetainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RetainController>(
      () => RetainController(),
    );
  }
}
