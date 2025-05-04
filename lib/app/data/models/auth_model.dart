// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'auth_model.g.dart';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class AuthModel {
  @HiveField(0)
  String? token;
  @HiveField(1)
  String? refreshToken;

  AuthModel({
    this.token,
    this.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        token: json["token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refresh_token": refreshToken,
      };
}
