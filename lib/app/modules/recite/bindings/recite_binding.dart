import 'package:get/get.dart';

import '../controllers/recite_controller.dart';

class ReciteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReciteController>(
      () => ReciteController(),
    );
  }
}
