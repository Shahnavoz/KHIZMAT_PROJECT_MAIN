// To parse this JSON data, do
//
//     final uploadedFileModel = uploadedFileModelFromJson(jsonString);

import 'dart:convert';

UploadedFileModel uploadedFileModelFromJson(String str) =>
    UploadedFileModel.fromJson(json.decode(str));

String uploadedFileModelToJson(UploadedFileModel data) =>
    json.encode(data.toJson());

class UploadedFileModel {
  int statusCode;
  String statusMessage;
  Data data;

  UploadedFileModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory UploadedFileModel.fromJson(Map<String, dynamic> json) =>
      UploadedFileModel(
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
  int fileId;
  String name;
  String extension;
  int size;
  String downloadUri;

  Data({
    required this.fileId,
    required this.name,
    required this.extension,
    required this.size,
    required this.downloadUri,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    fileId: json["fileId"],
    name: json["name"],
    extension: json["extension"],
    size: json["size"],
    downloadUri: json["download_uri"],
  );

  Map<String, dynamic> toJson() => {
    "fileId": fileId,
    "name": name,
    "extension": extension,
    "size": size,
    "download_uri": downloadUri,
  };
}
