// ignore_for_file: constant_identifier_names

enum GrantType {
  PASSWORD(id: "password", name: "Password");

  final String id;
  final String name;

  const GrantType({required this.id, required this.name});

  bool get isPassword => this == GrantType.PASSWORD;
}
