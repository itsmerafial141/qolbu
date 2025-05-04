import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/data/models/auth_model.dart';
import 'package:qolbu/app/data/models/request/login_request.dart';
import 'package:qolbu/app/data/models/response/base_raseponse.dart';
import 'package:qolbu/app/data/models/user_model.dart';
import 'package:qolbu/core/values/consts/end_points_const.dart';
import 'package:qolbu/services/dio/dio_service.dart';

class AuthRepository {
  static bool get isRegistered => Get.isRegistered<AuthRepository>();
  static AuthRepository get find {
    if (isRegistered) return Get.find<AuthRepository>();
    return Get.put(AuthRepository());
  }

  Future<AuthModel> login(LoginRequestModel data) async {
    try {
      var api = DioService.instance.call(baseUrl: 'http://127.0.0.1:3000');
      var response = await api.post(
        EndPoints.login,
        data: data.toJson(),
      );
      var baseResponse = BaseResponse.fromJson(response);
      return AuthModel.fromJson(baseResponse.data);
    } on DioException catch (e) {
      var baseResponse = BaseResponse.fromJson(e.response!);
      return Future.error(baseResponse);
    } catch (e, s) {
      s.printError();
      return Future.error(BaseResponse.error(message: "Terjadi kesalahan"), s);
    }
  }

  Future<UserModel> getUser() async {
    try {
      var api = DioService.instance.call(baseUrl: 'http://127.0.0.1:3000');
      var response = await api.get(EndPoints.user);
      var baseResponse = BaseResponse.fromJson(response);
      return UserModel.fromJson(baseResponse.data);
    } on DioException catch (e) {
      var baseResponse = BaseResponse.fromJson(e.response!);
      return Future.error(baseResponse);
    } catch (e, s) {
      s.printError();
      return Future.error(BaseResponse.error(message: "Terjadi kesalahan"), s);
    }
  }
}
