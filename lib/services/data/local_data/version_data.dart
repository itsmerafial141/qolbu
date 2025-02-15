import 'package:qolbu/core/values/consts/hive_box_const.dart';
import 'package:qolbu/core/values/keys/hive_key.dart';

class VersionData {
  String? get data => HiveBox.config.get(HiveKey.version);

  set data(String? value) => HiveBox.config.put(HiveKey.version, value);
}
