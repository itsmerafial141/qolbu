import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qolbu/app/controllers/user_controller.dart';
import 'package:qolbu/app/data/models/user_model.dart';
import 'package:qolbu/app/widgets/app_scaffold_widget.dart';
import 'package:qolbu/app/widgets/app_skelaton_widget.dart';
import 'package:qolbu/core/extensions/widget_extension.dart';
import 'package:qolbu/core/themes/colors.dart';
import 'package:qolbu/core/themes/fonts.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';
import 'package:qolbu/services/data/data_service.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      systemUiOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarDividerColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        physics: BouncingScrollPhysics(),
        onRefresh: controller.onRefresh,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: SizedBox(
            height: 1.sh,
            child: SafeArea(
              child: Column(
                children: [
                  _Header(),
                  16.verticalSpaceFromWidth,
                  _Card(),
                  24.verticalSpaceFromWidth,
                  _Tab(),
                  _TabValue(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabValue extends GetView<HomeController> {
  const _TabValue();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: controller.tabPageController,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => controller.tabs[index].$2,
      ),
    );
  }
}

class _Tab extends GetView<HomeController> {
  const _Tab();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 6.w),
      decoration: BoxDecoration(
        color: AppColor.SECONDARY.withValues(alpha: .5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: AppColor.PRIMARY.withValues(alpha: .5),
        automaticIndicatorColorAdjustment: true,
        indicatorColor: AppColor.PRIMARY,
        indicatorWeight: 2.w,
        dividerHeight: 2.w,
        indicator: BoxDecoration(
          color: Color(0xFF588B76),
          borderRadius: BorderRadius.circular(6.r),
        ),
        unselectedLabelStyle: Fonts.poppinsMedium12,
        labelStyle: Fonts.poppinsSemibold12,
        labelPadding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 12.w),
        controller: controller.tabController,
        onTap: controller.onTapTab,
        enableFeedback: true,
        indicatorAnimation: TabIndicatorAnimation.elastic,
        tabs: controller.tabs.map((e) {
          return Text(
            e.$1,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }).toList(),
      ),
    );
  }
}

class _Card extends GetView<HomeController> {
  const _Card();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        gradient: LinearGradient(
          colors: [
            Color(0xFF588B76),
            Color(0xFFD0DED8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppSvg.icReadme, height: 20.w, width: 20.w),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      "Bacaan Terkahir",
                      style: Fonts.poppinsMedium14.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              20.verticalSpaceFromWidth,
              Text(
                "Al-Fatihah",
                style: Fonts.poppinsSemibold18.copyWith(color: Colors.white),
              ),
              4.verticalSpaceFromWidth,
              Text(
                "Ayat No: 1",
                style: Fonts.poppinsRegular14.copyWith(color: Colors.white),
              ),
            ],
          ).margin(horizontal: 20.w, vertical: 19.w),
          Positioned(
            bottom: -28.w,
            right: -35.w,
            child: SvgPicture.asset(
              AppSvg.ilsQuran,
              width: 206.w,
            ),
          )
        ],
      ),
    );
  }
}

class _Header extends GetView<HomeController> {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: controller.onTapHeader,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: UserController.find.obx(
              success,
              onEmpty: empty(),
              onLoading: loading().shimmer(),
              onError: (_) => empty(),
            ),
          ),
        ),
        12.horizontalSpace,
        IconButton(
          onPressed: controller.onTapSearch,
          splashRadius: 24.w,
          icon: SvgPicture.asset(
            AppSvg.icSearch,
            width: 24.w,
            height: 24.w,
          ),
        ),
      ],
    ).margin(horizontal: 24.w);
  }

  Widget success(UserModel? state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 2.w,
      children: [
        _salamWidget(),
        Text(
          "Rafi Fitra Alamsyah",
          style: Fonts.poppinsRegular12.copyWith(color: AppColor.PRIMARY),
        ),
      ],
    );
  }

  Text _salamWidget() {
    return Text(
      "Asslamualaikum",
      style: Fonts.poppinsBold20.copyWith(
        color: AppColor.PRIMARY,
        height: 1.sp,
      ),
    );
  }

  Text empty() => _salamWidget();

  static Widget loading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 2.w,
      children: [
        Skelaton.text(
          width: .5.sw,
          height: 20.w,
        ),
        if (DataService.user.data != null) ...[Skelaton.text(width: .3.sw)]
      ],
    );
  }
}
