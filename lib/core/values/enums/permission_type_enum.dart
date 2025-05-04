// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';
import 'package:qolbu/services/flavor_service.dart';

enum PermissionType {
  MEDIA(
    information:
        "Untuk pengalaman terbaik, ijinkan kami mengakses media Anda untuk memberikan layanan terbaik kami sesuai keperluan Anda",
    asset: AppSvg.ilsPermissionMedia,
  ),
  CAMERA(
    information:
        "Untuk pengalaman terbaik, ijinkan kami mengakses kamera Anda untuk memberikan layanan terbaik kami sesuai keperluan Anda",
    asset: AppSvg.ilsPermissionCamera,
  ),
  NOTIFICATION(
    information:
        "Jangan lewatkan informasi terbaru. Aktifkan notifikasi untuk pengalaman aplikasi yang lebih menyeluruh!",
    asset: AppSvg.ilsPermissionNotification,
  ),
  LOCATION(
    information:
        "Untuk pengalaman terbaik, izinkan kami mengakses lokasi Anda untuk menyesuaikan layanan kami dengan keperluan Anda.",
    asset: AppSvg.ilsPermissionLocation,
  );

  final String information;
  final String asset;

  const PermissionType({required this.information, required this.asset});

  Permission get data {
    switch (this) {
      case PermissionType.NOTIFICATION:
        return Permission.notification;
      case PermissionType.MEDIA:
        if (Platform.isAndroid) {
          if (FlavorServices.instance.androidVersion > 32) {
            return Permission.photos;
          } else {
            return Permission.storage;
          }
        } else {
          return Permission.photos;
        }
      case PermissionType.CAMERA:
        return Permission.camera;
      case PermissionType.LOCATION:
        return Permission.location;
    }
  }

  bool get isNotification => this == PermissionType.NOTIFICATION;
  bool get isLocation => this == PermissionType.LOCATION;
  bool get isMedia => this == PermissionType.MEDIA;
  bool get isCamera => this == PermissionType.CAMERA;
}

extension PermissionTypeExtension on String {
  PermissionType get getPermissionType {
    if (this == PermissionType.NOTIFICATION.name) {
      return PermissionType.NOTIFICATION;
    }
    if (this == PermissionType.LOCATION.name) {
      return PermissionType.LOCATION;
    }
    if (this == PermissionType.CAMERA.name) {
      return PermissionType.CAMERA;
    }
    if (this == PermissionType.MEDIA.name) {
      return PermissionType.MEDIA;
    }
    throw "Permission type tidak sesuai";
  }
}
