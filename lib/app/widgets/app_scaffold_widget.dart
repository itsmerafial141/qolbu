import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qolbu/core/extensions/font_extension.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';

class AppScaffoldGrdientColor {
  final List<Color>? colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  AppScaffoldGrdientColor({
    required this.colors,
    this.begin = Alignment.centerLeft,
    this.end = Alignment.centerRight,
  });
}

class AppScaffold extends Scaffold {
  final AppScaffoldGrdientColor? backgroundgradientColor;
  final Brightness? statusBarIconBrightness;
  const AppScaffold({
    super.key,
    super.appBar,
    super.body,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    super.drawer,
    super.onDrawerChanged,
    super.endDrawer,
    super.onEndDrawerChanged,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.backgroundColor,
    super.resizeToAvoidBottomInset,
    super.primary = true,
    super.drawerDragStartBehavior,
    super.extendBody = false,
    super.extendBodyBehindAppBar = false,
    super.drawerScrimColor,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture = true,
    super.endDrawerEnableOpenDragGesture = true,
    super.restorationId,
    this.backgroundgradientColor,
    this.statusBarIconBrightness = Brightness.dark,
  });

  const factory AppScaffold.customAppBar({
    required final String title,
    final void Function()? onTapBack,
    final Widget? body,
    final Widget? bottomNavigationBar,
    final bool extendBody,
    Widget? leading,
    bool centerTitle,
    Widget? drawer,
    void Function(bool)? onDrawerChanged,
  }) = CustomAppBarScaffold;

  @override
  Widget? get body {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: statusBarIconBrightness,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (backgroundgradientColor != null) _gradientColor,
          SvgPicture.asset(
            AppSvg.background,
            fit: BoxFit.cover,
            alignment: Alignment.topRight,
          ),
          defaultBody,
        ],
      ),
    );
  }

  Widget get defaultBody => super.body ?? const SizedBox();

  Widget get _gradientColor {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundgradientColor?.colors ?? [],
          begin: backgroundgradientColor!.begin,
          end: backgroundgradientColor!.end,
        ),
      ),
    );
  }
}

class CustomAppBarScaffold extends AppScaffold {
  final String title;
  final void Function()? onTapBack;
  final Widget? leading;
  final bool centerTitle;
  const CustomAppBarScaffold({
    super.key,
    required this.title,
    this.onTapBack,
    super.body,
    super.bottomNavigationBar,
    super.extendBody,
    this.leading,
    super.drawer,
    this.centerTitle = false,
    super.onDrawerChanged,
  });

  @override
  bool get drawerEnableOpenDragGesture => false;

  @override
  bool get endDrawerEnableOpenDragGesture => false;

  @override
  Widget get defaultBody {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          17.verticalSpaceFromWidth,
          Row(
            children: [
              leading ??
                  SizedBox(
                    width: 50.w,
                    height: 50.w,
                    child: MaterialButton(
                      onPressed: onTapBack ?? Get.back,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      elevation: 0,
                      highlightElevation: 0,
                      padding: EdgeInsets.zero,
                      color: AppColorSwatch.PRIMARY.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: SvgPicture.asset(
                        AppSvg.icArrowBack,
                        height: 25.w,
                        width: 25.w,
                      ),
                    ),
                  ),
              20.horizontalSpace,
              Expanded(
                child: Text(
                  title,
                  textAlign: centerTitle ? TextAlign.center : null,
                  style: Fonts.poppinsSemibold16.fh(22.4.w),
                ),
              ),
              20.horizontalSpace,
            ],
          ).margin(horizontal: 16.w),
          Expanded(child: super.defaultBody),
        ],
      ),
    );
  }
}
