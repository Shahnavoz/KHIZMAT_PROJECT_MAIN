// To parse this JSON data, do
//
//     final resumeModel = resumeModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

ResumeModel resumeModelFromJson(String str) =>
    ResumeModel.fromJson(json.decode(str));

String resumeModelToJson(ResumeModel data) => json.encode(data.toJson());

class ResumeModel {
  int statusCode;
  String statusMessage;
  Data data;
  dynamic message;

  ResumeModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
    required this.message,
  });

  factory ResumeModel.fromJson(Map<String, dynamic> json) => ResumeModel(
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  int applicationId;
  int documentId;
  String applicationType;
  String applicantType;
  int lastStepId;
  bool isComplete;
  String status;
  List<Value> values;
  List<dynamic> violations;

  Data({
    required this.applicationId,
    required this.documentId,
    required this.applicationType,
    required this.applicantType,
    required this.lastStepId,
    required this.isComplete,
    required this.status,
    required this.values,
    required this.violations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    applicationId: json["application_id"],
    documentId: json["document_id"],
    applicationType: json["application_type"],
    applicantType: json["applicant_type"],
    lastStepId: json["last_step_id"],
    isComplete: json["is_complete"],
    status: json["status"],
    values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
    violations: List<dynamic>.from(json["violations"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "application_id": applicationId,
    "document_id": documentId,
    "application_type": applicationType,
    "applicant_type": applicantType,
    "last_step_id": lastStepId,
    "is_complete": isComplete,
    "status": status,
    "values": List<dynamic>.from(values.map((x) => x.toJson())),
    "violations": List<dynamic>.from(violations.map((x) => x)),
  };
}

class Value {
  String key;
  String value;
  Option? option;

  Value({required this.key, required this.value, this.option});

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    key: json["key"],
    value: json["value"],
    option: json["option"] == null ? null : Option.fromJson(json["option"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
    "option": option?.toJson(),
  };
}

class Option {
  String? tj;
  String? ru;
  String? en;

  Option({required this.tj, required this.ru, required this.en});

  factory Option.fromJson(Map<String, dynamic> json) =>
      Option(tj: json["tj"], ru: json["ru"], en: json["en"]);

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
