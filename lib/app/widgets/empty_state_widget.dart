import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qolbu/core/extensions/font_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/colors.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';

class StateWidget extends StatelessWidget {
  final String message;
  final String icon;
  final Color backgroundColor;
  final Color forgroundColor;

  const StateWidget({
    super.key,
    required this.message,
    required this.icon,
    required this.backgroundColor,
    required this.forgroundColor,
  });

  factory StateWidget.empty({
    required String message,
    String icon = AppSvg.icAlert,
    Color backgroundColor = const Color.fromRGBO(242, 247, 247, 1),
    Color forgroundColor = AppColor.DISABLE,
  }) {
    return StateWidget(
      message: message,
      icon: icon,
      backgroundColor: backgroundColor,
      forgroundColor: forgroundColor,
    );
  }
  factory StateWidget.error({
    required String message,
    String icon = AppSvg.icAlert,
    Color backgroundColor = const Color.fromRGBO(239, 205, 209, 1),
    Color forgroundColor = AppColorSwatch.DANGER,
  }) {
    return StateWidget(
      message: message,
      icon: icon,
      backgroundColor: backgroundColor,
      forgroundColor: forgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: SvgPicture.asset(
            AppSvg.icAlert,
            width: 20.w, height: 20.w,
            // ignore: deprecated_member_use
            color: forgroundColor,
          ),
        ),
        12.verticalSpaceFromWidth,
        Text(
          message,
          style: Fonts.poppinsRegular14.fh(19.6.w),
        ),
      ],
    );
  }
}
