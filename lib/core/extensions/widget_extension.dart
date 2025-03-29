import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:shimmer/shimmer.dart';

extension WidgetExtension on Widget {
  Widget innerShadow({double? width, double? height}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.r),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -4),
              blurRadius: 10.r,
              color: Colors.black.withValues(alpha: .04),
            ),
            BoxShadow(
              blurRadius: 10.r,
              // spreadRadius: -2.w,
              offset: const Offset(0, 2),
              color: Colors.white,
            ),
          ],
        ),
        child: this,
      ),
    );
  }

  Widget backgroundColor({Color? color}) {
    return ColoredBox(
      color: color ?? Colors.transparent,
      child: this,
    );
  }

  Widget borderRadius({
    double? topLeft,
    double? topRight,
    double? bottomLeft,
    double? bottomRight,
    double? verticalTop,
    double? verticalBottom,
    double? horizontalLeft,
    double? horizontalRight,
    double? all,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(
          topLeft ?? verticalTop ?? horizontalLeft ?? all ?? 0,
        ),
        topRight: Radius.circular(
          topRight ?? verticalTop ?? horizontalRight ?? all ?? 0,
        ),
        bottomLeft: Radius.circular(
          bottomLeft ?? verticalBottom ?? horizontalLeft ?? all ?? 0,
        ),
        bottomRight: Radius.circular(
          bottomRight ?? verticalBottom ?? horizontalRight ?? all ?? 0,
        ),
      ),
      child: this,
    );
  }

  Widget margin({
    double? horizontal,
    double? vertical,
    double? top,
    double? right,
    double? bottom,
    double? left,
    double? all,
  }) {
    return Container(
      margin: EdgeInsets.only(
        top: top ?? vertical ?? all ?? 0,
        bottom: bottom ?? vertical ?? all ?? 0,
        left: left ?? horizontal ?? all ?? 0,
        right: right ?? horizontal ?? all ?? 0,
      ),
      child: this,
    );
  }

  Widget shimmer() {
    return Shimmer.fromColors(
      baseColor: AppColorSwatch.DISABLE,
      highlightColor: Colors.white,
      child: this,
    );
  }
}

extension TextStyleExtension on TextStyle {
  double size(String value) {
    return (TextPainter(
      text: TextSpan(
        text: value,
        style: this,
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout())
        .width;
  }
}
