// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:qolbu/core/themes/color_swatch.dart';

enum Status {
  AWAIT(
    id: "await",
    name: "Pending",
    forgroundColor: AppColorSwatch.WARNING,
    backgroundColor: Color.fromRGBO(253, 237, 229, 1),
  ),
  DECLINED(
    id: "declined",
    name: "Declined",
    forgroundColor: AppColorSwatch.DANGER,
    backgroundColor: Color.fromRGBO(239, 205, 209, 1),
  ),
  APPROVED(
    id: "approved",
    name: "Approved",
    forgroundColor: AppColorSwatch.SUCCESS,
    backgroundColor: Color.fromRGBO(231, 242, 233, 1),
  );

  final String id;
  final String name;
  final Color forgroundColor;
  final Color backgroundColor;

  const Status({
    required this.id,
    required this.name,
    required this.forgroundColor,
    required this.backgroundColor,
  });

  bool get isPending => this == Status.AWAIT;
  bool get isDeclined => this == Status.DECLINED;
  bool get isApproved => this == Status.APPROVED;
}
