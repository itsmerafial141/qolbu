// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:qolbu/core/themes/color_swatch.dart';

enum Flavor {
  DEVELOPMENT(
    baseUrl: "https://equran.id/api/v2",
    name: "Devlopment",
    bannerName: "Dev",
    baseColor: AppColorSwatch.WARNING,
  ),
  STAGING(
    baseUrl: "https://equran.id/api/v2",
    name: "Staging",
    bannerName: "Qa",
    baseColor: AppColorSwatch.SUCCESS,
  ),
  PRODUCTION(
    baseUrl: "https://equran.id/api/v2",
    name: "Production",
    bannerName: "",
    baseColor: AppColorSwatch.PRIMARY,
  );

  final String baseUrl;
  final Color baseColor;
  final String bannerName;
  final String name;

  const Flavor({
    required this.baseUrl,
    required this.name,
    required this.bannerName,
    this.baseColor = Colors.transparent,
  });

  bool get isDevelopment => this == Flavor.DEVELOPMENT;
  bool get isStaging => this == Flavor.STAGING;
  bool get isProduction => this == Flavor.PRODUCTION;
}
