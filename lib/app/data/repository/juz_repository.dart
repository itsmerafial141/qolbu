import 'package:qolbu/app/data/models/juz_model.dart';
import 'package:qolbu/app/data/models/response/base_raseponse.dart';
import 'package:qolbu/core/values/enums/edition_enum.dart';
import 'package:qolbu/core/values/enums/method_enum.dart';
import 'package:qolbu/services/dio/dio_service.dart';

class JuzRepository {
  static Future<JuzModel> getJuz({
    EditionEnum edition = EditionEnum.QURAN_UTHMANI,
    int juz = 1,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      var response = await DioService.call(
        '/juz/$juz/${edition.id}',
        customBaseUrl: 'https://api.alquran.cloud/v1',
        method: Method.GET,
        queryParameters: {
          "offset": offset,
          "limit": limit,
        },
      );
      // String jsonString = await rootBundle.loadString('assets/json/surah_list_114.json');
      // List<dynamic> data = await compute((message) => jsonDecode(jsonString), jsonString);
      // return data.map((e) => SurahModel.fromJson(e)).toList();
      var baseResponse = BaseResponse.fromJson(response);
      return JuzModel.fromJson(baseResponse.data);
    } catch (e, s) {
      return Future.error(
        BaseResponse.error(message: "Gagal mendapatkan data surah"),
        s,
      );
    }
  }
}
