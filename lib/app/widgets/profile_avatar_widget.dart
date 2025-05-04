import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/controllers/user_controller.dart';
import 'package:qolbu/app/widgets/app_skelaton_widget.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';

class ProfileAvatar extends StatelessWidget {
  final double radius;

  const ProfileAvatar({
    super.key,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return UserController.find.obx(
      (data) {
        return CircleAvatar(
          radius: radius,
          backgroundColor: AppColorSwatch.DISABLE,
          // foregroundImage: NetworkImage(data?.picture?.firstOrNull?.path ?? ""),
          onForegroundImageError: (exception, stackTrace) {},
          child: Icon(
            Icons.person_outline_rounded,
            size: radius,
            color: AppColorSwatch.PRIMARY,
          ),
        );
      },
      onLoading: Skelaton(
        borderRadius: 999,
        height: radius * 2,
        width: radius * 2,
      ).shimmer(),
      onError: (error) {
        return CircleAvatar(
          radius: radius,
          backgroundColor: AppColorSwatch.DISABLE,
          child: Icon(
            Icons.person_outline_rounded,
            size: 42.w,
            color: AppColorSwatch.PRIMARY,
          ),
        );
      },
    );
  }
}
