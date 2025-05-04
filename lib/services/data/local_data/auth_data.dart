
import 'package:qolbu/app/data/models/auth_model.dart';
import 'package:qolbu/core/values/consts/hive_box_const.dart';
import 'package:qolbu/core/values/keys/hive_key.dart';

class AuthData {
  AuthModel? get data => HiveBox.data.get(HiveKey.auth, defaultValue: null);

  set data(AuthModel? value) => HiveBox.data.put(HiveKey.auth, value);
}
