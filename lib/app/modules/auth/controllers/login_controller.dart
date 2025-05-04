import 'dart:async';

import 'package:get/get.dart';
import 'package:qolbu/app/controllers/user_controller.dart';
import 'package:qolbu/app/data/models/auth_model.dart';
import 'package:qolbu/app/data/models/request/login_request.dart';
import 'package:qolbu/app/data/models/response/base_raseponse.dart';
import 'package:qolbu/app/data/repository/auth_repository.dart';
import 'package:qolbu/app/modules/auth/controllers/auth_controller.dart';
import 'package:qolbu/app/routes/app_pages.dart';
import 'package:qolbu/services/data/data_service.dart';
import 'package:qolbu/services/dialog_service.dart';

class LoginController extends AuthController {
  @override
  void onTapLogin() async {
    DialogService.instance.showLoading();
    var data = LoginRequestModel(
      email: emailController.text,
      password: passwordController.text,
    );
    var response = AuthRepository.find.login(data);
    await response.then(_onLoginSuccess).onError((BaseResponse error, stackTrace) {
      DialogService.instance.closeLoading();
      DialogService.instance.showProblem(
        message: error.message,
        errorText: error.curl,
      );
    });
  }

  FutureOr _onLoginSuccess(AuthModel value) async {
    DataService.auth.data = value;
    UserController.find.initializeApi().then((value) {
      DialogService.instance.closeLoading();
      Get.until((route) => route.settings.name == Routes.NAVIGATION || route.isFirst);
    }).onError((BaseResponse error, stackTrace) {
      DialogService.instance.closeLoading();
      DialogService.instance.showProblem(message: error.message, errorText: error.curl);
    });
  }
}
