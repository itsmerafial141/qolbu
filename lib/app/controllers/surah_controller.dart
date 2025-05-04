import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qolbu/app/data/models/response/base_raseponse.dart';
import 'package:qolbu/app/data/models/surah_model.dart';
import 'package:qolbu/app/data/repository/surah_repository.dart';
import 'package:qolbu/services/dialog_service.dart';

class SurahController extends GetxController with StateMixin<List<SurahModel>> {
  static bool get isRegistered => Get.isRegistered();
  static SurahController get find => isRegistered ? Get.find() : Get.put(SurahController());

  final RefreshController refreshController = RefreshController();

  List<SurahModel> surah = [];

  final int maxLoad = 20;

  @override
  void onReady() {
    initializeApi();
    super.onReady();
  }

  void onRefresh() {
    initializeApi();
  }

  void onLoadMore([bool useLoadMore = true]) async {
    if (!useLoadMore) return;
    await Future.delayed(Durations.short4);
    if (surah.isEmpty) {
      refreshController.loadNoData();
      return;
    }
    refreshController.loadComplete();
    var currentData = value;
    if (surah.length < 20) {
      currentData?.addAll(surah.sublist(0, surah.length));
      surah.removeRange(0, surah.length);
    } else {
      currentData?.addAll(surah.sublist(0, 20));
      surah.removeRange(0, 20);
    }
    change(currentData, status: RxStatus.success());
  }

  void initializeApi([bool isLoadMore = false]) async {
    surah = List.empty();
    change(null, status: RxStatus.loading());
    var response = SurahRepository.getSurah();
    await response.then((value) {
      if (value.isEmpty) {
        change(null, status: RxStatus.empty());
        return;
      }
      surah = value;
      change(surah.sublist(0, 20), status: RxStatus.success());
      surah.removeRange(0, 20);
    }).onError((BaseResponse error, stackTrace) {
      change(null, status: RxStatus.error());
      DialogService.instance.showProblem(
        message: error.message,
        errorText: error.curl,
      );
    }).whenComplete(() {
      refreshController.refreshCompleted();
    });
  }

  void onTapSurah(SurahModel data) {}
}
