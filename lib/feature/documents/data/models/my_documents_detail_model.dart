import 'dart:convert';
import 'dart:ui';

MyDocumentDetailInfoModel myDocumentDetailInfoModelFromJson(String str) => 
    MyDocumentDetailInfoModel.fromJson(json.decode(str) as Map<String, dynamic>);

String myDocumentModelToJson(MyDocumentDetailInfoModel data) => 
    json.encode(data.toJson());

class MyDocumentDetailInfoModel {
  int? statusCode;
  String? statusMessage;
  Data? data;

  MyDocumentDetailInfoModel({
    this.statusCode,
    this.statusMessage,
    this.data,
  });

  factory MyDocumentDetailInfoModel.fromJson(Map<String, dynamic> json) => MyDocumentDetailInfoModel(
        statusCode: json["status_code"] as int?,
        statusMessage: json["status_message"] as String?,
        data: json["data"] != null 
            ? Data.fromJson(json["data"] as Map<String, dynamic>) 
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (statusCode != null) "status_code": statusCode,
        if (statusMessage != null) "status_message": statusMessage,
        if (data != null) "data": data!.toJson(),
      };
}

class Data {
  int? id;
  bool? active;
  DataStatus? status;
  String? type;
  Document? typeTitle;
  Document? document;
  Category? category;
  String? expiryDate;
  String? tin;
  String? pin;
  String? name;
  Document? region;
  Document? subRegion;
  dynamic address;
  String? registerNumber;
  dynamic serial;
  String? number;
  String? registrationDate;
  Document? organization;
  Document? organizationDirector;
  List<dynamic>? activityAddresses;
  List<dynamic>? specializations;
  String? specializationIds;
  dynamic activityType;
  dynamic brandMark;
  dynamic feesPeriodBegin;
  dynamic feesPeriodEnd;
  bool? importRegister;
  String? uuid;
  bool? usageFee;
  List<dynamic>? steps;
  List<Payment>? payments;
  PkiSignatures? pkiSignatures;
  List<Attachment>? attachments;
  List<dynamic>? fees;
  List<Application>? applications;
  bool? isMultiSpecialization;
  List<Addition>? additions;
  String? ownerType;

