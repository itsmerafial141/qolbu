// ignore_for_file: unused_field, unused_element, library_private_types_in_public_api

import 'package:qolbu/core/values/enums/feature_enum.dart';

class EndPoints {
  static const String login = "/auth/login";
  static const String logout = "/auth/logout";
  static const String refreshToken = "/auth/refresh";
  static const String user = "/user";
  static const String changePassword = "/me/update";
  static const String homepage = "/homepage";
  static const String calendar = "/calendar";
  static const String onboarding = "/onboarding";

  static String recaptulation(Feature feature) => "/recapitulation/${feature.endPoint}";

  static _Absence absence = _Absence();
  static _Overtime overtime = _Overtime();
  static _Notification notification = _Notification();
  static _Leaves leaves = _Leaves();
  static _Business business = _Business();
}

class _Absence {
  String absence(String id) => "/absence/regular/checkin/$id";
  final String regularAbsences = "/absence/regular/checkin";
  final String checkIn = "/absence/regular/checkin";
  final String checkOut = "/absence/regular/checkout";
}

class _Overtime {
  String absence(String id) => "/absence/regular/checkin/$id";
  final String checkIn = "/absence/overtime/checkin";
  final String checkOut = "/absence/overtime/checkout";
}

class _Notification {
  final String notification = "/notification";
  final String announcement = "/announcement";
}

class _Leaves {
  final String dashboard = "/absence/leave/activity";
  final String category = "/absence/leave/available";
  final String balance = "/absence/leave/available";
  final String leaves = "/absence/leave/user";
  String leave(String id) => "/absence/leave/user/$id";
}

class _Business {
  final String business = "/absence/business";
}
