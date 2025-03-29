import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qolbu/app/data/models/juz_model.dart';
import 'package:qolbu/app/data/repository/juz_repository.dart';
import 'package:qolbu/core/values/enums/edition_enum.dart';

class JuzController extends GetxController with StateMixin<(JuzModel?, JuzModel?)> {
  static bool get isRegistered => Get.isRegistered();
  static JuzController get find => isRegistered ? Get.find() : Get.put(JuzController());

  final RefreshController refreshController = RefreshController();

  JuzModel? juzArabic;
  JuzModel? juzLatin;

  @override
  void onReady() {
    initializeApi();
    super.onReady();
  }

  void onRefresh() {
    initializeApi();
  }

  void onLoadMore([bool isLoadMore = true]) {}

  void initializeApi([bool isLoadMore = false]) async {
    change(null, status: RxStatus.loading());
    var responseArabic = JuzRepository.getJuz();
    var responseLatin = JuzRepository.getJuz(edition: EditionEnum.EN_TRANSLITERATION);
    await Future.wait([
      responseArabic.then((value) => juzArabic = value),
      responseLatin.then((value) => juzLatin = value)
    ]).then((value) {
      if ((juzArabic?.ayahs?.isEmpty ?? true) || (juzLatin?.ayahs?.isEmpty ?? true)) {
        change(null, status: RxStatus.empty());
        return;
      }
      change((juzArabic, juzLatin), status: RxStatus.success());
    });
  }

  void onTapJuz((Ayah, Ayah) data) {}
}
