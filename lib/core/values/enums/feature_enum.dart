// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:qolbu/core/values/consts/svg_asset_const.dart';

enum Feature {
  // ALL(id: "0", name: 'All', icon: AppSvg.icLocationOutlined),
  ABSENCE(
    id: "1",
    name: 'Absen',
    icon: AppSvg.icExit,
    endPoint: "absence",
    backgroundColor: Color(0xFFE2FAF9),
    forgroundColor: Color.fromRGBO(20, 157, 151, 1),
  ),
  OVERTIME(
    id: "2",
    name: 'Lembur',
    icon: AppSvg.icTimeAdd,
    endPoint: "overtime",
    backgroundColor: Color(0xFFFFF3D5),
    forgroundColor: Color.fromRGBO(244, 142, 45, 1),
  ),
  LEAVE(
    id: "3",
    name: 'Cuti',
    icon: AppSvg.icCalendar,
    endPoint: "leave",
    backgroundColor: Color(0xFFF9EEED),
    forgroundColor: Color.fromRGBO(239, 103, 120, 1),
  ),
  BUSINESS(
    id: "4",
    name: 'Dinas',
    icon: AppSvg.icLocationOutlined,
    endPoint: "business",
    backgroundColor: Color(0xFFEAF3FF),
    forgroundColor: Color.fromRGBO(20, 157, 151, 1),
  );

  final String id;
  final String name;
  final String icon;
  final String endPoint;
  final Color backgroundColor;
  final Color forgroundColor;

  const Feature({
    required this.id,
    required this.name,
    required this.icon,
    required this.endPoint,
    required this.backgroundColor,
    required this.forgroundColor,
  });

  bool get isAbsence => this == Feature.ABSENCE;
  bool get isOvertime => this == Feature.OVERTIME;
  bool get isLeave => this == Feature.LEAVE;
  bool get isBusiness => this == Feature.BUSINESS;
  // bool get isAll => this == Feature.ALL;
}
