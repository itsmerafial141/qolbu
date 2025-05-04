import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qolbu/core/values/enums/flavor_enum.dart';

class FlavorServices {
  FlavorServices._();
  static bool get isRegistered => Get.isRegistered<FlavorServices>();
  static FlavorServices get find {
    if (isRegistered) return Get.find<FlavorServices>();
    return Get.put<FlavorServices>(FlavorServices._());
  }

  static FlavorServices get instance => find;

  Flavor _flavor = Flavor.DEVELOPMENT;
  Flavor get flavor => instance._flavor;
  set flavor(Flavor data) => instance._flavor = data;

  String _buildNumber = "0";
  String get buildNumber => instance._buildNumber;
  set buildNumber(String data) => instance._buildNumber = data;

  int _androidVersion = 0;
  int get androidVersion => instance._androidVersion;
  set androidVersion(int data) => instance._androidVersion = data;

  static Future<Flavor> initialize() async {
    Get.put(FlavorServices._(), permanent: true);
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      instance.buildNumber = packageInfo.buildNumber;

      if (Platform.isAndroid) {
        instance.androidVersion = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
      }
      log(packageInfo.packageName, name: "PACKAGE NAME");
      instance._flavor = switch (packageInfo.packageName.split('.').lastOrNull) {
        "dev" => Flavor.DEVELOPMENT,
        "qa" => Flavor.STAGING,
        _ => Flavor.PRODUCTION,
      };
      return instance._flavor;
    } catch (e, s) {
      e.printError(info: "ERROR FLAVOR SERVICE");
      s.printError(info: "ERROR FLAVOR SERVICE");
      return Future.error("Error initialize flavor");
    }
  }
}