  Data({
    this.id,
    this.active,
    this.status,
    this.type,
    this.typeTitle,
    this.document,
    this.category,
    this.expiryDate,
    this.tin,
    this.pin,
    this.name,
    this.region,
    this.subRegion,
    this.address,
    this.registerNumber,
    this.serial,
    this.number,
    this.registrationDate,
    this.organization,
    this.organizationDirector,
    this.activityAddresses,
    this.specializations,
    this.specializationIds,
    this.activityType,
    this.brandMark,
    this.feesPeriodBegin,
    this.feesPeriodEnd,
    this.importRegister,
    this.uuid,
    this.usageFee,
    this.steps,
    this.payments,
    this.pkiSignatures,
    this.attachments,
    this.fees,
    this.applications,
    this.isMultiSpecialization,
    this.additions,
    this.ownerType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] as int?,
        active: json["active"] as bool?,
        status: json["status"] != null 
            ? DataStatus.fromJson(json["status"] as Map<String, dynamic>) 
            : null,
        type: json["type"] as String?,
        typeTitle: json["type_title"] != null 
            ? Document.fromJson(json["type_title"] as Map<String, dynamic>) 
            : null,
        document: json["document"] != null 
            ? Document.fromJson(json["document"] as Map<String, dynamic>) 
            : null,
        category: json["category"] != null 
            ? Category.fromJson(json["category"] as Map<String, dynamic>) 
            : null,
        expiryDate: json["expiry_date"] as String?,
        tin: json["tin"] as String?,
        pin: json["pin"] as String?,
        name: json["name"] as String?,
        region: json["region"] != null 
            ? Document.fromJson(json["region"] as Map<String, dynamic>) 
            : null,
        subRegion: json["subRegion"] != null 
            ? Document.fromJson(json["subRegion"] as Map<String, dynamic>) 
            : null,
        address: json["address"],
        registerNumber: json["register_number"] as String?,
        serial: json["serial"],
        number: json["number"] as String?,
        registrationDate: json["registration_date"] as String?,
        organization: json["organization"] != null 
            ? Document.fromJson(json["organization"] as Map<String, dynamic>) 
            : null,
        organizationDirector: json["organization_director"] != null 
            ? Document.fromJson(json["organization_director"] as Map<String, dynamic>) 
            : null,
        activityAddresses: json["activity_addresses"] is List 
            ? List<dynamic>.from(json["activity_addresses"] as List) 
            : [],
        specializations: json["specializations"] is List 
            ? List<dynamic>.from(json["specializations"] as List) 
            : [],
        specializationIds: json["specialization_ids"] as String?,
        activityType: json["activity_type"],
        brandMark: json["brand_mark"],
        feesPeriodBegin: json["fees_period_begin"],
        feesPeriodEnd: json["fees_period_end"],
        importRegister: json["import_register"] as bool?,
        uuid: json["uuid"] as String?,
        usageFee: json["usage_fee"] as bool?,
        steps: json["steps"] is List ? List<dynamic>.from(json["steps"] as List) : [],
        payments: (json["payments"] as List<dynamic>?)
                ?.map((x) => x is Map<String, dynamic> ? Payment.fromJson(x) : null)
                .whereType<Payment>()
                .toList() ?? [],
        pkiSignatures: json["pkiSignatures"] != null 
            ? PkiSignatures.fromJson(json["pkiSignatures"] as Map<String, dynamic>) 
            : null,
        attachments: (json["attachments"] as List<dynamic>?)
                ?.map((x) => x is Map<String, dynamic> 
                    ? Attachment.fromJson(x) 
                    : null)
                .whereType<Attachment>()
                .toList() ?? [],
        fees: json["fees"] is List ? List<dynamic>.from(json["fees"] as List) : [],
        applications: (json["applications"] as List<dynamic>?)
                ?.map((x) => x is Map<String, dynamic> 
                    ? Application.fromJson(x) 
                    : null)
                .whereType<Application>()
                .toList() ?? [],
        isMultiSpecialization: json["is_multi_specialization"] as bool?,
        additions: (json["additions"] as List<dynamic>?)
                ?.map((x) => x is Map<String, dynamic> 
                    ? Addition.fromJson(x) 
                    : null)
                .whereType<Addition>()
                .toList() ?? [],
        ownerType: json["owner_type"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (active != null) "active": active,
        if (status != null) "status": status!.toJson(),
        if (type != null) "type": type,
        if (typeTitle != null) "type_title": typeTitle!.toJson(),
        if (document != null) "document": document!.toJson(),
        if (category != null) "category": category!.toJson(),
        if (expiryDate != null) "expiry_date": expiryDate,
        if (tin != null) "tin": tin,
        if (pin != null) "pin": pin,
        if (name != null) "name": name,
        if (region != null) "region": region!.toJson(),
        if (subRegion != null) "subRegion": subRegion!.toJson(),
        if (address != null) "address": address,
        if (registerNumber != null) "register_number": registerNumber,
        if (serial != null) "serial": serial,
        if (number != null) "number": number,
        if (registrationDate != null) "registration_date": registrationDate,
        if (organization != null) "organization": organization!.toJson(),
        if (organizationDirector != null) "organization_director": organizationDirector!.toJson(),
        "activity_addresses": activityAddresses ?? [],
        "specializations": specializations ?? [],
        if (specializationIds != null) "specialization_ids": specializationIds,
        if (activityType != null) "activity_type": activityType,
        if (brandMark != null) "brand_mark": brandMark,
        if (feesPeriodBegin != null) "fees_period_begin": feesPeriodBegin,
        if (feesPeriodEnd != null) "fees_period_end": feesPeriodEnd,
        if (importRegister != null) "import_register": importRegister,
        if (uuid != null) "uuid": uuid,
        if (usageFee != null) "usage_fee": usageFee,
        "steps": steps ?? [],
        "payments": payments?.map((e) => e.toJson()).toList() ?? [],
        if (pkiSignatures != null) "pkiSignatures": pkiSignatures!.toJson(),
        "attachments": attachments?.map((e) => e.toJson()).toList() ?? [],
        "fees": fees ?? [],
        "applications": applications?.map((e) => e.toJson()).toList() ?? [],
        if (isMultiSpecialization != null) "is_multi_specialization": isMultiSpecialization,
        "additions": additions?.map((e) => e.toJson()).toList() ?? [],
        if (ownerType != null) "owner_type": ownerType,
      };
}

class Addition {
  String? key;
  String? titleKey;
  int? position;
  Document? title;
  String? value;
  List<DuplicableValue>? duplicableValues;
  String? type;

  Addition({
    this.key,
    this.titleKey,
    this.position,
    this.title,
    this.value,
    this.duplicableValues,
    this.type,
  });

