import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:qolbu/app/widgets/app_loading_widget.dart';
import 'package:qolbu/app/widgets/dialog/double_button_dialog_widget.dart';
import 'package:qolbu/app/widgets/dialog/general_dialog_widget.dart';
import 'package:qolbu/app/widgets/dialog/single_button_dialog.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/themes/main_theme.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';
import 'package:qolbu/core/values/enums/flavor_enum.dart';
import 'package:qolbu/services/flavor_service.dart';

class DialogService {
  DialogService._();
  static bool get isRegistered => Get.isRegistered<DialogService>();
  static DialogService get find {
    if (isRegistered) return Get.find<DialogService>();
    return Get.put<DialogService>(DialogService._());
  }

  static DialogService get instance => find;

  static Future<DialogService> initialize() async => Get.put(DialogService._(), permanent: true);

  void closeLoading() {
    close();
  }

  void close() {
    if (Get.isSnackbarOpen) Get.close(1);
    if (Get.isDialogOpen ?? false) Get.back();
  }

  void showDialogDatePicker(
    BuildContext context, {
    required Function(DateTime datetime) onDatePicker,
  }) async {
    var datetime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 36500)),
      lastDate: DateTime.now().add(const Duration(days: 36500)),
      confirmText: "Simpan",
      cancelText: "Batal",
      locale: Get.locale,
    );

    if (datetime != null) {
      onDatePicker(datetime);
    }
  }

  Future<void> showDialogRangeDatePicker(
    BuildContext context, {
    required Function(DateTimeRange dateRange) onDatePicker,
  }) async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      theme: lightTheme.copyWith(
        textButtonTheme: TextButtonThemeData(
          style: ElevatedButton.styleFrom(foregroundColor: AppColorSwatch.PRIMARY),
        ),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
    );

    if (dateTimeList == null) return;
    var datetime = DateTimeRange(start: dateTimeList.first, end: dateTimeList.last);
    onDatePicker(datetime);
  }

  void showLoading({
    bool barrierDismissible = false,
  }) {
    DialogService.instance.close();
    Get.dialog(
      AppLoading(barrierDismissible: barrierDismissible),
      barrierDismissible: barrierDismissible,
      transitionCurve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black26,
    );
  }

  Future<T?> showGeneralDialog<T>({
    bool barrierDismissible = false,
    Widget? child,
  }) async {
    DialogService.instance.close();
    return Get.dialog<T>(
      PopScope(
        canPop: kDebugMode ? true : barrierDismissible,
        child: Center(
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Material(
                  color: Colors.transparent,
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
      transitionCurve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Future<T?> showProblem<T>({
    void Function()? onPressed,
    String textButton = "Kembali",
    String icon = AppSvg.icAlert,
    String label = "Terjadi Kesalahan",
    String? errorText,
    String? message,
    IconDecoration? iconDecoration,
    bool barrierDismissible = false,
  }) {
    DialogService.instance.close();
    return showGeneralDialog<T>(
      barrierDismissible: barrierDismissible,
      child: GeneralDialog.error(
        icon: icon,
        iconDecoration: iconDecoration,
        textButton: textButton,
        onPressed: onPressed ?? () => close(),
        label: label,
        textDescriptions: [TextDescription(text: message ?? "")],
        errorText: errorText,
      ),
    );
  }

  Future<T?> showGeneral<T>({
    bool barrierDismissible = false,
    int? errorCode,
    Widget? child,
    String textButton = "Tutup",
    Function()? onPressed,
    required String title,
    required String description,
  }) {
    DialogService.instance.close();
    return showGeneralDialog<T>(
      barrierDismissible: barrierDismissible,
      child: GeneralDialog(
        textButton: textButton,
        onPressed: onPressed ?? () => close(),
        label: title,
        textDescriptions: [TextDescription(text: description)],
      ),
    );
  }

  Future<T?> showNoInternetConnection<T>({
    int? errorCode,
    String label = "Tidak Ada Koneksi Internet",
    String? textDescriptions =
        "Pastikan anda mengaktifkan koneksi internet untuk menggunakan aplikasi.",
    String textButton = "Kembali",
    void Function()? onPressed,
  }) {
    DialogService.instance.close();
    return showGeneralDialog<T>(
      child: GeneralDialog(
        textButton: textButton,
        onPressed: onPressed != null
            ? () {
                DialogService.instance.close();
                onPressed();
              }
            : () => DialogService.instance.close(),
        label: label,
        textDescriptions: [
          TextDescription(
            text:
                "${FlavorServices.instance.flavor != Flavor.PRODUCTION && errorCode != null ? "[$errorCode] " : ""} $textDescriptions",
          )
        ],
      ),
    );
  }
}
