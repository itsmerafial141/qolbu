// import 'package:dio/dio.dart';
// import 'package:qolbu/services/dio/dio_service.dart';

// class HeaderInterceptor extends Interceptor {
//   HeaderInterceptor();

//   @override
//   void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
//     options.headers.addAll(_headers);
//     super.onRequest(options, handler);
//   }

//   Map<String, dynamic> get _headers {
//     if (DioService.instance.api.header == null) {
//       return {
//         'Accept': 'application/json',
//         'Content-Type': request.contentType ?? Headers.jsonContentType,
//         if (request.useToken) ...{
//           // 'Authorization': 'Bearer ${DataService.auth.data?.accessToken ?? "[TOKEN MISSING]"}',
//         },
//       };
//     }
//     return request.header ?? {};
//   }

//   static Map<String, String> get defaultHeader => {
//         'Accept': 'application/json',
//         'Content-Type': Headers.jsonContentType,
//         // 'Authorization': 'Bearer ${DataService.auth.data?.accessToken ?? "[TOKEN MISSING]"}',
//       };
// }
