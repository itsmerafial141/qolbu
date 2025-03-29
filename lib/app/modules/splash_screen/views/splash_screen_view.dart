import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/widgets/app_scaffold_widget.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/colors.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Qolbu',
              textAlign: TextAlign.center,
              style: Fonts.poppinsBold28.copyWith(color: AppColor.PRIMARY),
            ),
            16.verticalSpaceFromWidth,
            Text(
              'Hafalkan dan baca\nQuran dengan mudah',
              textAlign: TextAlign.center,
              style: Fonts.poppinsRegular18.copyWith(color: AppColor.RomanSilver),
            ),
            50.verticalSpaceFromWidth,
            SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SvgPicture.asset(AppSvg.icSplashBG).margin(bottom: 25.w),
                  ElevatedButton(
                    onPressed: controller.onTapMulai,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 17.w, horizontal: 40.w),
                    ),
                    child: Text(
                      "Ayo Mulai",
                      style: Fonts.poppinsSemibold16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ).margin(horizontal: 30.w),
      ),
    );
  }
}
