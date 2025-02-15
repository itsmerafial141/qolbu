import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qolbu/core/extensions/font_extension.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/enums/status_enum.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? forgroundColor;
  final Status? status;
  final double size;

  const StatusChip._({
    required this.label,
    this.backgroundColor,
    this.forgroundColor,
    this.status,
    this.size = 1,
  });
  factory StatusChip({
    required String label,
    Color? backgroundColor,
    Color? forgroundColor,
    double size = 1,
  }) {
    return StatusChip._(
      label: label,
      backgroundColor: backgroundColor,
      forgroundColor: forgroundColor,
      size: size,
    );
  }
  factory StatusChip.fromStatus({
    required String label,
    Status? status,
    double size = 1,
  }) {
    return StatusChip._(label: label, status: status, size: size);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.w * size, horizontal: 16.w * size),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: status?.backgroundColor ?? backgroundColor,
        border: Border.all(
          width: 1.w,
          color: status?.forgroundColor ?? forgroundColor ?? Colors.transparent,
        ),
      ),
      child: Text(
        label,
        style: Fonts.poppinsRegular11
            .copyWith(color: status?.forgroundColor ?? forgroundColor, fontSize: 11 * size)
            .fh(15.4.w * size),
      ),
    );
  }
}
