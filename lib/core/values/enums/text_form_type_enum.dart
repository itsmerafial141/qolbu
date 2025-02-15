// ignore_for_file: constant_identifier_names

enum TextFormType {
  FORM,
  RADIO;

  int get code {
    switch (this) {
      case TextFormType.FORM:
        return 1;
      default:
        return 2;
    }
  }
}
