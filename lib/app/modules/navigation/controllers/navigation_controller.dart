import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/modules/home/views/home_view.dart';
import 'package:qolbu/app/modules/memorize/views/memorize_view.dart';
import 'package:qolbu/app/modules/recite/views/recite_view.dart';
import 'package:qolbu/app/modules/retain/views/retain_view.dart';
import 'package:qolbu/app/modules/save/views/save_view.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';

class NavigationController extends GetxController {
  static bool get isRegistered => Get.isRegistered<NavigationController>();
  static NavigationController get find {
    if (isRegistered) return Get.find<NavigationController>();
    return Get.put(NavigationController());
  }

  List<(Widget, String, String)> get pages => [
        (HomeView(), AppSvg.icQuran, "Read"),
        (MemorizeView(), AppSvg.icMemorize, "Memorize"),
        (ReciteView(), AppSvg.icRecite, "Recite"),
        (RetainView(), AppSvg.icRetain, "Retain"),
        (SaveView(), AppSvg.icSave, "Save"),
      ];

  RxInt selectedPage = RxInt(0);

  final PageController pageController = PageController();

  void onTapMenu((Widget, String, String) e, int index) {
    selectedPage.value = index;
    pageController.animateToPage(index, duration: Durations.medium1, curve: Curves.easeInOut);
  }

  void onPageChanged(int value) {}
}
