// ignore_for_file: constant_identifier_names

enum BusinessLocation {
  IN(
    id: 'in-city',
    name: "Dinas dalam Kota",
    radioLabel: "Dalam Kota",
  ),
  OUT(
    id: 'out-city',
    name: "Dinas luar Kota",
    radioLabel: "Luar Kota",
  );

  final String id;
  final String name;
  final String radioLabel;

  const BusinessLocation({
    required this.id,
    required this.name,
    required this.radioLabel,
  });

  bool get isIn => this == BusinessLocation.IN;
  bool get isOut => this == BusinessLocation.OUT;
}
