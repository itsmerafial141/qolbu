// ignore_for_file: constant_identifier_names

enum States {
  LOADING,
  EMPTY,
  ERROR,
  SUCCESS;
}

extension StatesExtension on States {
  bool get isLoading => this == States.LOADING;

  bool get isEmpty => this == States.EMPTY;

  bool get isError => this == States.ERROR;

  bool get isSuccess => this == States.SUCCESS;
}
