import 'package:get/get.dart';

class FormValidator {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) return "Wajib diisi";
    if (!value.isEmail) return "Format email tidak sesuai.";
    return null;
  }

  static String? mustFilledValidator(String? value) {
    if (value!.isEmpty) return "Wajib diisi";
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value!.isEmpty) return "Wajib diisi";
    if (!value.isPhoneNumber) return "Format no telepon tidak sesuai!";
    return null;
  }

  static String? confirmPasswordValidator(String? value1, String? value2) {
    if (value1!.isEmpty) {
      return "Konfirmasi password wajib diisi";
    }
    if (value1 != value2) {
      return "Konfirmasi password tidak sesuai";
    }
    return null;
  }
}
