// To parse this JSON data, do
//
//     final stepRequirementModel = stepRequirementModelFromJson(jsonString);

import 'dart:convert';

StepRequirementModel stepRequirementModelFromJson(String str) =>
    StepRequirementModel.fromJson(json.decode(str));

String stepRequirementModelToJson(StepRequirementModel data) =>
    json.encode(data.toJson());

class StepRequirementModel {
  int statusCode;
  String statusMessage;
  Data data;

  StepRequirementModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory StepRequirementModel.fromJson(Map<String, dynamic> json) =>
      StepRequirementModel(
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
    "requirements": List<dynamic>.from(requirements.map((x) => x.toJson())),
  };
}

class Requirement {
  int id;
  Content content;
  int? position;

  Requirement({
    required this.id,
    required this.content,
    required this.position,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
    id: json["id"],
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
  String tj;
  String ru;
  String en;

  Content({required this.tj, required this.ru, required this.en});

  factory Content.fromJson(Map<String, dynamic> json) =>
      Content(tj: json["tj"], ru: json["ru"], en: json["en"]);

  Map<String, dynamic> toJson() => {"tj": tj, "ru": ru, "en": en};
}
