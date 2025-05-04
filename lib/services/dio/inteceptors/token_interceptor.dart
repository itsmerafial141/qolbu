import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:qolbu/services/data/data_service.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      if (DataService.auth.data?.token?.isEmpty ?? true) {
        super.onRequest(options, handler);
        return;
      }
      options.headers.addAll({"Authorization": "Bearer ${DataService.auth.data?.token ?? ""}"});
      super.onRequest(options, handler);
    } catch (e, s) {
      e.printError();
      s.printError();
    }
  }
}
