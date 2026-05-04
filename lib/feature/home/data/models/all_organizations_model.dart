// To parse this JSON data, do
//
//     final allOrganizationsModel = allOrganizationsModelFromJson(jsonString);

import 'dart:convert';

AllOrganizationsModel allOrganizationsModelFromJson(String str) => AllOrganizationsModel.fromJson(json.decode(str));

String allOrganizationsModelToJson(AllOrganizationsModel data) => json.encode(data.toJson());

class AllOrganizationsModel {
    int statusCode;
    String statusMessage;
    List<Datum> data;

    AllOrganizationsModel({
        required this.statusCode,
        required this.statusMessage,
        required this.data,
    });

    factory AllOrganizationsModel.fromJson(Map<String, dynamic> json) => AllOrganizationsModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String nameEn;
    String nameTj;
    String nameRu;
    String addressTj;
    String addressRu;
    String addressEn;
    String directorTj;
    String directorRu;
    String directorEn;
    String directorPositionTj;
    String directorPositionRu;
    String directorPositionEn;
    int documentsCount;
    int active;
    bool publish;

    Datum({
        required this.id,
        required this.nameEn,
        required this.nameTj,
        required this.nameRu,
        required this.addressTj,
        required this.addressRu,
        required this.addressEn,
        required this.directorTj,
        required this.directorRu,
        required this.directorEn,
        required this.directorPositionTj,
        required this.directorPositionRu,
        required this.directorPositionEn,
        required this.documentsCount,
        required this.active,
        required this.publish,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nameEn: json["name_en"],
        nameTj: json["name_tj"],
        nameRu: json["name_ru"],
        addressTj: json["address_tj"],
        addressRu: json["address_ru"],
        addressEn: json["address_en"],
        directorTj: json["director_tj"],
        directorRu: json["director_ru"],
        directorEn: json["director_en"],
        directorPositionTj: json["director_position_tj"],
        directorPositionRu: json["director_position_ru"],
        directorPositionEn: json["director_position_en"],
        documentsCount: json["documents_count"],
        active: json["active"],
        publish: json["publish"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_tj": nameTj,
        "name_ru": nameRu,
        "address_tj": addressTj,
        "address_ru": addressRu,
        "address_en": addressEn,
        "director_tj": directorTj,
        "director_ru": directorRu,
        "director_en": directorEn,
        "director_position_tj": directorPositionTj,
        "director_position_ru": directorPositionRu,
        "director_position_en": directorPositionEn,
        "documents_count": documentsCount,
        "active": active,
        "publish": publish,
    };
}
