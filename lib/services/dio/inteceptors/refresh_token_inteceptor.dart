import 'package:dio/dio.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:qolbu/app/routes/app_pages.dart';
import 'package:qolbu/core/extensions/response_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/utils/helpers.dart';
import 'package:qolbu/core/values/consts/end_points_const.dart';
import 'package:qolbu/services/data/data_service.dart';
import 'package:qolbu/services/dio/dio_service.dart';

class RefreshTokenInterceptor extends Interceptor {
  bool _isRefreshing = false;
  final List<(DioException err, ErrorInterceptorHandler handler)> _retryQueue = [];

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (!(err.response?.isTokenExpired ?? false) || err.requestOptions.path.contains("refresh")) {
      return super.onError(err, handler);
    }

    _retryQueue.add((err, handler));

    if (_isRefreshing) return;

    _isRefreshing = true;
    bool success = await _refreshToken();

    final queue = List.of(_retryQueue); // clone
    _retryQueue.clear();
    _isRefreshing = false;

    if (!success) {
      await _redirectLogin();
      for (final r in queue) {
        r.$2.reject(r.$1); // reject semua yang antri
      }
      return;
    }

    for (final r in queue) {
      try {
        final retryResponse = await _retry(r.$1.requestOptions);
        r.$2.resolve(retryResponse);
      } catch (e) {
        r.$2.reject(r.$1);
      }
    }
  }

  Future<bool> _refreshToken() async {
    try {
      var api = DioService.instance.call(baseUrl: "http://127.0.0.1:3000");
      var response = await api.post(EndPoints.refreshToken);
      if (!response.isSuccess) return false;

      // Update access token (this is assumed logic)
      DataService.auth.data?.token = response.data['data']['token'];
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> _redirectLogin() async {
    if (!Get.isSnackbarOpen) {
      AppHelper.rawSanckBar(
        backgroundColor: AppColorSwatch.DANGER.shade200,
        forgorundColor: AppColorSwatch.DANGER,
        message: "Session anda telah habis. Silahkan masuk kembali!",
      );
    }

    try {
      var api = DioService.instance.call(baseUrl: "http://127.0.0.1:3000");
      await api.post(EndPoints.logout);
    } catch (_) {}

    await DataService.clear();
    if (Get.currentRoute != Routes.LOGIN) {
      Get.toNamed(Routes.LOGIN);
    }
  }

  Future<Response> _retry(RequestOptions requestOptions) async {
    return DioService.instance.api.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );
  }
}
