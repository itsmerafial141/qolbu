import 'package:qolbu/app/data/models/response/base_raseponse.dart';
import 'package:qolbu/app/data/models/surah_model.dart';
import 'package:qolbu/services/dio/dio_service.dart';

class SurahRepository {
  static Future<List<SurahModel>> getSurah() async {
    try {
      var api = DioService.instance.call();
      var response = await api.get('/surat');
      // String jsonString = await rootBundle.loadString('assets/json/surah_list_114.json');
      // List<dynamic> data = await compute((message) => jsonDecode(jsonString), jsonString);
      // return data.map((e) => SurahModel.fromJson(e)).toList();
      var baseResponse = BaseResponse<List?>.fromJson(response);
      return baseResponse.data?.map((e) => SurahModel.fromJson(e)).toList() ?? [];
    } catch (e, s) {
      return Future.error(
        BaseResponse.error(message: "Gagal mendapatkan data surah"),
        s,
      );
    }
  }
}
