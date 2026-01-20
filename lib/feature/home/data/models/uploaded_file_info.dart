// To parse this JSON data, do
//
//     final uploadedFileInfo = uploadedFileInfoFromJson(jsonString);

import 'dart:convert';

UploadedFileInfo uploadedFileInfoFromJson(String str) => UploadedFileInfo.fromJson(json.decode(str));

String uploadedFileInfoToJson(UploadedFileInfo data) => json.encode(data.toJson());

class UploadedFileInfo {
    int statusCode;
    String statusMessage;
    Data data;

    UploadedFileInfo({
        required this.statusCode,
        required this.statusMessage,
        required this.data,
    });

    factory UploadedFileInfo.fromJson(Map<String, dynamic> json) => UploadedFileInfo(
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
