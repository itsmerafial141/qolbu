import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qolbu/app/widgets/app_skelaton_widget.dart';
import 'package:qolbu/core/extensions/font_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/fonts.dart';

class Subtitle extends StatelessWidget {
  const Subtitle({
    super.key,
    required this.label,
    required this.textButton,
    required this.onTapAll,
  });

  final String label;
  final String textButton;
  final void Function() onTapAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Fonts.poppinsSemibold16.copyWith(color: AppColorSwatch.PRIMARY).fh(22.4.w),
          ),
        ),
        20.horizontalSpace,
        GestureDetector(
          onTap: onTapAll,
          child: Text(
            textButton,
            style: Fonts.poppinsRegular14.copyWith(color: AppColorSwatch.PRIMARY).fh(19.6),
          ),
        ),
      ],
    );
  }

  static Widget get loading {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Skelaton.text(width: 110.w, height: 22.4.w),
        20.horizontalSpace,
        Skelaton.text(width: 80.w, height: 19.6.w),
      ],
    );
  }
}
