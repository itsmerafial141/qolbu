import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qolbu/app/widgets/dialog/double_button_dialog_widget.dart';
import 'package:qolbu/core/extensions/font_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/services/dialog_service.dart';

class TextDescription {
  final String text;
  final TextStyle? textStyle;

  TextDescription({
    required this.text,
    this.textStyle,
  });
}

class SingleButtonDialog extends StatelessWidget {
  final void Function()? onPressed;
  final String textButton;
  final String icon;
  final String label;
  final List<TextDescription>? textDescriptions;
  final IconDecoration? iconDecoration;

  const SingleButtonDialog({
    super.key,
    this.onPressed,
    required this.textButton,
    required this.icon,
    required this.label,
    this.textDescriptions,
    this.iconDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 41.w),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.w,
                  width: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconDecoration?.backgroundColor ?? const Color(0xFFC3F4F2),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      icon,
                      width: 20.w,
                      height: 20.w,
                      // ignore: deprecated_member_use
                      color: iconDecoration?.forgroundColor ?? AppColorSwatch.PRIMARY,
                    ),
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        label,
                        style: Fonts.poppinsSemibold16.fh(22.4.w),
                      ),
                      if (textDescriptions?.isNotEmpty ?? false) ...[
                        5.verticalSpaceFromWidth,
                        RichText(
                          text: TextSpan(
                            style: Fonts.poppinsRegular14
                                .copyWith(color: AppColorSwatch.NETRAL.shade500)
                                .fh(19.6),
                            children: textDescriptions?.map(
                              (e) {
                                return TextSpan(text: e.text, style: e.textStyle);
                              },
                            ).toList(),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ],
            ),
            25.verticalSpaceFromWidth,
            ElevatedButton(
              onPressed: onPressed != null ? onPressed! : DialogService.instance.close,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 25.w),
              ),
              child: Text(textButton),
            ),
          ],
        ),
      ),
    );
  }
}
