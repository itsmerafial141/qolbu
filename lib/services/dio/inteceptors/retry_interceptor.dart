import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:qolbu/services/dio/dio_service.dart';
import 'package:qolbu/services/dio/inteceptors/dio_connectivity_request_retrier.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  RetryOnConnectionChangeInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        var requestRetrier = DioConnectivityRequestRetrier(
            dio: DioService.instance.api, connectivity: Connectivity());
        var response = await requestRetrier.scheduleRequestRetry(
          err.requestOptions,
        );
        return handler.resolve(response);
      } catch (e) {
        return super.onError(err, handler);
      }
    }
    return super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError &&
        err.error != null &&
        err.error is SocketException;
  }
}
