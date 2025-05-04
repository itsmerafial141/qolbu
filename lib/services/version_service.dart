import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionService {
  VersionService._();
  static bool get isRegistered => Get.isRegistered<VersionService>();
  static VersionService get find {
    if (isRegistered) return Get.find<VersionService>();
    return Get.put<VersionService>(VersionService._());
  }

  static VersionService get instance => find;

  static Future<VersionService> initialize() async => Get.put(VersionService._(), permanent: true);

  Future<void> checkVersion({
    String? flavor,
    required String? localVersion,
    required Function(String? previouesVersion, String currentVersion) onChangedVersion,
    Function(String version)? onSameVersion,
  }) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var version =
        "${(flavor != null && flavor.toLowerCase() != 'production') ? "${flavor.capitalizeFirst} " : ""}${packageInfo.version}+${packageInfo.buildNumber}";
    if (localVersion == version) {
      "Version app is same $version".printInfo(info: "VERSION");
      if (onSameVersion != null) return onSameVersion(version);
      return;
    }
    "Version app is cahnged $localVersion =>  $version".printInfo(info: "VERSION");
    onChangedVersion(localVersion, version);
    return;
  }
}
