import 'package:qolbu/app/data/models/user_model.dart';
import 'package:qolbu/core/values/consts/hive_box_const.dart';
import 'package:qolbu/core/values/keys/hive_key.dart';

class UserData {
  UserModel? get data => HiveBox.data.get(HiveKey.user, defaultValue: null);

  set data(UserModel? value) => HiveBox.data.put(HiveKey.user, value);
}
