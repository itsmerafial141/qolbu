// import 'package:dio/dio.dart';
// import 'package:get/get_core/get_core.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/get_utils/src/extensions/dynamic_extensions.dart';
// import 'package:qolbu/app/data/models/auth_model.dart';
// import 'package:qolbu/app/routes/app_pages.dart';
// import 'package:qolbu/core/extensions/response_extension.dart';
// import 'package:qolbu/core/themes/color_swatch.dart';
// import 'package:qolbu/core/utils/helpers.dart';
// import 'package:qolbu/core/values/consts/end_points_const.dart';
// import 'package:qolbu/services/data/data_service.dart';
// import 'package:qolbu/services/flavor_service.dart';
// import 'package:qolbu/services/security_service.dart';

// class RefreshTokenInterceptor extends Interceptor {
//   final Dio dio;

//   RefreshTokenInterceptor({required this.dio});

//   bool _isRefreshing = false;
//   List<(DioException err, ErrorInterceptorHandler handler)> requestRetries = [];

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     if (!(err.response?.isTokenExpired ?? false)) return super.onError(err, handler);
//     if (DataService.auth.data?.refreshToken == null) {
//       await DataService.clear();
//       if (!Get.isSnackbarOpen) {
//         AppHelper.rawSanckBar(
//           backgroundColor: AppColorSwatch.DANGER.shade200,
//           forgorundColor: AppColorSwatch.DANGER,
//           message: "Session anda telah habis. Silahkan masuk kembali!",
//         );
//       }
//       Get.offAllNamed(Routes.LOGIN);
//       return;
//     }

//     if (_isRefreshing) return requestRetries.add((err, handler));

//     _isRefreshing = true;

//     requestRetries.add((err, handler));

//     var status = await _refreshToken(err, handler);

//     if (!status) {
//       await _redirectLogin();
//       return handler.reject(err);
//     }
//     for ((DioException, ErrorInterceptorHandler) requestRetry in requestRetries) {
//       try {
//         handler.resolve(await _retry(requestRetry.$1.requestOptions));
//       } on DioException {
//         handler.reject(err);
//       } catch (_) {
//         handler.reject(err);
//       }
//     }
//     _isRefreshing = false;
//   }

//   Future<bool> _refreshToken(DioException err, ErrorInterceptorHandler handler) async {
//     try {
//       Dio dio = Dio(
//         BaseOptions(
//           baseUrl: "${FlavorServices.flavor.baseUrl}/api",
//           headers: {
//             'Authorization':
//                 "Bearer ${DataService.auth.data?.accessToken ?? "[MISSING REFERSH TOKEN]"}",
//           },
//         ),
//       );
//       var response = await dio.post(
//         EndPoints.refreshToken,
//         data: {
//           "grant_type": "refresh_token",
//           "client_id": SecurityService.clientId,
//           "client_secret": SecurityService.clientSecret,
//           "scope": "*",
//           "refresh_token": DataService.auth.data?.refreshToken,
//         },
//       );
//       if (!response.isSuccess) return false;
//       DataService.auth.data = Auth.fromJson(response.data);
//       return true;
//     } on DioException catch (_) {
//       return false;
//     } catch (_) {
//       return false;
//     }
//   }

//   Future<void> _redirectLogin() async {
//     try {
//       if (!Get.isSnackbarOpen) {
//         AppHelper.rawSanckBar(
//           backgroundColor: AppColorSwatch.DANGER.shade200,
//           forgorundColor: AppColorSwatch.DANGER,
//           message: "Session anda telah habis. Silahkan masuk kembali!",
//         );
//       }
//       Dio dio = Dio(
//         BaseOptions(
//           baseUrl: "${FlavorServices.flavor.baseUrl}/api",
//           headers: {
//             'Authorization':
//                 "Bearer ${DataService.auth.data?.accessToken ?? "[MISSING REFERSH TOKEN]"}",
//           },
//         ),
//       );
//       await dio.post(EndPoints.logout);
//       await DataService.clear();
//       if (Get.currentRoute == Routes.LOGIN) return;
//       Get.offAllNamed(Routes.LOGIN);
//     } on DioException catch (_) {
//       await DataService.clear();
//       if (Get.currentRoute == Routes.LOGIN) return;
//       Get.offAllNamed(Routes.LOGIN);
//     } catch (e, s) {
//       e.printError(info: "REFRESH TOKEN INTERCEPTOR ERROR");
//       s.printError(info: "REFRESH TOKEN INTERCEPTOR STACK TRACE");
//     }
//   }

//   Future<Response> _retry(RequestOptions requestOptions) async {
//     return dio.request(
//       requestOptions.path,
//       cancelToken: requestOptions.cancelToken,
//       data: requestOptions.data,
//       onReceiveProgress: requestOptions.onReceiveProgress,
//       onSendProgress: requestOptions.onSendProgress,
//       queryParameters: requestOptions.queryParameters,
//       options: Options(
//         method: requestOptions.method,
//         sendTimeout: requestOptions.sendTimeout,
//         receiveTimeout: requestOptions.receiveTimeout,
//         extra: requestOptions.extra,
//         headers: requestOptions.headers,
//         preserveHeaderCase: requestOptions.preserveHeaderCase,
//         responseType: requestOptions.responseType,
//         contentType: requestOptions.contentType,
//         validateStatus: requestOptions.validateStatus,
//         receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
//         followRedirects: requestOptions.followRedirects,
//         maxRedirects: requestOptions.maxRedirects,
//         persistentConnection: requestOptions.persistentConnection,
//         requestEncoder: requestOptions.requestEncoder,
//         responseDecoder: requestOptions.responseDecoder,
//         listFormat: requestOptions.listFormat,
//       ),
//     );
//   }
// }
