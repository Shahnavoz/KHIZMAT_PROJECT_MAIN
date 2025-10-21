// To parse this JSON data, do
//
//     final subcategorySpezializationByDocumentIdModel = subcategorySpezializationByDocumentIdModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

SubcategorySpezializationByDocumentIdModel
subcategorySpezializationByDocumentIdModelFromJson(String str) =>
    SubcategorySpezializationByDocumentIdModel.fromJson(json.decode(str));

String subcategorySpezializationByDocumentIdModelToJson(
  SubcategorySpezializationByDocumentIdModel data,
) => json.encode(data.toJson());

class SubcategorySpezializationByDocumentIdModel {
  int statusCode;
  String statusMessage;
  Data data;

  SubcategorySpezializationByDocumentIdModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory SubcategorySpezializationByDocumentIdModel.fromJson(
    Map<String, dynamic> json,
  ) => SubcategorySpezializationByDocumentIdModel(
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
  List<Specialization> specializations;

  Data({required this.specializations});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    specializations: List<Specialization>.from(
      json["specializations"].map((x) => Specialization.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "specializations": List<dynamic>.from(
      specializations.map((x) => x.toJson()),
    ),
  };
}

class Specialization {
  int? id;
  Description name;
  Description description;
  int position;

  Specialization({
    required this.id,
    required this.name,
    required this.description,
    required this.position,
  });

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
    id: json["id"] ?? 1,
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
    tj: json["tj"] ?? '',
    ru: json["ru"] ?? '',
    en: json["en"] ?? '',
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
