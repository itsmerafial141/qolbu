import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';

class DrawerService {
  static void close() {
    if (Get.isSnackbarOpen) Get.close(1);
    if (Get.isBottomSheetOpen ?? false) Get.back();
  }

  static Future<dynamic> showDrawer({
    String? title,
    bool barrierDismissible = false,
    bool withStrip = false,
    EdgeInsetsGeometry? padding,
    double? marginHeight,
    Widget? body,
    ScrollPhysics? physics,
    Color? backgroundColor,
  }) async {
    return await Get.bottomSheet(
      PopScope(
        canPop: kDebugMode ? true : barrierDismissible,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: ClipRRect(
            // borderRadius: BorderRadius.only(
            //   topLeft: Radius.circular(AppDouble.BORDER_RADIUES.r),
            //   topRight: Radius.circular(AppDouble.BORDER_RADIUES.r),
            // ),
            child: SingleChildScrollView(
              physics: physics,
              child: Container(
                color: backgroundColor ?? Colors.white,
                child: Column(
                  children: [
                    if (withStrip)
                      Column(
                        children: [
                          Container(
                            width: 65.h,
                            height: 5.h,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(2.5)),
                              color: withStrip ? const Color(0xffe8e8e8) : Colors.transparent,
                            ),
                          ),
                          16.verticalSpace,
                        ],
                      ),
                    if (title != null)
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: Fonts.poppinsSemibold16,
                              ),
                            ),
                            IconButton(
                              onPressed: close,
                              iconSize: 24.w,
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                    if (body != null)
                      Padding(
                        padding: padding ?? EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 40.w),
                        child: body,
                      ),
                  ],
                ),
              ),
            ),
          ).marginOnly(top: marginHeight ?? .2.sh),
        ),
      ),
      enableDrag: true,
      isDismissible: barrierDismissible,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enterBottomSheetDuration: const Duration(milliseconds: 500),
      exitBottomSheetDuration: const Duration(milliseconds: 500),
    );
  }

  static void showComingSoon() {
    DrawerService.showDrawer(
      barrierDismissible: true,
      title: "Coming Soon!",
      padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 40.w),
      body: Column(
        children: [
          Text(
            "Fitur ini akan segera hadir. Silahkan nikmati fitur yang lain dulu.",
            style: Fonts.poppinsRegular13,
          ),
          8.verticalSpace,
          SvgPicture.asset(AppSvg.ilsComingSoon),
        ],
      ),
    );
  }
}
