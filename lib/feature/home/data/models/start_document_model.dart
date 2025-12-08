// To parse this JSON data, do
//
//     final startDocumentModel = startDocumentModelFromJson(jsonString);

import 'dart:convert';

StartDocumentModel startDocumentModelFromJson(String str) =>
    StartDocumentModel.fromJson(json.decode(str));

String startDocumentModelToJson(StartDocumentModel data) =>
    json.encode(data.toJson());

class StartDocumentModel {
  int statusCode;
  String statusMessage;
  Data data;
  dynamic message;

  StartDocumentModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
    required this.message,
  });

  factory StartDocumentModel.fromJson(Map<String, dynamic> json) =>
      StartDocumentModel(
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
