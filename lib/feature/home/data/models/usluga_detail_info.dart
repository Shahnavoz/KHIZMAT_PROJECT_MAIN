// To parse this JSON data, do
//
//     final uslugaDetailInfo = uslugaDetailInfoFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

UslugaDetailInfo uslugaDetailInfoFromJson(String str) =>
    UslugaDetailInfo.fromJson(json.decode(str));

String uslugaDetailInfoToJson(UslugaDetailInfo data) =>
    json.encode(data.toJson());

class UslugaDetailInfo {
  int statusCode;
  String statusMessage;
  Data data;

  UslugaDetailInfo({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory UslugaDetailInfo.fromJson(Map<String, dynamic> json) =>
      UslugaDetailInfo(
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
  Document document;
  int categoryId;
  dynamic categoryParentId;
  String? serviceCost;
  String? stateDuty;
  String? reRegistrationPrice;
  String? reviewFastPrice;
  bool reviewWeekDays;
  int? reviewTime;
  int? expiryDate;
  ApplicantType organization;
  ApplicantType organizationParent;
  List<String>? applicantTypes;
  List<String>? applicationTypes;
  String? documentLink;
  dynamic documentNumber;
  DateTime documentDate;
  List<dynamic>? additionalData;
  ApplicantType applicantType;
  bool usageFee;
  bool automaticGive;
  bool dynamicPrice;

  Data({
    required this.document,
    required this.categoryId,
    required this.categoryParentId,
    required this.serviceCost,
    required this.stateDuty,
    required this.reRegistrationPrice,
    required this.reviewFastPrice,
    required this.reviewWeekDays,
    required this.reviewTime,
    required this.expiryDate,
    required this.organization,
    required this.organizationParent,
    required this.applicantTypes,
    required this.applicationTypes,
    required this.documentLink,
    required this.documentNumber,
    required this.documentDate,
    required this.additionalData,
    required this.applicantType,
    required this.usageFee,
    required this.automaticGive,
    required this.dynamicPrice,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    document: Document.fromJson(json["document"]),
    categoryId: json["category_id"],
    categoryParentId: json["category_parent_id"],
    serviceCost: json["service_cost"] ?? "",
    stateDuty: json["state_duty"] ?? "",
    reRegistrationPrice: json["re_registration_price"] ?? "",
    reviewFastPrice: json["review_fast_price"] ?? "",
    reviewWeekDays: json["review_week_days"],
    reviewTime: json["review_time"] ?? 0,
    expiryDate: json["expiry_date"] ?? 0,
    organization: ApplicantType.fromJson(json["organization"]),
    organizationParent: ApplicantType.fromJson(json["organization_parent"]),
    applicantTypes:
        List<String>.from(json["applicant_types"].map((x) => x)) ?? [],
    applicationTypes:
        List<String>.from(json["applicationTypes"].map((x) => x)) ?? [],
    documentLink: json["document_link"] ?? "",
    documentNumber: json["document_number"],
    documentDate: DateTime.parse(json["document_date"]),
    additionalData:
        List<dynamic>.from(json["additional_data"].map((x) => x)) ?? [],
    applicantType: ApplicantType.fromJson(json["applicant_type"]),
    usageFee: json["usageFee"],
    automaticGive: json["automatic_give"],
    dynamicPrice: json["dynamic_price"],
  );

  Map<String, dynamic> toJson() => {
    "document": document.toJson(),
    "category_id": categoryId,
    "category_parent_id": categoryParentId,
    "service_cost": serviceCost,
    "state_duty": stateDuty,
    "re_registration_price": reRegistrationPrice,
    "review_fast_price": reviewFastPrice,
    "review_week_days": reviewWeekDays,
    "review_time": reviewTime,
    "expiry_date": expiryDate,
    "organization": organization.toJson(),
    "organization_parent": organizationParent.toJson(),
    "applicant_types": List<dynamic>.from(applicantTypes!.map((x) => x)),
    "applicationTypes": List<dynamic>.from(applicationTypes!.map((x) => x)),
    "document_link": documentLink,
    "document_number": documentNumber,
    "document_date": documentDate.toIso8601String(),
    "additional_data": List<dynamic>.from(additionalData!.map((x) => x)),
    "applicant_type": applicantType.toJson(),
    "usageFee": usageFee,
    "automatic_give": automaticGive,
    "dynamic_price": dynamicPrice,
  };
}

class ApplicantType {
  String? tj;
  String? ru;
  String? en;

  ApplicantType({required this.tj, required this.ru, required this.en});

  factory ApplicantType.fromJson(Map<String, dynamic> json) => ApplicantType(
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
        return ru ?? en ?? tj ?? "";
    }
  }
}

class Document {
  int id;
  ApplicantType title;
  String? type;
  ApplicantType typeTitle;
  String? icon;

  Document({
    required this.id,
    required this.title,
    required this.type,
    required this.typeTitle,
    required this.icon,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["id"],
    title: ApplicantType.fromJson(json["title"]),
    type: json["type"] ?? "",
    typeTitle: ApplicantType.fromJson(json["type_title"]),
    icon: json["icon"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title.toJson(),
    "type": type,
    "type_title": typeTitle.toJson(),
    "icon": icon,
  };
}
