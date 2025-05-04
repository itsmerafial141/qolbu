import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qolbu/core/themes/color_swatch.dart';

class Skelaton extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final Widget? child;
  const Skelaton({
    super.key,
    this.height = 20,
    this.width = 20,
    this.borderRadius,
    this.color,
    this.child,
  });

  const Skelaton.text({
    super.key,
    this.height = 15,
    this.width = 20,
    this.borderRadius,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height?.w,
      width: width?.w,
      decoration: BoxDecoration(
        color: color ?? AppColorSwatch.DISABLE.shade300,
        borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
      ),
      child: child,
    );
  }
}
