import 'package:dio/dio.dart';
import 'package:qolbu/core/values/enums/method_enum.dart';
import 'package:qolbu/services/dio/inteceptors/dio_inteceptor.dart';
import 'package:qolbu/services/dio/inteceptors/retry_interceptor.dart';
import 'package:qolbu/services/flavor_service.dart';

class InterceptorOption {
  final bool useHeader;
  final bool useRefreshToken;
  final bool useRetry;

  const InterceptorOption({
    this.useHeader = true,
    this.useRefreshToken = true,
    this.useRetry = true,
  });
}

class DioRequest {
  final String url;
  final Method method;
  final Map<String, dynamic>? request;
  final Map<String, String>? header;
  final String? contentType;
  final bool useFormData;
  final bool useToken;
  final int connectTimeout;

  const DioRequest(
    this.url, {
    this.method = Method.POST,
    this.request,
    this.header,
    this.contentType,
    this.useFormData = false,
    this.useToken = true,
    this.connectTimeout = 30000,
  });
}

class DioService {
  static String get baseUrl => FlavorServices.flavor.baseUrl;

  static late DioRequest _request;

  static Future<Response> call(
    String url, {
    String? customBaseUrl,
    Method method = Method.POST,
    Map<String, dynamic>? request,
    Map<String, String>? header,
    Map<String, dynamic>? queryParameters,
    bool useFormData = false,
    bool useToken = true,
    int connectTimeout = 30000,
    String? contentType = Headers.jsonContentType,
    InterceptorOption? interceptorOption,
  }) {
    try {
      _request = DioRequest(
        url,
        header: header,
        method: method,
        request: request,
        useFormData: useFormData,
        useToken: useToken,
        connectTimeout: connectTimeout,
        contentType: contentType,
      );

      final dio = Dio(
        BaseOptions(
          baseUrl: "${customBaseUrl ?? baseUrl}/api",
          contentType: contentType ?? Headers.formUrlEncodedContentType,
          connectTimeout: Duration(milliseconds: connectTimeout),
          receiveTimeout: Duration(milliseconds: connectTimeout),
        ),
      );
      var iOption = interceptorOption ?? const InterceptorOption();
      if (iOption.useHeader) dio.interceptors.add(HeaderInterceptor(request: _request));
      // if (iOption.useRefreshToken) dio.interceptors.add(RefreshTokenInterceptor(dio: dio));
      if (iOption.useRetry) dio.interceptors.add(RetryOnConnectionChangeInterceptor(dio: dio));

      switch (method) {
        case Method.GET:
          return dio.get(url, data: request, queryParameters: queryParameters);
        case Method.PUT:
          return dio.put(url, data: request);
        case Method.DELETE:
          return dio.delete(url, data: request);
        default:
          return dio.post(url, data: request);
      }
    } on DioException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
