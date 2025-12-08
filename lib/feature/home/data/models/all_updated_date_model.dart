// To parse this JSON data, do
//
//     final allUpdatedDateModel = allUpdatedDateModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

AllUpdatedDateModel allUpdatedDateModelFromJson(String str) =>
    AllUpdatedDateModel.fromJson(json.decode(str));

String allUpdatedDateModelToJson(AllUpdatedDateModel data) =>
    json.encode(data.toJson());

class AllUpdatedDateModel { 
  int statusCode;
  String statusMessage;
  Data data;

  AllUpdatedDateModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory AllUpdatedDateModel.fromJson(Map<String, dynamic> json) =>
      AllUpdatedDateModel(
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
  int updatedDate;
  List<CategoryElement> categories;
  List<UpdatedDateDocument> documents;

  Data({
    required this.updatedDate,
    required this.categories,
    required this.documents,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    updatedDate: json["updated_date"],
    categories: List<CategoryElement>.from(
      json["categories"].map((x) => CategoryElement.fromJson(x)),
    ),
    documents: List<UpdatedDateDocument>.from(
      json["documents"].map((x) => UpdatedDateDocument.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "updated_date": updatedDate,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
  };
}

class CategoryElement {
  int id;
  int? position;
  AllUpdatedDateDescription title;
  AllUpdatedDateDescription description;
  String? iconId;
  dynamic gradientStartColor;
  dynamic gradientEndColor;
  bool soon;
  dynamic icon;
  int? parentId;
  bool deleted;
  int status;

  CategoryElement({
    required this.id,
    required this.position,
    required this.title,
    required this.description,
    required this.iconId,
    required this.gradientStartColor,
    required this.gradientEndColor,
    required this.soon,
    required this.icon,
    required this.parentId,
    required this.deleted,
    required this.status,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["id"],
        position: json["position"] ?? 0,
        title: AllUpdatedDateDescription.fromJson(json["title"]),
        description: AllUpdatedDateDescription.fromJson(json["description"]),
        iconId: json["icon_id"],
        gradientStartColor: json["gradient_start_color"],
        gradientEndColor: json["gradient_end_color"],
        soon: json["soon"],
        icon: json["icon"],
        parentId: json["parent_id"] ?? 0,
        deleted: json["deleted"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "position": position,
    "title": title.toJson(),
    "description": description.toJson(),
    "icon_id": iconId,
    "gradient_start_color": gradientStartColor,
    "gradient_end_color": gradientEndColor,
    "soon": soon,
    "icon": icon,
    "parent_id": parentId,
    "deleted": deleted,
    "status": status,
  };
}

class AllUpdatedDateDescription {
  String? tj;
  String? ru;
  String? en;

  AllUpdatedDateDescription({required this.tj, required this.ru, required this.en});

  factory AllUpdatedDateDescription.fromJson(Map<String, dynamic> json) =>
      AllUpdatedDateDescription(tj: json["tj"], ru: json["ru"], en: json["en"]);

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

class UpdatedDateDocument {
  int id;
  int categoryId;
  DocumentCategory category;
  int? position;
  AllUpdatedDateDescription title;
  AllUpdatedDateDescription description;
  Type type;
  AllUpdatedDateDescription typeTitle;
  String icon;
  List<ApplicantType> applicantTypes;
  bool deleted;
  int status;
  String? tags;
  bool? isPublicService;

  UpdatedDateDocument({
    required this.id,
    required this.categoryId,
    required this.category,
    this.position,
    required this.title,
    required this.description,
    required this.type,
    required this.typeTitle,
    required this.icon,
    required this.applicantTypes,
    required this.deleted,
    required this.status,
    this.tags,
    this.isPublicService,
  });

  factory UpdatedDateDocument.fromJson(Map<String, dynamic> json) => UpdatedDateDocument(
    id: json["id"],
    categoryId: json["category_id"],
    category: DocumentCategory.fromJson(json["category"]),
    position: json["position"],
    title: AllUpdatedDateDescription.fromJson(json["title"]),
    description: AllUpdatedDateDescription.fromJson(json["description"]),
    type: typeValues.map[json["type"]] ?? Type.REFERENCE,
    typeTitle: AllUpdatedDateDescription.fromJson(json["type_title"]),
    icon: json["icon"],
    applicantTypes: List<ApplicantType>.from(
      json["applicant_types"].map((x) => applicantTypeValues.map[x]),
    ),
    deleted: json["deleted"],
    status: json["status"],
    tags: json["tags"],
    isPublicService: json["is_public_service"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "category": category.toJson(),
    "position": position,
    "title": title.toJson(),
    "description": description.toJson(),
    "type": typeValues.reverse[type],
    "type_title": typeTitle.toJson(),
    "icon": icon,
    "applicant_types": List<dynamic>.from(
      applicantTypes.map((x) => applicantTypeValues.reverse[x]),
    ),
    "deleted": deleted,
    "status": status,
    "tags": tags,
    "is_public_service": isPublicService,
  };
}

enum ApplicantType { INDIVIDUAL, INDIVIDUAL_ENTREPRENEUR, LEGAL_ENTITY }

final applicantTypeValues = EnumValues({
  "INDIVIDUAL": ApplicantType.INDIVIDUAL,
  "INDIVIDUAL_ENTREPRENEUR": ApplicantType.INDIVIDUAL_ENTREPRENEUR,
  "LEGAL_ENTITY": ApplicantType.LEGAL_ENTITY,
});

class DocumentCategory {
  AllUpdatedDateDescription title;
  String iconId;
  dynamic gradientStartColor;
  dynamic gradientEndColor;

  DocumentCategory({
    required this.title,
    required this.iconId,
    required this.gradientStartColor,
    required this.gradientEndColor,
  });

  factory DocumentCategory.fromJson(Map<String, dynamic> json) =>
      DocumentCategory(
        title: AllUpdatedDateDescription.fromJson(json["title"]),
        iconId: json["icon_id"],
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

enum Type { ATTORNEY, CERTIFICATE, CONCLUSION, LICENSE, PERMIT, REFERENCE }

final typeValues = EnumValues({
  "ATTORNEY": Type.ATTORNEY,
  "CERTIFICATE": Type.CERTIFICATE,
  "CONCLUSION": Type.CONCLUSION,
  "LICENSE": Type.LICENSE,
  "PERMIT": Type.PERMIT,
  "REFERENCE": Type.REFERENCE,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
