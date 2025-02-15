// ignore_for_file: constant_identifier_names

enum Method {
  POST,
  GET,
  PUT,
  DELETE;

  String get name {
    switch (this) {
      case Method.POST:
        return "post";
      case Method.GET:
        return "get";
      case Method.PUT:
        return "put";
      default:
        return "delete";
    }
  }
}
