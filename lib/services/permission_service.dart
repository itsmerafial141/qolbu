import 'package:app_settings/app_settings.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qolbu/app/widgets/dialog/double_button_dialog_widget.dart';
import 'package:qolbu/services/dialog_service.dart';

class PermissionService {
  static Future<void> checkPermisison(
    Permission permission,
    String title,
    String description, {
    required void Function(PermissionStatus status) onGranted,
    required void Function(PermissionStatus status) onDenied,
    required void Function(PermissionStatus status) onPermanentlyDenied,
    Function(PermissionStatus status)? onLimited,
    Function(PermissionStatus status)? onProvisional,
    Function(PermissionStatus status)? onRestricted,
  }) async {
    if (await permission.request().isGranted) {
      "isGranted".printInfo();
      onGranted(PermissionStatus.granted);
      return;
    }
    await DialogService.showGeneralDialog(
      child: DoubleButtonDialog(
        label: description,
        // description: description,
        icon: '',
        positiveTextButton: "Beri Izin",
        negativeTextButton: "Jangan",
        onPressedNegative: () {
          onDenied(PermissionStatus.denied);
          DialogService.close();
        },
        onPressedPositive: () async {
          DialogService.close();
          await _checkStatus(
            permission,
            onDenied,
            onGranted,
            onPermanentlyDenied,
            onRestricted,
            onLimited,
            onProvisional,
            redirected: true,
          );
        },
      ),
    );
  }

  static Future<void> _checkStatus(
    Permission permission,
    void Function(PermissionStatus status) onDenied,
    void Function(PermissionStatus status) onGranted,
    void Function(PermissionStatus status) onPermanentlyDenied,
    void Function(PermissionStatus status)? onRestricted,
    void Function(PermissionStatus status)? onLimited,
    void Function(PermissionStatus status)? onProvisional, {
    bool redirected = false,
  }) async {
    await permission.onDeniedCallback(() {
      "isDenied".printInfo();
      onDenied(PermissionStatus.denied);
    }).onGrantedCallback(() {
      "isGranted".printInfo();
      onGranted(PermissionStatus.granted);
    }).onPermanentlyDeniedCallback(() async {
      "isPermanentlyDenied".printInfo();
      if (redirected) {
        await AppSettings.openAppSettings(type: AppSettingsType.notification).then((value) async {
          await _checkStatus(
            permission,
            onDenied,
            onGranted,
            onPermanentlyDenied,
            onRestricted,
            onLimited,
            onProvisional,
          );
        });
      }
      onPermanentlyDenied(PermissionStatus.permanentlyDenied);
    }).onRestrictedCallback(() {
      "isRestricted".printInfo();
      if (onRestricted != null) onRestricted(PermissionStatus.restricted);
    }).onLimitedCallback(() {
      "isLimited".printInfo();
      if (onLimited != null) onLimited(PermissionStatus.limited);
    }).onProvisionalCallback(() {
      "isProvisional".printInfo();
      if (onProvisional != null) onProvisional(PermissionStatus.provisional);
    }).request();
  }
}
