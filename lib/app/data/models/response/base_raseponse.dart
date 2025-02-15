// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:qolbu/core/extensions/response_extension.dart';
import 'package:qolbu/services/flavor_service.dart';

BaseResponse baseResponseFromJson(String str) => BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse<T> {
  bool? success;
  String? message;
  int? statusCode;
  T? data;
  RequestOptions? requestOptions;
  Response? response;

  BaseResponse({
    this.success,
    this.message,
    this.statusCode,
    this.requestOptions,
    this.response,
    required this.data,
  });

  static BaseResponse get badRequest => BaseResponse(
        data: null,
        success: false,
        statusCode: HttpStatus.badRequest,
        message: "Something Went Wrong",
      );
  static BaseResponse get notFound => BaseResponse(
        data: null,
        success: false,
        statusCode: HttpStatus.notFound,
        message: "Not Found",
      );

  factory BaseResponse.error({
    bool success = false,
    String? message,
    int statusCode = 400,
  }) {
    return BaseResponse(
      success: success,
      message: message,
      statusCode: statusCode,
      data: null,
    );
  }

  factory BaseResponse.fromJson(Response? response) {
    var isSuccess = (response?.data is Map)
        ? (response?.data["correct"] ?? response?.data["success"]) ?? response?.isSuccess
        : response?.isSuccess;
    return BaseResponse(
      success: isSuccess,
      requestOptions: response?.requestOptions,
      response: response,
      message: (response?.data is Map)
          ? response?.data["message"] ??
              ((response?.data["detail"] is Map)
                  ? response?.data["detail"] ?? FlavorServices.flavor.isProduction
                      ? "Terjadi Kesalahan"
                      : response?.statusMessage
                  : FlavorServices.flavor.isProduction
                      ? "Terjadi Kesalahan"
                      : response?.statusMessage)
          : isSuccess
              ? (response?.data is Map)
                  ? response?.data["message"]
                  : response?.statusMessage
              : (response?.data is Map)
                  ? response?.data["message"] ?? "Terjadi Kesalahan"
                  : "Internal server error",
      data: (response?.data is Map) ? response?.data["data"] ?? response?.data : response?.data,
      statusCode: response?.statusCode,
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}

extension BaseResponseExtension on BaseResponse {
  String get curl {
    try {
      if (requestOptions == null) return "-";
      final qp = requestOptions!.queryParameters;
      final Map<String, dynamic> h = requestOptions!.headers;
      h.addAll({
        "user-agent": "Dart/3.3 (dart:io)",
        "accept-encoding": "gzip",
        "host": requestOptions!.uri.host,
      });
      final d = requestOptions?.data;
      final curl =
          // ignore: prefer_interpolation_to_compose_strings
          'curl --location --request ${requestOptions!.method} \'${requestOptions!.baseUrl}${requestOptions!.path}' +
              (qp.isNotEmpty
                  ? qp.keys.fold(
                      '', (value, key) => '$value${value.isEmpty ? '?' : '&'}$key=${qp[key]}\'')
                  : '\'') +
              h.keys.fold(
                  '', (value, key) => '$value \\\n--header \'${key.toLowerCase()}: ${h[key]}\'') +
              ((d != null && d.length != 0) ? ' \\\n--data-raw \'${jsonEncode(d)}\'' : '') +
              '\n\n' +
              " Response Data: $response";
      return curl;
    } catch (e, s) {
      s.printError();
      return e.toString();
    }
  }
}
