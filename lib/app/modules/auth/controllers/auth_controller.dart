import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final RxBool isPassVisible = true.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onTapHidePassword() {
    isPassVisible.toggle();
  }

  void onTapLogin() {}

  void onTapLoginWithGoogle() {}

  void onTapLoginWithFacebook() {}

  void onTapRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  
}
