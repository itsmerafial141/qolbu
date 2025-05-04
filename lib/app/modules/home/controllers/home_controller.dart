import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qolbu/app/controllers/user_controller.dart';
import 'package:qolbu/app/modules/home/components/juz_component.dart';
import 'package:qolbu/app/modules/home/components/surah_component.dart';
import 'package:qolbu/app/routes/app_pages.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  static bool get isRegistered => Get.isRegistered();
  static HomeController get find => isRegistered ? Get.find() : Get.put(HomeController());

  final RefreshController refreshController = RefreshController();

  late final TabController tabController;
  late final PageController tabPageController;
  List<(String, Widget)> get tabs => [
        ("Surah", SurahComponent()),
        ("Juz", JuzComponent()),
        ("Halaman", SizedBox()),
        ("Doa", SizedBox()),
      ];

  @override
  void onInit() {
    _initializeData();
    super.onInit();
  }

  @override
  void onReady() {
    _initializeApi();
    super.onReady();
  }

  void _initializeApi() async {
    Future.wait([
      UserController.find.initializeApi(),
    ]).whenComplete(() {
      refreshController.refreshCompleted();
    });
  }

  void _initializeData() {
    tabController = TabController(length: tabs.length, vsync: this);
    tabPageController = PageController();
  }

  void onTapSearch() {}

  void onTapTab(int value) {
    tabPageController.animateToPage(
      value,
      duration: Durations.medium1,
      curve: Curves.decelerate,
    );
  }

  void onTapSeeAllSurah() {
    Get.toNamed(Routes.SURAH);
  }

  void onTapSeeAllJuz() {}

  void onTapHeader() {
    Get.toNamed(Routes.LOGIN);
  }

  void onRefresh() {
    _initializeApi();
  }
}
