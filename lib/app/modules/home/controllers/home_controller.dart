import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/modules/home/components/juz_component.dart';
import 'package:qolbu/app/modules/home/components/surah_component.dart';
import 'package:qolbu/app/routes/app_pages.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  static bool get isRegistered => Get.isRegistered();
  static HomeController get find => isRegistered ? Get.find() : Get.put(HomeController());

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

  void _initializeApi() async {}

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

  void onTapSeeAllJuz() {
  }
}
