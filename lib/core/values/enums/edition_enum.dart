enum EditionEnum {
  EN_TRANSLITERATION(id: "en.transliteration", name: "Latin"),
  QURAN_UTHMANI(id: "quran-uthmani", name: "Arabic"),
  ID_MUNTAKHAB(id: "id.muntakhab", name: "Indonesia"),
  ID_JALALAYN(id: "id.jalalayn", name: "Indonesia");

  final String id;
  final String name;

  const EditionEnum({required this.id, required this.name});
}
