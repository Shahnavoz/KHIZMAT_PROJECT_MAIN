// To parse this JSON data, do
//
//     final eachOrganizationsServicesModel = eachOrganizationsServicesModelFromJson(jsonString);

import 'dart:convert';

EachOrganizationsServicesModel eachOrganizationsServicesModelFromJson(String str) => EachOrganizationsServicesModel.fromJson(json.decode(str));

String eachOrganizationsServicesModelToJson(EachOrganizationsServicesModel data) => json.encode(data.toJson());

class EachOrganizationsServicesModel {
    int statusCode;
    String statusMessage;
    Data data;

    EachOrganizationsServicesModel({
        required this.statusCode,
        required this.statusMessage,
        required this.data,
    });

    factory EachOrganizationsServicesModel.fromJson(Map<String, dynamic> json) => EachOrganizationsServicesModel(
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
    int id;
    dynamic avgRate;
    dynamic countRates;
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
    int active;
    bool publish;
    dynamic totalApplicationCount;
    dynamic reviewApplicationsCount;
    dynamic rejectedApplicationsCount;
    dynamic confirmedApplicationsCount;
    int documentsCount;
    List<Document> documents;
    dynamic applicationsDaily;

    Data({
        required this.id,
        required this.avgRate,
        required this.countRates,
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
        required this.active,
        required this.publish,
        required this.totalApplicationCount,
        required this.reviewApplicationsCount,
        required this.rejectedApplicationsCount,
        required this.confirmedApplicationsCount,
        required this.documentsCount,
        required this.documents,
        required this.applicationsDaily,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        avgRate: json["avg_rate"],
        countRates: json["count_rates"],
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
        active: json["active"],
        publish: json["publish"],
        totalApplicationCount: json["total_application_count"],
        reviewApplicationsCount: json["review_applications_count"],
        rejectedApplicationsCount: json["rejected_applications_count"],
        confirmedApplicationsCount: json["confirmed_applications_count"],
        documentsCount: json["documents_count"],
        documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
        applicationsDaily: json["applications_daily"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "avg_rate": avgRate,
        "count_rates": countRates,
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
        "active": active,
        "publish": publish,
        "total_application_count": totalApplicationCount,
        "review_applications_count": reviewApplicationsCount,
        "rejected_applications_count": rejectedApplicationsCount,
        "confirmed_applications_count": confirmedApplicationsCount,
        "documents_count": documentsCount,
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "applications_daily": applicationsDaily,
    };
}

class Document {
    int id;
    String type;
    String nameTj;
    String nameRu;
    String nameEn;
    int categoryId;
    String icon;

    Document({
        required this.id,
        required this.type,
        required this.nameTj,
        required this.nameRu,
        required this.nameEn,
        required this.categoryId,
        required this.icon,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        type: json["type"],
        nameTj: json["name_tj"],
        nameRu: json["name_ru"],
        nameEn: json["name_en"],
        categoryId: json["category_id"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name_tj": nameTj,
        "name_ru": nameRu,
        "name_en": nameEn,
        "category_id": categoryId,
        "icon": icon,
    };
}
