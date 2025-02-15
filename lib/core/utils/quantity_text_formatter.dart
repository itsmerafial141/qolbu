import 'package:flutter/services.dart';
import 'package:qolbu/core/extensions/string_extension.dart';

class QuantityTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return TextEditingValue.empty;
    if (newValue.text[0].toInt == 0) return TextEditingValue.empty;
    return TextEditingValue(
      text: newValue.text,
      selection: newValue.selection,
    );
  }
}
