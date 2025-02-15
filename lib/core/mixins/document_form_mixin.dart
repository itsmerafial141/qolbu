import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qolbu/app/data/models/document_file_model.dart';
import 'package:qolbu/app/widgets/dialog/double_button_dialog_widget.dart';
import 'package:qolbu/core/extensions/file_extension.dart';
import 'package:qolbu/core/themes/color_swatch.dart';
import 'package:qolbu/core/values/consts/svg_asset_const.dart';
import 'package:qolbu/services/dialog_service.dart';

mixin DocumentFormMixin {
  final TextEditingController documentController = TextEditingController();
  final Rxn<DocumentFile> document = Rxn();
  Future<void> onTapUploadDocument({FileType type = FileType.any}) async {
    try {
      DialogService.showLoading();
      var file = await FilePicker.platform.pickFiles(type: type);
      if (file == null || file.files.isEmpty) {
        DialogService.closeLoading();
        return;
      }
      documentController.text = file.names.firstOrNull ?? "-";
      var documentTypes = documentController.text.split(".");
      var documentType = documentTypes.last;
      var documentEncode = base64Encode(file.xFiles.first.file.readAsBytesSync());
      document.value = DocumentFile.request(
        name: documentController.text,
        file: documentEncode,
        fileType: documentType,
      );
      DialogService.closeLoading();
    } catch (e, s) {
      DialogService.closeLoading();
      DialogService.showProblem(message: "Terjadi kesalahan");
      e.printError(info: "UPLOAD FILE ERROR CONTROLLER");
      s.printError(info: "UPLOAD FILE STACK TRACE CONTROLLER");
    }
  }

  Future<void> onTapDeleteDocument() async {
    await DialogService.showGeneralDialog(
      child: DoubleButtonDialog(
        negativeTextButton: "Tidak",
        positiveTextButton: "Hapus",
        icon: AppSvg.icDelete,
        label: "Apakah anda takin ingin menghapus gambar ini?",
        iconDecoration: IconDecoration(
          forgroundColor: AppColorSwatch.DANGER,
          backgroundColor: AppColorSwatch.DANGER.shade200,
        ),
        onPressedPositive: () {
          documentController.clear();
          document.value = null;
          DialogService.close();
        },
      ),
    );
  }
}
