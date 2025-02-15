// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toTimeAgo({
    String? locale = "id_ID",
    String? format = "dd MMMM yyyy",
  }) {
    // initializeTimeZones();
    // var now = TZDateTime.now(getLocation('Asia/Jakarta'));
    // Duration diff = now.difference(this);
    // if (diff.inDays > 7) {
    //   return DateFormat(format, locale).format(this);
    // }
    // if (diff.inDays > 365) {
    //   return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "tahun" : "tahun yang lalu"}";
    // } else if (diff.inDays > 30) {
    //   return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "bulan" : "bulan yang lalu"}";
    // } else if (diff.inDays > 7) {
    //   return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "minggu" : "minggu yang lalu"}";
    // } else if (diff.inDays > 0) {
    //   return "${diff.inDays} ${diff.inDays == 1 ? "hari" : "hari yang lalu"}";
    // } else if (diff.inHours > 0) {
    //   return "${diff.inHours} ${diff.inHours == 1 ? "jam" : "jam yang lalu"}";
    // } else if (diff.inMinutes > 0) {
    //   return "${diff.inMinutes} ${diff.inMinutes == 1 ? 'menit' : 'menit yang lalu'}";
    // } else {
    //   return "baru saja";
    // }
    return "";
  }

  String formatDate({String? format = 'yyyy-MM-dd hh:mm:ss', String? locale = 'ID'}) {
    return DateFormat(format, locale).format(this);
  }
}
