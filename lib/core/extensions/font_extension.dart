import 'package:flutter/material.dart';

extension FontExtension on TextStyle {
  TextStyle fh(double height) {
    if (fontSize == null) return this;
    return copyWith(height: height / fontSize!);
  }
}
