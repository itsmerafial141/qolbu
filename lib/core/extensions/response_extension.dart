import 'dart:io';

import 'package:dio/dio.dart';
import 'package:qolbu/app/data/models/response/base_raseponse.dart';

extension ResponseExtension on Response {
  bool get isTokenExpired => statusCode == HttpStatus.unauthorized;

  bool get isSuccess => statusCode == HttpStatus.ok;

  bool get isNotFound => statusCode == HttpStatus.notFound;

  bool get isBadRequest => statusCode == HttpStatus.badRequest;

  bool get isInternalServerError => statusCode == HttpStatus.internalServerError;
}

extension BaseResponseExtension on BaseResponse {
  bool get isTokenExpired => statusCode == HttpStatus.unauthorized;

  bool get isSuccess => statusCode == HttpStatus.ok;

  bool get isNotFound => statusCode == HttpStatus.notFound;

  bool get isBadRequest => statusCode == HttpStatus.badRequest;

  bool get isInternalServerError => statusCode == HttpStatus.internalServerError;
}
