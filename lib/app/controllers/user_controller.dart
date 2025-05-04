import 'package:get/get.dart';
import 'package:qolbu/app/data/models/response/base_raseponse.dart';
import 'package:qolbu/app/data/models/user_model.dart';
import 'package:qolbu/app/data/repository/auth_repository.dart';
import 'package:qolbu/services/data/data_service.dart';

class UserController extends GetxController with StateMixin<UserModel> {
  static bool get isRegistered => Get.isRegistered<UserController>();
  static UserController get find {
    return isRegistered ? Get.find<UserController>() : Get.put(UserController(), permanent: true);
  }

  Future<UserModel?> initializeApi() async {
    change(null, status: RxStatus.loading());
    if (DataService.auth.data?.token?.isEmpty ?? true) {
      change(null, status: RxStatus.empty());
      return null;
    }
    var response = AuthRepository.find.getUser();
    return response.then((value) {
      DataService.user.data = value;
      change(value, status: RxStatus.success());
      return value;
    }).onError((BaseResponse error, stackTrace) {
      change(value, status: RxStatus.error(error.message));
      return Future.error(error);
    });
  }
}
