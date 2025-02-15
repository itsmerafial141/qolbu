import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/my_app.dart';

class AppHelper {
  AppHelper._();
  static void getBack() {
    Get.closeAllSnackbars();
    if (Get.isDialogOpen!) Get.back();
    Get.back();
  }

  static Size textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  static SystemUiOverlayStyle get systemUiOverlayStyle => SystemUiOverlayStyle(
        statusBarColor: themeManager.isThemeModeDark ? Colors.black : Colors.transparent,
        systemNavigationBarColor: themeManager.isThemeModeDark ? Colors.black : Colors.white,
        statusBarIconBrightness: themeManager.isThemeModeDark ? Brightness.light : Brightness.dark,
        systemNavigationBarIconBrightness:
            themeManager.isThemeModeDark ? Brightness.light : Brightness.dark,
      );
  static SnackbarController rawSanckBar({
    required Color backgroundColor,
    Color? forgorundColor,
    required String message,
    TextStyle? style,
    SnackPosition? snackPosition,
  }) {
    Get.closeAllSnackbars();
    return Get.rawSnackbar(
      messageText: Text(
        message,
        style: style ??
            Fonts.poppinsRegular12.copyWith(
              color: forgorundColor ?? Colors.white,
            ),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      borderRadius: 8.r,
      borderWidth: 1.r,
      snackPosition: snackPosition ?? SnackPosition.TOP,
      backgroundColor: backgroundColor,
      margin: EdgeInsets.all(16.w),
    );
  }
}
