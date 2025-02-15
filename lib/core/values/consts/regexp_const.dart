class AppRegExp {
  static RegExp onlyNumber = RegExp(r'^[0-9]+$');
  static RegExp onlyDecimal = RegExp(r'^\d+(\.\d+)?$');
  static RegExp transactionNumber = RegExp(r'^TR\d{11,}$');
  static RegExp onlyNumberAndChar = RegExp("[0-9a-zA-Z.]");
}
