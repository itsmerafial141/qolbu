import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionService {
  static Future<void> checkVersion({
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
