// To parse this JSON data, do
//
//     final myApplicationsModel = myApplicationsModelFromJson(jsonString);

import 'dart:convert';

MyApplicationsModel myApplicationsModelFromJson(String str) =>
    MyApplicationsModel.fromJson(json.decode(str));

String myApplicationsModelToJson(MyApplicationsModel data) =>
    json.encode(data.toJson());

class MyApplicationsModel {
  int statusCode;
  String statusMessage;
  Data data;

  MyApplicationsModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory MyApplicationsModel.fromJson(Map<String, dynamic> json) =>
      MyApplicationsModel(
        statusCode: (json["status_code"] as num?)?.toInt() ?? 0,
        statusMessage: json["status_message"] as String? ?? '',
        data: Data.fromJson(json["data"] as Map<String, dynamic>? ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "data": data.toJson(),
      };
}

class Data {
  List<ApplicationList> applicationList;
  dynamic statistics;
  dynamic statisticsSubProcesses;
  dynamic statisticsStatuses;
  int totalItems;
  int totalPages;
  int currentPage;

  Data({
    required this.applicationList,
    required this.statistics,
    required this.statisticsSubProcesses,
    required this.statisticsStatuses,
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        applicationList: (json["application_list"] as List<dynamic>? ?? [])
            .map((x) => ApplicationList.fromJson(x as Map<String, dynamic>? ?? {}))
            .toList(),
        statistics: json["statistics"],
        statisticsSubProcesses: json["statistics_sub_processes"],
        statisticsStatuses: json["statistics_statuses"],
        totalItems: (json["totalItems"] as num?)?.toInt() ?? 0,
        totalPages: (json["totalPages"] as num?)?.toInt() ?? 0,
        currentPage: (json["currentPage"] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "application_list": applicationList.map((x) => x.toJson()).toList(),
        "statistics": statistics,
        "statistics_sub_processes": statisticsSubProcesses,
        "statistics_statuses": statisticsStatuses,
        "totalItems": totalItems,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
}

class ApplicationList {
  int id;
  dynamic subId;
  Document document;
  Category category;
  String documentType;
  Document type;
  ApplicationType applicationType;
  Status status;
  Status reviewStatus;
  Step step;
  bool reApplication;
  CabinetType? cabinetType;         
  ApplicantName? applicantName;      
  String applicantTin;
  String registrationDate;
  String reviewExpiry;
  String correctionExpiry;
  String paymentExpiry;
  String? registrationNumber;
  CreatedBy? createdBy;              

  ApplicationList({
    required this.id,
    required this.subId,
    required this.document,
    required this.category,
    required this.documentType,
    required this.type,
    required this.applicationType,
    required this.status,
    required this.reviewStatus,
    required this.step,
    required this.reApplication,
    this.cabinetType,
    this.applicantName,
    required this.applicantTin,
    required this.registrationDate,
    required this.reviewExpiry,
    required this.correctionExpiry,
    required this.paymentExpiry,
    this.registrationNumber,
    this.createdBy,
  });

  factory ApplicationList.fromJson(Map<String, dynamic> json) => ApplicationList(
        id: (json["id"] as num?)?.toInt() ?? 0,
        subId: json["sub_id"],
        document: Document.fromJson(json["document"] as Map<String, dynamic>? ?? {}),
        category: Category.fromJson(json["category"] as Map<String, dynamic>? ?? {}),
        documentType: json["document_type"] as String? ?? '',
        type: Document.fromJson(json["type"] as Map<String, dynamic>? ?? {}),
        applicationType: ApplicationType.fromJson(json["application_type"] as Map<String, dynamic>? ?? {}),
        status: Status.fromJson(json["status"] as Map<String, dynamic>? ?? {}),
        reviewStatus: Status.fromJson(json["review_status"] as Map<String, dynamic>? ?? {}),
        step: Step.fromJson(json["step"] as Map<String, dynamic>? ?? {}),
        reApplication: json["re_application"] as bool? ?? false,
        cabinetType: cabinetTypeValues.map[json["cabinet_type"] as String?],
        applicantName: applicantNameValues.map[json["applicant_name"] as String?],
        applicantTin: json["applicant_tin"] as String? ?? '',
        registrationDate: json["registration_date"] as String? ?? '',
        reviewExpiry: json["review_expiry"] as String? ?? '',
        correctionExpiry: json["correction_expiry"] as String? ?? '',
        paymentExpiry: json["payment_expiry"] as String? ?? '',
        registrationNumber: json["registration_number"] as String?,
        createdBy: createdByValues.map[json["created_by"] as String?],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sub_id": subId,
        "document": document.toJson(),
        "category": category.toJson(),
        "document_type": documentType,
        "type": type.toJson(),
        "application_type": applicationType.toJson(),
        "status": status.toJson(),
        "review_status": reviewStatus.toJson(),
        "step": step.toJson(),
        "re_application": reApplication,
        "cabinet_type": cabinetType != null ? cabinetTypeValues.reverse[cabinetType] : null,
        "applicant_name": applicantName != null ? applicantNameValues.reverse[applicantName] : null,
        "applicant_tin": applicantTin,
        "registration_date": registrationDate,
        "review_expiry": reviewExpiry,
        "correction_expiry": correctionExpiry,
        "payment_expiry": paymentExpiry,
        "registration_number": registrationNumber,
        "created_by": createdBy != null ? createdByValues.reverse[createdBy] : null,
      };
}

enum ApplicantName { empty, unknown }

final applicantNameValues = EnumValues({
  "Тестов Тест Тестович": ApplicantName.empty
});

class ApplicationType {
  Key? key;
  Document title;

  ApplicationType({this.key, required this.title});

  factory ApplicationType.fromJson(Map<String, dynamic> json) => ApplicationType(
        key: keyValues.map[json["key"] as String?],
        title: Document.fromJson(json["title"] as Map<String, dynamic>? ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "key": key != null ? keyValues.reverse[key] : null,
        "title": title.toJson(),
      };
}

enum Key { registration, unknown }

final keyValues = EnumValues({
  "REGISTRATION": Key.registration,
});

class Document {
  String tj;
  String ru;
  String en;

  Document({
    this.tj = '',
    this.ru = '',
    this.en = '',
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        tj: json["tj"] as String? ?? '',
        ru: json["ru"] as String? ?? '',
        en: json["en"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "tj": tj,
        "ru": ru,
        "en": en,
      };
}

enum CabinetType { frontOffice, unknown }

final cabinetTypeValues = EnumValues({
  "FRONT_OFFICE": CabinetType.frontOffice,
});

class Category {
  Document title;
  String iconId;
  dynamic gradientStartColor;
  dynamic gradientEndColor;

  Category({
    required this.title,
    this.iconId = '',
    this.gradientStartColor,
    this.gradientEndColor,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: Document.fromJson(json["title"] as Map<String, dynamic>? ?? {}),
        iconId: json["icon_id"] as String? ?? '',
        gradientStartColor: json["gradient_start_color"],
        gradientEndColor: json["gradient_end_color"],
      );

  Map<String, dynamic> toJson() => {
        "title": title.toJson(),
        "icon_id": iconId,
        "gradient_start_color": gradientStartColor,
        "gradient_end_color": gradientEndColor,
      };
}

enum CreatedBy { empty, unknown }

final createdByValues = EnumValues({
  "Тестов Тест": CreatedBy.empty,
});

class Status {
  String key;
  Document title;
  BackgroundColor? backgroundColor;
  Can? can;

  Status({
    this.key = '',
    required this.title,
    this.backgroundColor,
    this.can,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        key: json["key"] as String? ?? '',
        title: Document.fromJson(json["title"] as Map<String, dynamic>? ?? {}),
        backgroundColor: backgroundColorValues.map[json["background_color"] as String?],
        can: canValues.map[json["can"] as String?],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "title": title.toJson(),
        "background_color": backgroundColor != null ? backgroundColorValues.reverse[backgroundColor] : null,
        "can": can != null ? canValues.reverse[can] : null,
      };
}

enum BackgroundColor { ffad33, ffffff, the3Ed857, unknown }

final backgroundColorValues = EnumValues({
  "#FFAD33": BackgroundColor.ffad33,
  "#FFFFFF": BackgroundColor.ffffff,
  "#3ED857": BackgroundColor.the3Ed857,
});

enum Can { edit, view, unknown }

final canValues = EnumValues({
  "edit": Can.edit,
  "view": Can.view,
});

class Step {
  Document title;
  int position;
  int count;

  Step({
    required this.title,
    this.position = 0,
    this.count = 0,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        title: Document.fromJson(json["title"] as Map<String, dynamic>? ?? {}),
        position: (json["position"] as num?)?.toInt() ?? 0,
        count: (json["count"] as num?)?.toInt() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "title": title.toJson(),
        "position": position,
        "count": count,
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