import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qolbu/core/values/enums/method_enum.dart';
import 'package:qolbu/services/dio/inteceptors/refresh_token_inteceptor.dart';
import 'package:qolbu/services/dio/inteceptors/retry_interceptor.dart';
import 'package:qolbu/services/dio/inteceptors/sentry_interceptor.dart';
import 'package:qolbu/services/dio/inteceptors/token_interceptor.dart';
import 'package:qolbu/services/flavor_service.dart';

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
  DioService._();

  static bool get isRegistered => Get.isRegistered<DioService>();
  static DioService get find {
    if (isRegistered) return Get.find<DioService>();
    return Get.put<DioService>(DioService._());
  }

  static DioService get instance => find;

  late final Dio _dio;
  late final CookieJar cookieJar;
  Dio get api => instance._dio;

  static Future<void> initialize({
    String? customBaseUrl,
    String? contentType = Headers.jsonContentType,
  }) async {
    Get.put(DioService._(), permanent: true);
    instance._dio = Dio(
      BaseOptions(
        baseUrl: customBaseUrl ?? FlavorServices.instance.flavor.baseUrl,
        contentType: contentType ?? Headers.formUrlEncodedContentType,
        connectTimeout: Duration(milliseconds: 30000),
        receiveTimeout: Duration(milliseconds: 30000),
      ),
    );
    final appDocDir = await getApplicationDocumentsDirectory();
    instance.cookieJar = PersistCookieJar(
      storage: FileStorage('${appDocDir.path}/.cookies/'),
    );

    instance._dio.interceptors.add(CookieManager(instance.cookieJar));
    instance._dio.interceptors.add(RefreshTokenInterceptor());
    instance._dio.interceptors.add(TokenInterceptor());
    instance._dio.interceptors.add(RetryOnConnectionChangeInterceptor());
    instance._dio.interceptors.add(SentryInterceptor());
  }

  Dio call({
    String? baseUrl,
    bool useToken = false,
  }) {
    try {
      instance._dio.options.baseUrl = baseUrl ?? FlavorServices.instance.flavor.baseUrl;
      if (!useToken) instance._dio.options.headers.remove("Authorization");
      return _dio;
    } on DioException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }
}
