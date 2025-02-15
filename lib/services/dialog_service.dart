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
import 'package:qolbu/services/dio/dio_service.dart';
import 'package:qolbu/services/flavor_service.dart';

class DialogService extends DioService {
  static void closeLoading() {
    close();
  }

  static void close() {
    if (Get.isSnackbarOpen) Get.close(1);
    if (Get.isDialogOpen ?? false) Get.back();
  }

  static showDialogDatePicker(
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

  static Future showDialogRangeDatePicker(
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

      // selectableDayPredicate: (dateTime) {
      //   // Disable 25th Feb 2023
      //   if (dateTime == DateTime(2023, 2, 25)) {
      //     return false;
      //   } else {
      //     return true;
      //   }
      // },
    );

    // var datetime = await showDateRangePicker(
    //   context: context,
    //   initialDateRange: DateTimeRange(
    //     start: DateTime.now(),
    //     end: DateTime.now().add(const Duration(days: 1)),
    //   ),
    //   firstDate: DateTime.now().subtract(const Duration(days: 36500)),
    //   lastDate: DateTime.now().add(const Duration(days: 36500)),
    //   confirmText: "Simpan",
    //   cancelText: "Batal",
    //   locale: Get.locale,
    //   builder: (context, child) {
    //     return Theme(
    //       data: Theme.of(context).copyWith(
    //         appBarTheme: Theme.of(context).appBarTheme.copyWith(
    //               backgroundColor: AppColorSwatch.PRIMARY,
    //               iconTheme: Theme.of(context).appBarTheme.iconTheme!.copyWith(color: Colors.white),
    //             ),
    //         colorScheme: const ColorScheme.light(
    //           onPrimary: Colors.white,
    //           primary: AppColorSwatch.PRIMARY,
    //         ),
    //       ),
    //       child: child!,
    //     );
    //   },
    // );

    if (dateTimeList == null) return;
    var datetime = DateTimeRange(start: dateTimeList.first, end: dateTimeList.last);
    onDatePicker(datetime);
  }

  static showLoading({
    bool barrierDismissible = false,
  }) {
    close();
    Get.dialog(
      AppLoading(barrierDismissible: barrierDismissible),
      barrierDismissible: barrierDismissible,
      transitionCurve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
      barrierColor: Colors.black26,
    );
  }

  static Future showGeneralDialog({
    bool barrierDismissible = false,
    Widget? child,
  }) async {
    close();
    await Get.dialog(
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

  static showProblem({
    void Function()? onPressed,
    String textButton = "Kembali",
    String icon = AppSvg.icAlert,
    String label = "Terjadi Kesalahan",
    String? errorText,
    String? message,
    IconDecoration? iconDecoration,
    bool barrierDismissible = false,
  }) {
    DialogService.closeLoading();
    showGeneralDialog(
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

  static showGeneral({
    bool barrierDismissible = false,
    int? errorCode,
    Widget? child,
    String textButton = "Tutup",
    Function()? onPressed,
    required String title,
    required String description,
  }) {
    DialogService.closeLoading();
    showGeneralDialog(
      barrierDismissible: barrierDismissible,
      child: GeneralDialog(
        textButton: textButton,
        onPressed: onPressed ?? () => close(),
        label: title,
        textDescriptions: [TextDescription(text: description)],
      ),
    );
  }

  static showNoInternetConnection({
    int? errorCode,
    String label = "Tidak Ada Koneksi Internet",
    String? textDescriptions =
        "Pastikan anda mengaktifkan koneksi internet untuk menggunakan aplikasi.",
    String textButton = "Kembali",
    Function()? onPressed,
  }) {
    DialogService.closeLoading();
    showGeneralDialog(
      child: GeneralDialog(
        textButton: textButton,
        onPressed: onPressed != null
            ? () {
                close();
                onPressed();
              }
            : () => close(),
        label: label,
        textDescriptions: [
          TextDescription(
              text:
                  "${FlavorServices.flavor != Flavor.PRODUCTION && errorCode != null ? "[$errorCode] " : ""} $textDescriptions")
        ],
      ),
    );
  }
}
