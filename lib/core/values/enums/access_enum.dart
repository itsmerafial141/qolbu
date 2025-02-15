// ignore_for_file: constant_identifier_names

enum Access {
  CREATE,
  READ,
  UPDATE,
  DELETE;

  bool get isCreate => this == Access.CREATE;
  bool get isRead => this == Access.READ;
  bool get isUpdate => this == Access.UPDATE;
  bool get isDelete => this == Access.DELETE;

  int get code {
    switch (this) {
      case Access.CREATE:
        return 0;
      case Access.READ:
        return 1;
      case Access.UPDATE:
        return 2;
      default:
        return 3;
    }
  }
}
