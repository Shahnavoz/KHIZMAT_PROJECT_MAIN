// To parse this JSON data, do
//
//     final uslugaSpecialization = uslugaSpecializationFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

UslugaSpecialization uslugaSpecializationFromJson(String str) =>
    UslugaSpecialization.fromJson(json.decode(str));

String uslugaSpecializationToJson(UslugaSpecialization data) =>
    json.encode(data.toJson());

class UslugaSpecialization {
  int statusCode;
  String statusMessage;
  Data data;

  UslugaSpecialization({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory UslugaSpecialization.fromJson(Map<String, dynamic> json) =>
      UslugaSpecialization(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "data": data.toJson(),
  };
}

class Data {
  List<MySpecialization> specializations;

  Data({required this.specializations});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    specializations: List<MySpecialization>.from(
      json["specializations"].map((x) => MySpecialization.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "specializations": List<dynamic>.from(
      specializations.map((x) => x.toJson()),
    ),
  };
}

class MySpecialization {
  int id;
  Description name;
  Description description;
  int position;

  MySpecialization({
    required this.id,
    required this.name,
    required this.description,
    required this.position,
  });

  factory MySpecialization.fromJson(Map<String, dynamic> json) => MySpecialization(
    id: json["id"],
    name: Description.fromJson(json["name"]),
    description: Description.fromJson(json["description"]),
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name.toJson(),
    "description": description.toJson(),
    "position": position,
  };
}

class Description {
  String? tj;
  String? ru;
  String? en;

  Description({required this.tj, required this.ru, required this.en});

  factory Description.fromJson(Map<String, dynamic> json) => Description(
    tj: json["tj"] ?? "",
    ru: json["ru"] ?? "",
    en: json["en"] ?? "",
  );

  Map<String, dynamic> toJson() => {"tj": tj, "ru": ru, "en": en};

  String getText(Locale locale) {
    switch (locale.languageCode) {
      case 'ru':
        return ru ?? en ?? tj ?? '';
      case 'en':
        return en ?? ru ?? tj ?? '';
      case 'tj':
      case 'fr':
        return tj ?? ru ?? en ?? '';
      default:
        return ru ?? en ?? tj ?? '';
    }
  }
}
