import 'package:qolbu/core/values/consts/hive_box_const.dart';
import 'package:qolbu/services/data/local_data/auth_data.dart';
import 'package:qolbu/services/data/local_data/notification_data.dart';
import 'package:qolbu/services/data/local_data/permission_data.dart';
import 'package:qolbu/services/data/local_data/user_data.dart';
import 'package:qolbu/services/data/local_data/version_data.dart';

class DataService {
  DataService._();
  static Future clear() => HiveBox.data.clear();

  static AuthData auth = AuthData();
  static UserData user = UserData();
  static VersionData version = VersionData();
  static NotificationData notification = NotificationData();
  static PermissionData permission = PermissionData();
}
