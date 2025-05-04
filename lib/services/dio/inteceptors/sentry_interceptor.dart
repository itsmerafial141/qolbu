// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    /// TIDAK KIRIM LOG JIKA STATUS CODE ERROR <= 400
    if ((err.response?.statusCode ?? 0) < 400) return super.onError(err, handler);

    /// KIRIM LOG JIKA STATUS CODE ERROR >= 400
    Sentry.configureScope((scope) {
      scope.setContexts('API', {
        "Method": err.requestOptions.method,
        "Host": err.requestOptions.uri.host,
        "Path": err.requestOptions.uri.path,
        "Header": err.requestOptions.headers,
        "CURL": err.curl,
      });
      scope.setContexts(
        'Request',
        {"Data": err.requestOptions.data},
      );
      scope.setContexts('Response', {
        "Data": err.response?.data ?? "Null",
        "Status Code": err.response?.statusCode,
        "Status Message": err.response?.statusMessage,
      });
      scope.level = SentryLevel.error;

      Sentry.captureMessage(
        '[QOLBU] - ${err.requestOptions.uri.path} (${err.response?.statusCode})',
      );
    });
    super.onError(err, handler);
  }
}

extension ResponseCurlExtension on DioException {
  String? get curl {
    try {
      final qp = requestOptions.queryParameters;
      final Map<String, dynamic> h = requestOptions.headers;
      h.addAll({
        "user-agent": "Dart/3.3 (dart:io)",
        "accept-encoding": "gzip",
        "host": requestOptions.uri.host,
      });
      final d = requestOptions.data;
      final curl =
          // ignore: prefer_interpolation_to_compose_strings
          'curl --location --request ${requestOptions.method} \'${requestOptions.baseUrl}${requestOptions.path}' +
              (qp.isNotEmpty
                  ? qp.keys.fold(
                      '', (value, key) => '$value${value.isEmpty ? '?' : '&'}$key=${qp[key]}\'')
                  : '\'') +
              h.keys.fold(
                  '', (value, key) => '$value \\\n--header \'${key.toLowerCase()}: ${h[key]}\'') +
              ((d != null && d.length != 0) ? ' \\\n--data-raw \'${jsonEncode(d)}\'' : '');
      return curl;
    } catch (e, s) {
      print(e);
      print(s);
    }
    return null;
  }
}
