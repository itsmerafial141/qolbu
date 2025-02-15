// ignore_for_file: constant_identifier_names

enum ResponseCode {
  SUCCESS(code: 200, message: "Berhasil"),
  ERROR(code: 400, message: "Server sedang bermasalah"),
  NOT_FOUND(code: 404, message: "Data tidak ditemukan"),
  EXPIRED(code: 401, message: "Sesi anda telah habis"),
  OTHER(code: 999, message: "Terjadi Kesalahan");

  final int code;
  final String message;

  const ResponseCode({
    required this.code,
    required this.message,
  });

  bool get isSuccess => this == ResponseCode.SUCCESS;
  bool get isError => this == ResponseCode.ERROR;
  bool get isNotFound => this == ResponseCode.NOT_FOUND;
  bool get isExpired => this == ResponseCode.EXPIRED;
  bool get isOther => this == ResponseCode.OTHER;
}