  factory Addition.fromJson(Map<String, dynamic> json) => Addition(
        key: json["key"] as String?,
        titleKey: json["title_key"] as String?,
        position: json["position"] as int?,
        title: json["title"] != null 
            ? Document.fromJson(json["title"] as Map<String, dynamic>) 
            : null,
        value: json["value"] as String?,
        duplicableValues: (json["duplicable_values"] as List<dynamic>?)
                ?.map((x) => x is Map<String, dynamic> 
                    ? DuplicableValue.fromJson(x) 
                    : null)
                .whereType<DuplicableValue>()
                .toList() ?? [],
        type: json["type"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (key != null) "key": key,
        if (titleKey != null) "title_key": titleKey,
        if (position != null) "position": position,
        if (title != null) "title": title!.toJson(),
        if (value != null) "value": value,
        "duplicable_values": duplicableValues?.map((e) => e.toJson()).toList() ?? [],
        if (type != null) "type": type,
      };
}

class DuplicableValue {
  int? row;
  int? position;
  String? value;
  Document? option;

  DuplicableValue({
    this.row,
    this.position,
    this.value,
    this.option,
  });

  factory DuplicableValue.fromJson(Map<String, dynamic> json) => DuplicableValue(
        row: json["row"] as int?,
        position: json["position"] as int?,
        value: json["value"] as String?,
        option: json["option"] != null 
            ? Document.fromJson(json["option"] as Map<String, dynamic>) 
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (row != null) "row": row,
        if (position != null) "position": position,
        if (value != null) "value": value,
        if (option != null) "option": option!.toJson(),
      };
}

class Document {
  String? tj;
  String? ru;
  String? en;

  Document({
    this.tj,
    this.ru,
    this.en,
  });

  factory Document.fromJson(Map<String, dynamic>? json) => Document(
        tj: json?["tj"] as String? ?? '',
        ru: json?["ru"] as String? ?? '',
        en: json?["en"] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        "tj": tj ?? '',
        "ru": ru ?? '',
        "en": en ?? '',
      };

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

class Category {
  Document? title;
  String? iconId;
  dynamic gradientStartColor;
  dynamic gradientEndColor;

  Category({
    this.title,
    this.iconId,
    this.gradientStartColor,
    this.gradientEndColor,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        title: json["title"] != null 
            ? Document.fromJson(json["title"] as Map<String, dynamic>) 
            : null,
        iconId: json["icon_id"] as String?,
        gradientStartColor: json["gradient_start_color"],
        gradientEndColor: json["gradient_end_color"],
      );

  Map<String, dynamic> toJson() => {
        if (title != null) "title": title!.toJson(),
        if (iconId != null) "icon_id": iconId,
        if (gradientStartColor != null) "gradient_start_color": gradientStartColor,
        if (gradientEndColor != null) "gradient_end_color": gradientEndColor,
      };
}

class Application {
  int? id;
  Document? document;
  Category? category;
  Document? type;
  ApplicationType? applicationType;
  ReviewStatusClass? status;
  ReviewStatusClass? reviewStatus;
  Step? step;
  String? cabinetType;
  String? applicantName;
  String? applicantTin;
  String? registrationDate;
  String? registrationNumber;
  List<dynamic>? billingInvoiceDtos;
  dynamic certificate;
  dynamic createdBy;
  String? createdAt;
  String? completedAt;

