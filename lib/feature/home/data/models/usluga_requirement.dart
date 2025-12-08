// To parse this JSON data, do
//
//     final UslugaRequirement = UslugaRequirementFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

UslugaRequirement UslugaRequirementFromJson(String str) =>
    UslugaRequirement.fromJson(json.decode(str));

String UslugaRequirementToJson(UslugaRequirement data) =>
    json.encode(data.toJson());

class UslugaRequirement {
  int statusCode;
  String statusMessage;
  Data data;

  UslugaRequirement({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory UslugaRequirement.fromJson(Map<String, dynamic> json) =>
      UslugaRequirement(
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
  List<Requirement> requirements;

  Data({required this.requirements});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    requirements: List<Requirement>.from(
      json["requirements"].map((x) => Requirement.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "requirements": List<dynamic>.from(requirements!.map((x) => x.toJson())),
  };
}

class Requirement {
  int? id;
  Content content;
  int? position;

  Requirement({
    required this.id,
    required this.content,
    required this.position,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
    id: json["id"] ?? 1,
    content: Content.fromJson(json["content"]),
    position: json["position"] ?? 1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content.toJson(),
    "position": position,
  };
}

class Content {
  String? tj;
  String? ru;
  String? en;

  Content({required this.tj, required this.ru, required this.en});

  factory Content.fromJson(Map<String, dynamic> json) =>
      Content(tj: json["tj"], ru: json["ru"], en: json["en"]);

  Map<String, dynamic> toJson() => {"tj": tj, "ru": ru, "en": en};
  String getText(Locale locale) {
    switch (locale.languageCode) {
      case 'ru':
        return ru ?? "";
      case 'en':
        return en ?? "";
      case 'tj':
      case 'fr':
        return tj ?? "";
      default:
        return ru ?? "";
    }
  }
}
