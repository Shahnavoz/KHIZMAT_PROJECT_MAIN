class MyApplicationModel {
    int statusCode;
    String statusMessage;
    Data data;

    MyApplicationModel({
        required this.statusCode,
        required this.statusMessage,
        required this.data,
    });

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

}

class Register {
    int id;
    bool active;
    StatusClass status;
    Type type;
    Document typeTitle;
    Document document;
    Category category;
    ExpiryDate expiryDate;
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

}

enum ExpiryDate {
    EMPTY,
    THE_21112312
}

enum Name {
    EMPTY
}

enum RegistrationDate {
    THE_19012026,
    THE_20012026
}

class StatusClass {
    StatusEnum status;
    Background background;
    Document title;

    StatusClass({
        required this.status,
        required this.background,
        required this.title,
    });

}

enum Background {
    FFAD33,
    THE_3_ED857
}

enum StatusEnum {
    ACTIVE,
    NOT_SIGNED
}

enum Type {
    CERTIFICATE,
    PERMIT,
    REFERENCE
}
