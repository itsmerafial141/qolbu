import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/widgets/app_text_form_field.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/colors.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';

import '../controllers/auth_controller.dart';

abstract class AuthView<T extends AuthController> extends GetView<T> {
  const AuthView({super.key});

  @override
  T get controller => Get.find<T>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5EBE9),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/image/cluod_background.png",
            repeat: ImageRepeat.repeatY,
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.w,
                  width: 40.w,
                  child: MaterialButton(
                    onPressed: Get.back,
                    padding: EdgeInsets.zero,
                    color: Colors.white,
                    elevation: 0,
                    highlightElevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColor.PRIMARY,
                      size: 16.w,
                    ),
                  ),
                ),
                24.verticalSpaceFromWidth,
                Text(
                  "Log In",
                  style: Fonts.poppinsSemibold24,
                ),
                8.verticalSpaceFromWidth,
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      style: Fonts.poppinsRegular12,
                      children: [
                        TextSpan(text: "By Loggin in, you agree to our "),
                        TextSpan(text: "Terms of Use", style: Fonts.poppinsSemibold12),
                      ],
                    ),
                  ),
                ),
                24.verticalSpaceFromWidth,
                AppTextFormField(
                  label: "Email",
                  controller: controller.emailController,
                ),
                12.verticalSpaceFromWidth,
                Obx(() {
                  return AppTextFormField(
                    label: "Password",
                    controller: controller.passwordController,
                    obscureText: controller.isPassVisible.value,
                    suffixIcon: InkWell(
                      onTap: controller.onTapHidePassword,
                      child: Icon(
                        controller.isPassVisible.value
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye_rounded,
                        size: 18.w,
                      ),
                    ),
                  );
                }),
                24.verticalSpaceFromWidth,
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.onTapLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.PRIMARY,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Log In"),
                  ),
                ),
                12.verticalSpaceFromWidth,
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      style: Fonts.poppinsRegular12,
                      children: [
                        TextSpan(text: "Don't have account? "),
                        TextSpan(
                          text: "Register here.",
                          style: Fonts.poppinsSemibold12,
                          recognizer: TapGestureRecognizer()..onTap = controller.onTapRegister,
                        ),
                      ],
                    ),
                  ),
                ),
                48.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: Divider(thickness: 1.w, height: 1.w),
                    ),
                    8.horizontalSpace,
                    Text(
                      "Or",
                      style: Fonts.poppinsRegular12.copyWith(
                        color: AppColorSwatch.DISABLE.shade700,
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Divider(thickness: 1.w, height: 1.w),
                    ),
                  ],
                ),
                24.verticalSpaceFromWidth,
                OutlinedButton.icon(
                  onPressed: controller.onTapLoginWithGoogle,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                    textStyle: Fonts.poppinsMedium14,
                  ),
                  icon: SvgPicture.asset(
                    AppSvg.icGoogle,
                    height: 18.w,
                    width: 18.w,
                  ),
                  label: Text("Sign in with Google"),
                ),
                12.verticalSpaceFromWidth,
                OutlinedButton.icon(
                  onPressed: controller.onTapLoginWithFacebook,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99.r),
                    ),
                    textStyle: Fonts.poppinsMedium14,
                  ),
                  icon: SvgPicture.asset(
                    AppSvg.icFacebook,
                    height: 18.w,
                    width: 18.w,
                  ),
                  label: Text("Sign in with Facebook"),
                ),
                24.verticalSpaceFromWidth,
                SizedBox(
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                      style: Fonts.poppinsRegular12,
                      children: [
                        TextSpan(text: "For more information, please see our "),
                        TextSpan(text: "Privacy policy.", style: Fonts.poppinsSemibold12),
                      ],
                    ),
                  ),
                ),
              ],
            ).margin(horizontal: 16.w),
          )
        ],
      ),
    );
  }
}
