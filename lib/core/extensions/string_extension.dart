// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:qolbu/core/extensions/datetime_extension.dart';

extension StringExtension on String {
  bool get isTrue => this == "1";
  bool get isFalse => this == "0";

  int get toInt {
    if (isEmpty) return 0;
    return int.parse(this);
  }

  double get toDouble {
    try {
      return double.parse(this);
    } catch (e) {
      return double.tryParse(this)!;
    }
  }

  String formatDate({String? format = 'dd MMMM yyyy', String? locale = 'ID'}) {
    var date = DateFormat('yyyy-MM-dd hh:mm:ss', locale).parse(this);
    return date.formatDate(format: format, locale: locale);
  }

  DateTime? get toDate {
    try {
      return DateFormat("yyyy-MM-dd hh:mm:ss").parse(this);
    } catch (e) {
      return null;
    }
  }

  String get fileType {
    if (isEmpty) return '.jpg';
    return ".${split(".").last}";
  }
}