  Application({
    this.id,
    this.document,
    this.category,
    this.type,
    this.applicationType,
    this.status,
    this.reviewStatus,
    this.step,
    this.cabinetType,
    this.applicantName,
    this.applicantTin,
    this.registrationDate,
    this.registrationNumber,
    this.billingInvoiceDtos,
    this.certificate,
    this.createdBy,
    this.createdAt,
    this.completedAt,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"] as int?,
        document: json["document"] != null 
            ? Document.fromJson(json["document"] as Map<String, dynamic>) 
            : null,
        category: json["category"] != null 
            ? Category.fromJson(json["category"] as Map<String, dynamic>) 
            : null,
        type: json["type"] != null 
            ? Document.fromJson(json["type"] as Map<String, dynamic>) 
            : null,
        applicationType: json["application_type"] != null 
            ? ApplicationType.fromJson(json["application_type"] as Map<String, dynamic>) 
            : null,
        status: json["status"] != null 
            ? ReviewStatusClass.fromJson(json["status"] as Map<String, dynamic>) 
            : null,
        reviewStatus: json["review_status"] != null 
            ? ReviewStatusClass.fromJson(json["review_status"] as Map<String, dynamic>) 
            : null,
        step: json["step"] != null 
            ? Step.fromJson(json["step"] as Map<String, dynamic>) 
            : null,
        cabinetType: json["cabinet_type"] as String?,
        applicantName: json["applicant_name"] as String?,
        applicantTin: json["applicant_tin"] as String?,
        registrationDate: json["registration_date"] as String?,
        registrationNumber: json["registration_number"] as String?,
        billingInvoiceDtos: json["billingInvoiceDtos"] is List 
            ? List<dynamic>.from(json["billingInvoiceDtos"] as List) 
            : [],
        certificate: json["certificate"],
        createdBy: json["created_by"],
        createdAt: json["created_at"] as String?,
        completedAt: json["completed_at"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (document != null) "document": document!.toJson(),
        if (category != null) "category": category!.toJson(),
        if (type != null) "type": type!.toJson(),
        if (applicationType != null) "application_type": applicationType!.toJson(),
        if (status != null) "status": status!.toJson(),
        if (reviewStatus != null) "review_status": reviewStatus!.toJson(),
        if (step != null) "step": step!.toJson(),
        if (cabinetType != null) "cabinet_type": cabinetType,
        if (applicantName != null) "applicant_name": applicantName,
        if (applicantTin != null) "applicant_tin": applicantTin,
        if (registrationDate != null) "registration_date": registrationDate,
        if (registrationNumber != null) "registration_number": registrationNumber,
        "billingInvoiceDtos": billingInvoiceDtos ?? [],
        if (certificate != null) "certificate": certificate,
        if (createdBy != null) "created_by": createdBy,
        if (createdAt != null) "created_at": createdAt,
        if (completedAt != null) "completed_at": completedAt,
      };
}

class ApplicationType {
  String? key;
  Document? title;

  ApplicationType({
    this.key,
    this.title,
  });

  factory ApplicationType.fromJson(Map<String, dynamic> json) => ApplicationType(
        key: json["key"] as String?,
        title: json["title"] != null 
            ? Document.fromJson(json["title"] as Map<String, dynamic>) 
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (key != null) "key": key,
        if (title != null) "title": title!.toJson(),
      };
}

class ReviewStatusClass {
  String? key;
  Document? title;
  String? backgroundColor;
  String? can;

  ReviewStatusClass({
    this.key,
    this.title,
    this.backgroundColor,
    this.can,
  });

  factory ReviewStatusClass.fromJson(Map<String, dynamic> json) => ReviewStatusClass(
        key: json["key"] as String?,
        title: json["title"] != null 
            ? Document.fromJson(json["title"] as Map<String, dynamic>) 
            : null,
        backgroundColor: json["background_color"] as String?,
        can: json["can"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (key != null) "key": key,
        if (title != null) "title": title!.toJson(),
        if (backgroundColor != null) "background_color": backgroundColor,
        if (can != null) "can": can,
      };
}

class Step {
  Document? title;
  int? position;
  int? count;

  Step({
    this.title,
    this.position,
    this.count,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        title: json["title"] != null 
            ? Document.fromJson(json["title"] as Map<String, dynamic>) 
            : null,
        position: json["position"] as int?,
        count: json["count"] as int?,
      );

  Map<String, dynamic> toJson() => {
        if (title != null) "title": title!.toJson(),
        if (position != null) "position": position,
        if (count != null) "count": count,
      };
}

class Attachment {
  int? fileId;
  String? name;
  String? extension;
  int? size;
  String? downloadUri;

  Attachment({
    this.fileId,
    this.name,
    this.extension,
    this.size,
    this.downloadUri,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        fileId: json["fileId"] as int?,
        name: json["name"] as String?,
        extension: json["extension"] as String?,
        size: json["size"] as int?,
        downloadUri: json["download_uri"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (fileId != null) "fileId": fileId,
        if (name != null) "name": name,
        if (extension != null) "extension": extension,
        if (size != null) "size": size,
        if (downloadUri != null) "download_uri": downloadUri,
      };
}

class PkiSignatures {
  String? ru;
  String? tj;
  String? en;
  String? serialNumber;
  String? pkiIssuerFirstName;
  String? pkiIssuerLastName;
  String? pkiIssuerOrganization;
  String? pkiIssuerPhoneNumber;
  String? pkiOwnerFirstName;
  String? pkiOwnerLastName;
  String? pkiOwnerOrganization;
  String? pkiOwnerPhoneNumber;
  DateTime? pkiOwnerValidFrom;
  DateTime? pkiOwnerValidTo;

  PkiSignatures({
    this.ru,
    this.tj,
    this.en,
    this.serialNumber,
    this.pkiIssuerFirstName,
    this.pkiIssuerLastName,
    this.pkiIssuerOrganization,
    this.pkiIssuerPhoneNumber,
    this.pkiOwnerFirstName,
    this.pkiOwnerLastName,
    this.pkiOwnerOrganization,
    this.pkiOwnerPhoneNumber,
    this.pkiOwnerValidFrom,
    this.pkiOwnerValidTo,
  });

  factory PkiSignatures.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PkiSignatures();
    return PkiSignatures(
      ru: json["ru"] as String?,
      tj: json["tj"] as String?,
      en: json["en"] as String?,
      serialNumber: json["serialNumber"] as String?,
      pkiIssuerFirstName: json["pkiIssuerFirstName"] as String?,
      pkiIssuerLastName: json["pkiIssuerLastName"] as String?,
      pkiIssuerOrganization: json["pkiIssuerOrganization"] as String?,
      pkiIssuerPhoneNumber: json["pkiIssuerPhoneNumber"] as String?,
      pkiOwnerFirstName: json["pkiOwnerFirstName"] as String?,
      pkiOwnerLastName: json["pkiOwnerLastName"] as String?,
      pkiOwnerOrganization: json["pkiOwnerOrganization"] as String?,
      pkiOwnerPhoneNumber: json["pkiOwnerPhoneNumber"] as String?,
      pkiOwnerValidFrom: _safeParseDate(json["pkiOwnerValidFrom"]),
      pkiOwnerValidTo: _safeParseDate(json["pkiOwnerValidTo"]),
    );
  }

  static DateTime? _safeParseDate(dynamic value) {
    if (value == null || value is! String) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        if (ru != null) "ru": ru,
        if (tj != null) "tj": tj,
        if (en != null) "en": en,
        if (serialNumber != null) "serialNumber": serialNumber,
        if (pkiIssuerFirstName != null) "pkiIssuerFirstName": pkiIssuerFirstName,
        if (pkiIssuerLastName != null) "pkiIssuerLastName": pkiIssuerLastName,
        if (pkiIssuerOrganization != null) "pkiIssuerOrganization": pkiIssuerOrganization,
        if (pkiIssuerPhoneNumber != null) "pkiIssuerPhoneNumber": pkiIssuerPhoneNumber,
        if (pkiOwnerFirstName != null) "pkiOwnerFirstName": pkiOwnerFirstName,
        if (pkiOwnerLastName != null) "pkiOwnerLastName": pkiOwnerLastName,
        if (pkiOwnerOrganization != null) "pkiOwnerOrganization": pkiOwnerOrganization,
        if (pkiOwnerPhoneNumber != null) "pkiOwnerPhoneNumber": pkiOwnerPhoneNumber,
        if (pkiOwnerValidFrom != null) "pkiOwnerValidFrom": pkiOwnerValidFrom!.toIso8601String(),
        if (pkiOwnerValidTo != null) "pkiOwnerValidTo": pkiOwnerValidTo!.toIso8601String(),
      };
}

class DataStatus {
  String? status;
  String? background;
  Document? title;

  DataStatus({
    this.status,
    this.background,
    this.title,
  });

  factory DataStatus.fromJson(Map<String, dynamic> json) => DataStatus(
        status: json["status"] as String?,
        background: json["background"] as String?,
        title: json["title"] != null 
            ? Document.fromJson(json["title"] as Map<String, dynamic>) 
            : null,
      );

  Map<String, dynamic> toJson() => {
        if (status != null) "status": status,
        if (background != null) "background": background,
        if (title != null) "title": title!.toJson(),
      };
}

class Payment {
  int id;
  String? serial;
  String? amount;
  String? paid_at;
  String? status;

  Payment({
    required this.id,
    this.serial,
    this.amount,
    this.paid_at,
    this.status,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"] as int,
        serial: json["serial"] as String?,
        amount: json["amount"]?.toString(),
        paid_at: json["paid_at"] as String?,
        status: json["status"] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (serial != null) "serial": serial,
        if (amount != null) "amount": amount,
        if (paid_at != null) "paid_at": paid_at,
        if (status != null) "status": status,
      };
}