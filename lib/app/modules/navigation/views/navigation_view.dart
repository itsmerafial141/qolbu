import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/widgets/app_scaffold_widget.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/colors.dart';
import 'package:qolbu/core/themes/fonts.dart';

import '../controllers/navigation_controller.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      extendBody: true,
      body: PageView.builder(
        controller: controller.pageController,
        itemCount: controller.pages.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return controller.pages[index].$1;
        },
      ),
      bottomNavigationBar: _BottomNavigationBar(),
    );
  }
}

class _BottomNavigationBar extends GetView<NavigationController> {
  const _BottomNavigationBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            color: AppColor.SECONDARY.withValues(alpha: .3),
          ),
          BoxShadow(
            blurRadius: 8.r,
            spreadRadius: -4.w,
            color: Colors.white,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: controller.pages.asMap().entries.map((e) {
          return Obx(() {
            var isSelected = controller.selectedPage.value == e.key;
            return AnimatedContainer(
              margin: EdgeInsets.symmetric(vertical: 8.w),
              duration: Durations.short2,
              decoration: BoxDecoration(
                color: AppColor.SECONDARY.withValues(alpha: isSelected ? .8 : 0),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.r),
                  onTap: isSelected ? null : () => controller.onTapMenu(e.value, e.key),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        e.value.$2,
                        width: 32.w,
                        height: 32.w,
                        colorFilter: ColorFilter.mode(
                            isSelected
                                ? AppColor.PRIMARY.withValues(alpha: .8)
                                : AppColor.PRIMARY.withValues(alpha: .2),
                            BlendMode.srcIn),
                      ),
                      AnimatedContainer(
                        duration: Durations.long1,
                        width: isSelected ? Fonts.poppinsSemibold12.size(e.value.$3).w + 8.w : 0,
                        curve: Curves.decelerate,
                        margin: EdgeInsets.only(left: isSelected ? 8.w : 0),
                        child: AnimatedDefaultTextStyle(
                          duration: Durations.medium1,
                          curve: Curves.easeInOut,
                          style: Fonts.poppinsSemibold12.copyWith(
                            color: isSelected
                                ? AppColor.PRIMARY.withValues(alpha: .8)
                                : AppColor.SECONDARY, // Animated color
                          ),
                          child: Text(
                            e.value.$3,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ],
                  ).margin(all: 5.w),
                ),
              ),
            );
          });
        }).toList(),
      ),
    );
  }
}
