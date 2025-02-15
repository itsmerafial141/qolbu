import 'package:qolbu/core/values/consts/hive_box_const.dart';
import 'package:qolbu/core/values/keys/hive_key.dart';

class NotificationData {
  String? get fcmToken => HiveBox.data.get(HiveKey.fcmToken);

  set fcmToken(String? value) => HiveBox.data.put(HiveKey.fcmToken, value);
}
