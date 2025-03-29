// To parse this JSON data, do
//
//     final juzModel = juzModelFromJson(jsonString);

import 'dart:convert';

JuzModel juzModelFromJson(String str) => JuzModel.fromJson(json.decode(str));

String juzModelToJson(JuzModel data) => json.encode(data.toJson());

class JuzModel {
  int? number;
  List<Ayah>? ayahs;
  Map<String, Surah>? surahs;
  Edition? edition;

  JuzModel({
    this.number,
    this.ayahs,
    this.surahs,
    this.edition,
  });

  factory JuzModel.fromJson(Map<String, dynamic> json) => JuzModel(
        number: json["number"],
        ayahs: json["ayahs"] == null
            ? []
            : List<Ayah>.from(json["ayahs"]!.map((x) => Ayah.fromJson(x))),
        surahs:
            Map.from(json["surahs"]!).map((k, v) => MapEntry<String, Surah>(k, Surah.fromJson(v))),
        edition: json["edition"] == null ? null : Edition.fromJson(json["edition"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "ayahs": ayahs == null ? [] : List<dynamic>.from(ayahs!.map((x) => x.toJson())),
        "surahs": Map.from(surahs!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "edition": edition?.toJson(),
      };
}

class Ayah {
  int? number;
  String? text;
  Surah? surah;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  bool? sajda;

  Ayah({
    this.number,
    this.text,
    this.surah,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
        number: json["number"],
        text: json["text"],
        surah: json["surah"] == null ? null : Surah.fromJson(json["surah"]),
        numberInSurah: json["numberInSurah"],
        juz: json["juz"],
        manzil: json["manzil"],
        page: json["page"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: json["sajda"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "text": text,
        "surah": surah?.toJson(),
        "numberInSurah": numberInSurah,
        "juz": juz,
        "manzil": manzil,
        "page": page,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda,
      };
}

class Surah {
  int? number;
  Name? name;
  EnglishName? englishName;
  EnglishNameTranslation? englishNameTranslation;
  RevelationType? revelationType;
  int? numberOfAyahs;

  Surah({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.numberOfAyahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"],
        name: nameValues.map[json["name"]]!,
        englishName: englishNameValues.map[json["englishName"]]!,
        englishNameTranslation: englishNameTranslationValues.map[json["englishNameTranslation"]]!,
        revelationType: revelationTypeValues.map[json["revelationType"]]!,
        numberOfAyahs: json["numberOfAyahs"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": nameValues.reverse[name],
        "englishName": englishNameValues.reverse[englishName],
        "englishNameTranslation": englishNameTranslationValues.reverse[englishNameTranslation],
        "revelationType": revelationTypeValues.reverse[revelationType],
        "numberOfAyahs": numberOfAyahs,
      };
}

enum EnglishName { AL_BAQARA, AL_FAATIHA }

final englishNameValues =
    EnumValues({"Al-Baqara": EnglishName.AL_BAQARA, "Al-Faatiha": EnglishName.AL_FAATIHA});

enum EnglishNameTranslation { THE_COW, THE_OPENING }

final englishNameTranslationValues = EnumValues(
    {"The Cow": EnglishNameTranslation.THE_COW, "The Opening": EnglishNameTranslation.THE_OPENING});

enum Name { EMPTY, NAME }

final nameValues =
    EnumValues({"سُورَةُ ٱلْفَاتِحَةِ": Name.EMPTY, "سُورَةُ البَقَرَةِ": Name.NAME});

enum RevelationType { MECCAN, MEDINAN }

final revelationTypeValues =
    EnumValues({"Meccan": RevelationType.MECCAN, "Medinan": RevelationType.MEDINAN});

class Edition {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;
  String? direction;

  Edition({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
    this.direction,
  });

  factory Edition.fromJson(Map<String, dynamic> json) => Edition(
        identifier: json["identifier"],
        language: json["language"],
        name: json["name"],
        englishName: json["englishName"],
        format: json["format"],
        type: json["type"],
        direction: json["direction"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "language": language,
        "name": name,
        "englishName": englishName,
        "format": format,
        "type": type,
        "direction": direction,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
