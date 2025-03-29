import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qolbu/core/values/enums/flavor_enum.dart';

class FlavorServices {
  static Flavor flavor = Flavor.DEVELOPMENT;
  static String buildNumber = "0";
  static int androidVersion = 0;
  static Future<Flavor> initialize() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      buildNumber = packageInfo.buildNumber;

      if (Platform.isAndroid) {
        androidVersion = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
      }
      log(packageInfo.packageName, name: "PACKAGE NAME");
      flavor = switch (packageInfo.packageName.split('.').lastOrNull) {
        "dev" => Flavor.DEVELOPMENT,
        "qa" => Flavor.STAGING,
        _ => Flavor.PRODUCTION,
      };
      return flavor;
    } catch (e, s) {
      e.printError(info: "ERROR FLAVOR SERVICE");
      s.printError(info: "ERROR FLAVOR SERVICE");
      return Future.error("Error initialize flavor");
    }
  }
}
