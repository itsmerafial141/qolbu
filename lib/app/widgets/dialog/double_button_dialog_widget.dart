import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qolbu/core/extensions/font_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/services/dialog_service.dart';

class IconDecoration {
  final Color? backgroundColor;
  final Color? forgroundColor;

  IconDecoration({
    this.backgroundColor,
    this.forgroundColor,
  });
}

class DoubleButtonDialog extends StatelessWidget {
  final void Function()? onPressedPositive;
  final void Function()? onPressedNegative;
  final String negativeTextButton;
  final String positiveTextButton;
  final String icon;
  final String label;
  final IconDecoration? iconDecoration;

  const DoubleButtonDialog({
    super.key,
    this.onPressedPositive,
    this.onPressedNegative,
    required this.negativeTextButton,
    required this.positiveTextButton,
    required this.icon,
    required this.label,
    this.iconDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 41.w),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                height: 40.w,
                width: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconDecoration?.backgroundColor ?? const Color(0xFFC3F4F2),
                ),
                child: SvgPicture.asset(
                  icon,
                  width: 15.w,
                  height: 15.w,
                  fit: BoxFit.scaleDown,
                  // ignore: deprecated_member_use
                  color: iconDecoration?.forgroundColor ?? AppColorSwatch.PRIMARY,
                ),
              ),
              15.horizontalSpace,
              Expanded(
                child: Text(
                  label,
                  style: Fonts.poppinsSemibold16.fh(22.4.w),
                ),
              ),
            ],
          ),
          25.verticalSpaceFromWidth,
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: onPressedNegative != null ? onPressedNegative! : DialogService.close,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 25.w),
                  backgroundColor: AppColorSwatch.PRIMARY.shade200,
                ),
                child: Text(
                  negativeTextButton,
                  style: Fonts.poppinsBold14.copyWith(
                    height: (20 / 14).sp,
                    color: AppColorSwatch.PRIMARY,
                  ),
                ),
              ),
              8.horizontalSpace,
              ElevatedButton(
                onPressed: onPressedPositive != null ? onPressedPositive! : DialogService.close,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 25.w),
                ),
                child: Text(positiveTextButton),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
