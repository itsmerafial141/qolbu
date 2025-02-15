import 'package:get/get.dart';

class UserController extends GetxController with StateMixin {
  static bool get isRegistered => Get.isRegistered<UserController>();
  static UserController get find {
    return isRegistered ? Get.find<UserController>() : Get.put(UserController());
  }
}
