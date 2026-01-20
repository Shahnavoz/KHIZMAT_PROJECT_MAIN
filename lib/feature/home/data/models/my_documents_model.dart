// To parse this JSON data, do
//
//     final myDocumentsModel = myDocumentsModelFromJson(jsonString);

import 'dart:convert';

MyDocumentsModel myDocumentsModelFromJson(String str) => MyDocumentsModel.fromJson(json.decode(str));

String myDocumentsModelToJson(MyDocumentsModel data) => json.encode(data.toJson());

class MyDocumentsModel {
    int statusCode;
    String statusMessage;
    Data data;

    MyDocumentsModel({
        required this.statusCode,
        required this.statusMessage,
        required this.data,
    });

    factory MyDocumentsModel.fromJson(Map<String, dynamic> json) => MyDocumentsModel(
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
    List<Register> registers;
    dynamic statistics;
    int totalItems;
    int totalPages;
    int currentPage;

    Data({
        required this.registers,
        required this.statistics,
        required this.totalItems,
        required this.totalPages,
        required this.currentPage,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        registers: List<Register>.from(json["registers"].map((x) => Register.fromJson(x))),
        statistics: json["statistics"],
        totalItems: json["totalItems"],
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
    );

    Map<String, dynamic> toJson() => {
        "registers": List<dynamic>.from(registers.map((x) => x.toJson())),
        "statistics": statistics,
        "totalItems": totalItems,
        "totalPages": totalPages,
        "currentPage": currentPage,
    };
}

class Register {
    int id;
    bool active;
    StatusClass status;
    Type type;
    Document typeTitle;
    Document document;
    Category category;
    String expiryDate;
    Name name;
    String tin;
    String pin;
    String registerNumber;
    dynamic serial;
    String number;
    RegistrationDate registrationDate;
    dynamic feesPeriodEnd;
    bool importRegister;

    Register({
        required this.id,
        required this.active,
        required this.status,
        required this.type,
        required this.typeTitle,
        required this.document,
        required this.category,
        required this.expiryDate,
        required this.name,
        required this.tin,
        required this.pin,
        required this.registerNumber,
        required this.serial,
        required this.number,
        required this.registrationDate,
        required this.feesPeriodEnd,
        required this.importRegister,
    });

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        id: json["id"],
        active: json["active"],
        status: StatusClass.fromJson(json["status"]),
        type: typeValues.map[json["type"]]!,
        typeTitle: Document.fromJson(json["type_title"]),
        document: Document.fromJson(json["document"]),
        category: Category.fromJson(json["category"]),
        expiryDate: json["expiry_date"],
        name: nameValues.map[json["name"]]!,
        tin: json["tin"],
        pin: json["pin"],
        registerNumber: json["register_number"],
        serial: json["serial"],
        number: json["number"],
        registrationDate: registrationDateValues.map[json["registration_date"]]!,
        feesPeriodEnd: json["fees_period_end"],
        importRegister: json["import_register"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "status": status.toJson(),
        "type": typeValues.reverse[type],
        "type_title": typeTitle.toJson(),
        "document": document.toJson(),
        "category": category.toJson(),
        "expiry_date": expiryDate,
        "name": nameValues.reverse[name],
        "tin": tin,
        "pin": pin,
        "register_number": registerNumber,
        "serial": serial,
        "number": number,
        "registration_date": registrationDateValues.reverse[registrationDate],
        "fees_period_end": feesPeriodEnd,
        "import_register": importRegister,
    };
}

class Category {
    Document title;
    String iconId;
    dynamic gradientStartColor;
    dynamic gradientEndColor;

    Category({
        required this.title,
        required this.iconId,
        required this.gradientStartColor,
        required this.gradientEndColor,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: Document.fromJson(json["title"]),
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

class Document {
    String tj;
    String ru;
    String en;

    Document({
        required this.tj,
        required this.ru,
        required this.en,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        tj: json["tj"],
        ru: json["ru"],
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "tj": tj,
        "ru": ru,
        "en": en,
    };
}

enum Name {
    EMPTY
}

final nameValues = EnumValues({
    "Тестов Тест Тестович": Name.EMPTY
});

enum RegistrationDate {
    THE_19012026
}

final registrationDateValues = EnumValues({
    "19.01.2026": RegistrationDate.THE_19012026
});

class StatusClass {
    StatusEnum status;
    Background background;
    Document title;

    StatusClass({
        required this.status,
        required this.background,
        required this.title,
    });

    factory StatusClass.fromJson(Map<String, dynamic> json) => StatusClass(
        status: statusEnumValues.map[json["status"]]!,
        background: backgroundValues.map[json["background"]]!,
        title: Document.fromJson(json["title"]),
    );

    Map<String, dynamic> toJson() => {
        "status": statusEnumValues.reverse[status],
        "background": backgroundValues.reverse[background],
        "title": title.toJson(),
    };
}

enum Background {
    FFAD33,
    THE_3_ED857
}

final backgroundValues = EnumValues({
    "#FFAD33": Background.FFAD33,
    "#3ED857": Background.THE_3_ED857
});

enum StatusEnum {
    ACTIVE,
    NOT_SIGNED
}

final statusEnumValues = EnumValues({
    "ACTIVE": StatusEnum.ACTIVE,
    "NOT_SIGNED": StatusEnum.NOT_SIGNED
});

enum Type {
    CERTIFICATE,
    REFERENCE
}

final typeValues = EnumValues({
    "CERTIFICATE": Type.CERTIFICATE,
    "REFERENCE": Type.REFERENCE
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
