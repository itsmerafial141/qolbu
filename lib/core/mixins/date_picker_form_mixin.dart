import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qolbu/core/extensions/datetime_extension.dart';
import 'package:qolbu/services/dialog_service.dart';

mixin DatePickerFormMixin {
  final Rxn<DateTimeRange> date = Rxn();
  final TextEditingController tanggalController = TextEditingController();

  Future<void> onTapDatePicker() async {
    await DialogService.instance.showDialogRangeDatePicker(
      Get.context!,
      onDatePicker: (dateRange) {
        date.value = dateRange;
        tanggalController.text =
            "${dateRange.start.formatDate(format: "dd/MM/yy")} - ${dateRange.end.formatDate(format: "dd/MM/yy")}";
      },
    );
  }
}
