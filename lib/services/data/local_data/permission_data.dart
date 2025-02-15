// ignore: depend_on_referenced_packages
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:qolbu/core/values/consts/hive_box_const.dart';
import 'package:qolbu/core/values/keys/hive_key.dart';

class PermissionData {
  PermissionStatus? get notification {
    var data = HiveBox.data.get(HiveKey.permissionNotification);
    if (data is! int) return null;
    return PermissionStatus.values[data];
  }

  set notification(PermissionStatus? data) {
    HiveBox.data.put(HiveKey.permissionNotification, data?.value);
  }
}
