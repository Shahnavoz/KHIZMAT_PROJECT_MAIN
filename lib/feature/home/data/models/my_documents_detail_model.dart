// To parse this JSON data, do
//
//     final myDocumentsDetailModel = myDocumentsDetailModelFromJson(jsonString);

import 'dart:convert';

MyDocumentsDetailModel myDocumentsDetailModelFromJson(String str) => MyDocumentsDetailModel.fromJson(json.decode(str));

String myDocumentsDetailModelToJson(MyDocumentsDetailModel data) => json.encode(data.toJson());

class MyDocumentsDetailModel {
    int statusCode;
    String statusMessage;
    Data data;

    MyDocumentsDetailModel({
        required this.statusCode,
        required this.statusMessage,
        required this.data,
    });

    factory MyDocumentsDetailModel.fromJson(Map<String, dynamic> json) => MyDocumentsDetailModel(
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
    int id;
    bool active;
    DataStatus status;
    String type;
    Document typeTitle;
    Document document;
    Category category;
    String expiryDate;
    String tin;
    String pin;
    String name;
    Document region;
    Document subRegion;
    dynamic address;
    String registerNumber;
    dynamic serial;
    String number;
    String registrationDate;
    Document organization;
    Document organizationDirector;
    List<dynamic> activityAddresses;
    List<dynamic> specializations;
    String specializationIds;
    dynamic activityType;
    dynamic brandMark;
    dynamic feesPeriodBegin;
    dynamic feesPeriodEnd;
    bool importRegister;
    String uuid;
    bool usageFee;
    List<dynamic> steps;
    List<dynamic> payments;
    dynamic pkiSignatures;
    List<dynamic> attachments;
    List<dynamic> fees;
    List<Application> applications;
    bool isMultiSpecialization;
    List<Addition> additions;
    String ownerType;

    Data({
        required this.id,
        required this.active,
        required this.status,
        required this.type,
        required this.typeTitle,
        required this.document,
        required this.category,
        required this.expiryDate,
        required this.tin,
        required this.pin,
        required this.name,
        required this.region,
        required this.subRegion,
        required this.address,
        required this.registerNumber,
        required this.serial,
        required this.number,
        required this.registrationDate,
        required this.organization,
        required this.organizationDirector,
        required this.activityAddresses,
        required this.specializations,
        required this.specializationIds,
        required this.activityType,
        required this.brandMark,
        required this.feesPeriodBegin,
        required this.feesPeriodEnd,
        required this.importRegister,
        required this.uuid,
        required this.usageFee,
        required this.steps,
        required this.payments,
        required this.pkiSignatures,
        required this.attachments,
        required this.fees,
        required this.applications,
        required this.isMultiSpecialization,
        required this.additions,
        required this.ownerType,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        active: json["active"],
        status: DataStatus.fromJson(json["status"]),
        type: json["type"],
        typeTitle: Document.fromJson(json["type_title"]),
        document: Document.fromJson(json["document"]),
        category: Category.fromJson(json["category"]),
        expiryDate: json["expiry_date"],
        tin: json["tin"],
        pin: json["pin"],
        name: json["name"],
        region: Document.fromJson(json["region"]),
        subRegion: Document.fromJson(json["subRegion"]),
        address: json["address"],
        registerNumber: json["register_number"],
        serial: json["serial"],
        number: json["number"],
        registrationDate: json["registration_date"],
        organization: Document.fromJson(json["organization"]),
        organizationDirector: Document.fromJson(json["organization_director"]),
        activityAddresses: List<dynamic>.from(json["activity_addresses"].map((x) => x)),
        specializations: List<dynamic>.from(json["specializations"].map((x) => x)),
        specializationIds: json["specialization_ids"],
        activityType: json["activity_type"],
        brandMark: json["brand_mark"],
        feesPeriodBegin: json["fees_period_begin"],
        feesPeriodEnd: json["fees_period_end"],
        importRegister: json["import_register"],
        uuid: json["uuid"],
        usageFee: json["usage_fee"],
        steps: List<dynamic>.from(json["steps"].map((x) => x)),
        payments: List<dynamic>.from(json["payments"].map((x) => x)),
        pkiSignatures: json["pkiSignatures"],
        attachments: List<dynamic>.from(json["attachments"].map((x) => x)),
        fees: List<dynamic>.from(json["fees"].map((x) => x)),
        applications: List<Application>.from(json["applications"].map((x) => Application.fromJson(x))),
        isMultiSpecialization: json["is_multi_specialization"],
        additions: List<Addition>.from(json["additions"].map((x) => Addition.fromJson(x))),
        ownerType: json["owner_type"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "status": status.toJson(),
        "type": type,
        "type_title": typeTitle.toJson(),
        "document": document.toJson(),
        "category": category.toJson(),
        "expiry_date": expiryDate,
        "tin": tin,
        "pin": pin,
        "name": name,
        "region": region.toJson(),
        "subRegion": subRegion.toJson(),
        "address": address,
        "register_number": registerNumber,
        "serial": serial,
        "number": number,
        "registration_date": registrationDate,
        "organization": organization.toJson(),
        "organization_director": organizationDirector.toJson(),
        "activity_addresses": List<dynamic>.from(activityAddresses.map((x) => x)),
        "specializations": List<dynamic>.from(specializations.map((x) => x)),
        "specialization_ids": specializationIds,
        "activity_type": activityType,
        "brand_mark": brandMark,
        "fees_period_begin": feesPeriodBegin,
        "fees_period_end": feesPeriodEnd,
        "import_register": importRegister,
        "uuid": uuid,
        "usage_fee": usageFee,
        "steps": List<dynamic>.from(steps.map((x) => x)),
        "payments": List<dynamic>.from(payments.map((x) => x)),
        "pkiSignatures": pkiSignatures,
        "attachments": List<dynamic>.from(attachments.map((x) => x)),
        "fees": List<dynamic>.from(fees.map((x) => x)),
        "applications": List<dynamic>.from(applications.map((x) => x.toJson())),
        "is_multi_specialization": isMultiSpecialization,
        "additions": List<dynamic>.from(additions.map((x) => x.toJson())),
        "owner_type": ownerType,
    };
}

class Addition {
    String key;
    String titleKey;
    int position;
    dynamic title;
    dynamic value;
    List<DuplicableValue> duplicableValues;
    String type;

    Addition({
        required this.key,
        required this.titleKey,
        required this.position,
        required this.title,
        required this.value,
        required this.duplicableValues,
        required this.type,
    });

    factory Addition.fromJson(Map<String, dynamic> json) => Addition(
        key: json["key"],
        titleKey: json["title_key"],
        position: json["position"],
        title: json["title"],
        value: json["value"],
        duplicableValues: List<DuplicableValue>.from(json["duplicable_values"].map((x) => DuplicableValue.fromJson(x))),
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "title_key": titleKey,
        "position": position,
        "title": title,
        "value": value,
        "duplicable_values": List<dynamic>.from(duplicableValues.map((x) => x.toJson())),
        "type": type,
    };
}

class DuplicableValue {
    int row;
    int position;
    String? value;
    Document? option;

    DuplicableValue({
        required this.row,
        required this.position,
        required this.value,
        required this.option,
    });

    factory DuplicableValue.fromJson(Map<String, dynamic> json) => DuplicableValue(
        row: json["row"],
        position: json["position"],
        value: json["value"],
        option: json["option"] == null ? null : Document.fromJson(json["option"]),
    );

    Map<String, dynamic> toJson() => {
        "row": row,
        "position": position,
        "value": value,
        "option": option?.toJson(),
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

class Application {
    int id;
    Document document;
    Category category;
    Document type;
    ApplicationType applicationType;
    ReviewStatusClass status;
    ReviewStatusClass reviewStatus;
    Step step;
    String cabinetType;
    String applicantName;
    String applicantTin;
    String registrationDate;
    String registrationNumber;
    List<dynamic> billingInvoiceDtos;
    dynamic certificate;
    dynamic createdBy;
    String createdAt;
    String completedAt;

    Application({
        required this.id,
        required this.document,
        required this.category,
        required this.type,
        required this.applicationType,
        required this.status,
        required this.reviewStatus,
        required this.step,
        required this.cabinetType,
        required this.applicantName,
        required this.applicantTin,
        required this.registrationDate,
        required this.registrationNumber,
        required this.billingInvoiceDtos,
        required this.certificate,
        required this.createdBy,
        required this.createdAt,
        required this.completedAt,
    });

    factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        document: Document.fromJson(json["document"]),
        category: Category.fromJson(json["category"]),
        type: Document.fromJson(json["type"]),
        applicationType: ApplicationType.fromJson(json["application_type"]),
        status: ReviewStatusClass.fromJson(json["status"]),
        reviewStatus: ReviewStatusClass.fromJson(json["review_status"]),
        step: Step.fromJson(json["step"]),
        cabinetType: json["cabinet_type"],
        applicantName: json["applicant_name"],
        applicantTin: json["applicant_tin"],
        registrationDate: json["registration_date"],
        registrationNumber: json["registration_number"],
        billingInvoiceDtos: List<dynamic>.from(json["billingInvoiceDtos"].map((x) => x)),
        certificate: json["certificate"],
        createdBy: json["created_by"],
        createdAt: json["created_at"],
        completedAt: json["completed_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "document": document.toJson(),
        "category": category.toJson(),
        "type": type.toJson(),
        "application_type": applicationType.toJson(),
        "status": status.toJson(),
        "review_status": reviewStatus.toJson(),
        "step": step.toJson(),
        "cabinet_type": cabinetType,
        "applicant_name": applicantName,
        "applicant_tin": applicantTin,
        "registration_date": registrationDate,
        "registration_number": registrationNumber,
        "billingInvoiceDtos": List<dynamic>.from(billingInvoiceDtos.map((x) => x)),
        "certificate": certificate,
        "created_by": createdBy,
        "created_at": createdAt,
        "completed_at": completedAt,
    };
}

class ApplicationType {
    String key;
    Document title;

    ApplicationType({
        required this.key,
        required this.title,
    });

    factory ApplicationType.fromJson(Map<String, dynamic> json) => ApplicationType(
        key: json["key"],
        title: Document.fromJson(json["title"]),
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "title": title.toJson(),
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

class ReviewStatusClass {
    String key;
    Document title;
    String backgroundColor;
    String? can;

    ReviewStatusClass({
        required this.key,
        required this.title,
        required this.backgroundColor,
        required this.can,
    });

    factory ReviewStatusClass.fromJson(Map<String, dynamic> json) => ReviewStatusClass(
        key: json["key"],
        title: Document.fromJson(json["title"]),
        backgroundColor: json["background_color"],
        can: json["can"],
    );

    Map<String, dynamic> toJson() => {
        "key": key,
        "title": title.toJson(),
        "background_color": backgroundColor,
        "can": can,
    };
}

class Step {
    Document title;
    int position;
    int count;

    Step({
        required this.title,
        required this.position,
        required this.count,
    });

    factory Step.fromJson(Map<String, dynamic> json) => Step(
        title: Document.fromJson(json["title"]),
        position: json["position"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "title": title.toJson(),
        "position": position,
        "count": count,
    };
}

class DataStatus {
    String status;
    String background;
    Document title;

    DataStatus({
        required this.status,
        required this.background,
        required this.title,
    });

    factory DataStatus.fromJson(Map<String, dynamic> json) => DataStatus(
        status: json["status"],
        background: json["background"],
        title: Document.fromJson(json["title"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "background": background,
        "title": title.toJson(),
    };
}
