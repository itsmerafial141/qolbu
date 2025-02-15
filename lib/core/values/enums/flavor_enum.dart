// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:qolbu/core/themes/color_swatch.dart';

enum Flavor {
  DEVELOPMENT(
    baseUrl: "https://sikhalen.dlabs.id",
    baseColor: AppColorSwatch.WARNING,
  ),
  STAGING(
    baseUrl: "https://sikhalen.dlabs.id",
    baseColor: AppColorSwatch.SUCCESS,
  ),
  PRODUCTION(
    baseUrl: "http://8.215.61.247:8080",
    baseColor: AppColorSwatch.PRIMARY,
  );

  final String baseUrl;
  final Color baseColor;

  const Flavor({
    required this.baseUrl,
    this.baseColor = Colors.transparent,
  });

  bool get isDevelopment => this == Flavor.DEVELOPMENT;
  bool get isStaging => this == Flavor.STAGING;
  bool get isProduction => this == Flavor.PRODUCTION;
}
