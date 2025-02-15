// ignore_for_file: constant_identifier_names, unused_field, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:qolbu/core/themes/color_swatch.dart';

class AppColor {
  static _Foundations foundations = _Foundations();
  static _Background background = _Background();
  static _Button button = _Button();
  static _TextField textField = _TextField();

  static const Color SECONDARY = AppColorSwatch.SECONDARY;
  static const Color WHITE = Color.fromARGB(255, 247, 247, 247);
  static const Color INPUT_FILL_COLOR = Colors.white;
  static const Color INPUT_DISABLE_COLOR = Color(0xffC4C4C4);
  static const Color DISABLE = Color(0xFFC8CBCE);

  static const Color Olivine = Color(0xffADC178);
  static const Color Ecru = Color(0xffC1B078);
  static const Color AntiqueBrass = Color(0xffC18C78);
  static const Color Ube = Color(0xff8C78C1);
  static const Color ShipCove = Color(0xff7889C1);
  static const Color ShipCoveLight = Color(0xffE8ECF7);
  static const Color Glacier = Color(0xff78ADC1);
}

class _Foundations {
  Color PRIMARY_A = AppColorSwatch.PRIMARY;
  Color NETRAL = AppColorSwatch.NETRAL;
  Color SUCCESS = AppColorSwatch.SUCCESS;
  Color WARNING = AppColorSwatch.WARNING;
  Color FAILED = AppColorSwatch.ERROR;
  Color DISABLE = const Color(0xFFBCBCBC);
}

class _Background {
  Color PRIMARY = Colors.white;
  Color SECONDARY = const Color(0xFFf5f6f8);
  Color DISABLE = const Color(0xFFF1F5F9);
}

class _Button {
  Color disableBackground = const Color(0xFFF1F5F9);
  Color disablePrimaryTextColor = const Color(0xFFCBD5E1);
  Color primaryTextColor = const Color(0xFFFFFFFF);
  Color splashBackgroundColor = const Color(0xFF73B5B1);
  Color backgroundColor = const Color(0xFF149D97);
}

class _TextField {
  Color focusedBorderStandard = AppColorSwatch.PRIMARY;
  Color errorBorderStandard = AppColorSwatch.DANGER;
  Color borderStandard = const Color(0xFFE2E8F0);
  Color textColor = const Color(0xFF64748B);
  Color textInput = const Color(0xFF020617);
}
