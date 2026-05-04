// To parse this JSON data, do
//
//     final startDocumentModel = startDocumentModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

StartDocumentModel startDocumentModelFromJson(String str) =>
    StartDocumentModel.fromJson(json.decode(str));

String startDocumentModelToJson(StartDocumentModel data) =>
    json.encode(data.toJson());

class StartDocumentModel {
  int statusCode;
  String statusMessage;
  Data data;
  Message? message;

  StartDocumentModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
    this.message,
  });

  factory StartDocumentModel.fromJson(Map<String, dynamic> json) =>
      StartDocumentModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        data: Data.fromJson(json["data"]),
        message:
            json['message'] != null
                ? Message.fromJson(json['message'] as Map<String, dynamic>)
                : null,
      );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "data": data.toJson(),
    "message": message?.toJson(),
  };
}

class Data {
  int applicationId;
  int documentId;
  String applicationType;
  int lastStepId;
  bool isComplete;
  String status;
  List<Value> values;
  dynamic violations;

  Data({
    required this.applicationId,
    required this.documentId,
    required this.applicationType,
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
    lastStepId: json["last_step_id"],
    isComplete: json["is_complete"],
    status: json["status"],
    values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
    violations: json["violations"],
  );

  Map<String, dynamic> toJson() => {
    "application_id": applicationId,
    "document_id": documentId,
    "application_type": applicationType,
    "last_step_id": lastStepId,
    "is_complete": isComplete,
    "status": status,
    "values": List<dynamic>.from(values.map((x) => x.toJson())),
    "violations": violations,
  };
}

class Value {
  String key;
  String value;

  Value({required this.key, required this.value});

  factory Value.fromJson(Map<String, dynamic> json) =>
      Value(key: json["key"], value: json["value"]);

  Map<String, dynamic> toJson() => {"key": key, "value": value};
}

class Message {
  Title title;
  String type;

  Message({required this.title, required this.type});

  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(title: Title.fromJson(json["title"]), type: json["type"]);

  Map<String, dynamic> toJson() => {"title": title.toJson(), "type": type};
}

class Title {
  String tj;
  String ru;
  String en;

  Title({required this.tj, required this.ru, required this.en});

  factory Title.fromJson(Map<String, dynamic> json) =>
      Title(tj: json["tj"], ru: json["ru"], en: json["en"]);

  Map<String, dynamic> toJson() => {"tj": tj, "ru": ru, "en": en};

  String getText(Locale locale) {
    switch (locale.languageCode) {
      case "ru":
        return ru ?? en ?? tj ?? "";
      case "en":
        return en ?? ru ?? tj ?? "";
      case "tj":
      case "fr":
        return tj ?? ru ?? en ?? "";
      default:
        return ru ?? en ?? tj ?? "";
    }
  }
}
