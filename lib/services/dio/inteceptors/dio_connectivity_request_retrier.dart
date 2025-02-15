import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class DioConnectivityRequestRetrier {
  final Dio dio;
  final Connectivity connectivity;

  DioConnectivityRequestRetrier({
    required this.dio,
    required this.connectivity,
  });

  Future<Response> scheduleRequestRetry(RequestOptions requestOptions) async {
    late StreamSubscription streamSubscription;
    final responseCompleter = Completer<Response>();

    streamSubscription = connectivity.onConnectivityChanged.listen(
      (connectivityResult) async {
        if (!connectivityResult.contains(ConnectivityResult.none)) {
          streamSubscription.cancel();
          responseCompleter.complete(
            dio.request(
              requestOptions.path,
              cancelToken: requestOptions.cancelToken,
              data: requestOptions.data,
              onReceiveProgress: requestOptions.onReceiveProgress,
              onSendProgress: requestOptions.onSendProgress,
              queryParameters: requestOptions.queryParameters,
              options: Options(
                method: requestOptions.method,
                sendTimeout: dio.options.sendTimeout,
                receiveTimeout: dio.options.receiveTimeout,
                extra: dio.options.extra,
                headers: dio.options.headers,
                preserveHeaderCase: dio.options.preserveHeaderCase,
                responseType: dio.options.responseType,
                contentType: dio.options.contentType,
                validateStatus: dio.options.validateStatus,
                receiveDataWhenStatusError: dio.options.receiveDataWhenStatusError,
                followRedirects: dio.options.followRedirects,
                maxRedirects: dio.options.maxRedirects,
                persistentConnection: dio.options.persistentConnection,
                requestEncoder: dio.options.requestEncoder,
                responseDecoder: dio.options.responseDecoder,
                listFormat: dio.options.listFormat,
              ),
            ),
          );
        }
      },
    );

    return responseCompleter.future;
  }
}
