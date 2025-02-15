// ignore_for_file: constant_identifier_names

enum AbsenceType {
  CHECK_IN(id: "regular-checkin", name: "Check In"),
  CHECK_OUT(id: "regular-checkout", name: "Check Out");

  final String id;
  final String name;

  const AbsenceType({required this.id, required this.name});

  bool get isCheckIn => this == AbsenceType.CHECK_IN;
  bool get isCheckOut => this == AbsenceType.CHECK_OUT;
}
