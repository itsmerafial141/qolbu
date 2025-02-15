// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

extension IntegerExtension on int {
  String get toRupiah {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(this);
  }

  String formatCurrency({String? symbol}) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: symbol ?? 'Rp ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(this);
  }

  String toDate({required String format}) {
    return DateFormat(format, 'id_ID').format(toDateTime);
  }

  DateTime get toDateTime {
    return DateTime.fromMillisecondsSinceEpoch(this);
  }
}
