import 'dart:convert';
import 'dart:ui';

MyApplicationsModel myApplicationsModelFromJson(String str) =>
    MyApplicationsModel.fromJson(json.decode(str));

String myApplicationsResponseToJson(MyApplicationsModel data) =>
    json.encode(data.toJson());

class MyApplicationsModel {
  final int? statusCode;
  final String? statusMessage;
  final ResponseData? data;

  MyApplicationsModel({
    this.statusCode,
    this.statusMessage,
    this.data,
  });

  factory MyApplicationsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return MyApplicationsModel();
    return MyApplicationsModel(
      statusCode: json['status_code'] as int?,
      statusMessage: json['status_message'] as String?,
      data: ResponseData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        if (statusCode != null) 'status_code': statusCode,
        if (statusMessage != null) 'status_message': statusMessage,
        if (data != null) 'data': data!.toJson(),
      };
}

class ResponseData {
  final List<ApplicationItem> applicationList;
  final dynamic statistics;
  final dynamic statisticsSubProcesses;
  final dynamic statisticsStatuses;
  final int totalItems;
  final int totalPages;
  final int currentPage;

  ResponseData({
    List<ApplicationItem>? applicationList,
    this.statistics,
    this.statisticsSubProcesses,
    this.statisticsStatuses,
    this.totalItems = 0,
    this.totalPages = 0,
    this.currentPage = 0,
  }) : applicationList = applicationList ?? [];

  factory ResponseData.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ResponseData();
    return ResponseData(
      applicationList: (json['application_list'] as List<dynamic>?)
              ?.map((e) => ApplicationItem.fromJson(e as Map<String, dynamic>?))
              .whereType<ApplicationItem>()
              .toList() ??
          [],
      statistics: json['statistics'],
      statisticsSubProcesses: json['statistics_sub_processes'],
      statisticsStatuses: json['statistics_statuses'],
      totalItems: json['totalItems'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      currentPage: json['currentPage'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'application_list': applicationList.map((e) => e.toJson()).toList(),
        'statistics': statistics,
        'statistics_sub_processes': statisticsSubProcesses,
        'statistics_statuses': statisticsStatuses,
        'totalItems': totalItems,
        'totalPages': totalPages,
        'currentPage': currentPage,
      };
}

enum StatusKey {
  inProcess('IN_PROCESS'),//В процессе заполнения
  notPaid('NOT_PAID'),//Не оплачен
  completed('COMPLETED'),//Успешно рассмотрено
  inPayment('IN_PAYMENT'),//В процессе оплаты
  review('REVIEW'),//На рассмотрении
  unknown('UNKNOWN');

  final String apiValue;
  const StatusKey(this.apiValue);

  factory StatusKey.fromString(String? value) {
    if (value == null || value.trim().isEmpty) return StatusKey.unknown;
    final normalized = value.trim().toUpperCase();
    return values.firstWhere(
      (e) => e.apiValue == normalized,
      orElse: () => StatusKey.unknown,
    );
  }

  String toApiString() => apiValue;
}

class ApplicationStatus {
  final StatusKey key;
  final MultiLang? title;
  final String? backgroundColor;
  final String? can; // "edit", "view", null и т.д.

  ApplicationStatus({
    StatusKey? key,
    this.title,
    this.backgroundColor,
    this.can,
  }) : key = key ?? StatusKey.unknown;

  factory ApplicationStatus.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ApplicationStatus();
    return ApplicationStatus(
      key: StatusKey.fromString(json['key'] as String?),
      title: MultiLang.fromJson(json['title']),
      backgroundColor: json['background_color'] as String?,
      can: json['can'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'key': key.toApiString(),
        if (title != null) 'title': title!.toJson(),
        if (backgroundColor != null) 'background_color': backgroundColor,
        if (can != null) 'can': can,
      };

  bool get isInProcess => key == StatusKey.inProcess;
  bool get isUnderReview => key == StatusKey.review;
  bool get isPaymentProcess => key == StatusKey.inPayment;
  bool get isCompleted => key == StatusKey.completed;
}

class ApplicationItem {
  final int? id;
  final int? subId;
  final MultiLang? document;
  final Category? category;
  final String? documentType;
  final MultiLang? type;
  final ApplicationType? applicationType;
  final ApplicationStatus? status;
  final ApplicationStatus? reviewStatus;
  final Step? step;
  final bool? reApplication;
  final String? cabinetType;
  final String? applicantName;
  final String? applicantTin;
  final String? registrationDate;
  final String? reviewExpiry;
  final String? correctionExpiry;
  final String? paymentExpiry;
  final String? registrationNumber;
  final String? createdBy;

  ApplicationItem({
    this.id,
    this.subId,
    this.document,
    this.category,
    this.documentType,
    this.type,
    this.applicationType,
    this.status,
    this.reviewStatus,
    this.step,
    this.reApplication = false,
    this.cabinetType,
    this.applicantName,
    this.applicantTin,
    this.registrationDate,
    this.reviewExpiry,
    this.correctionExpiry,
    this.paymentExpiry,
    this.registrationNumber,
    this.createdBy,
  });

  factory ApplicationItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ApplicationItem();
    return ApplicationItem(
      id: json['id'] as int?,
      subId: json['sub_id'] as int?,
      document: MultiLang.fromJson(json['document']),
      category: Category.fromJson(json['category']),
      documentType: json['document_type'] as String?,
      type: MultiLang.fromJson(json['type']),
      applicationType: ApplicationType.fromJson(json['application_type']),
      status: ApplicationStatus.fromJson(json['status']),
      reviewStatus: ApplicationStatus.fromJson(json['review_status']),
      step: Step.fromJson(json['step']),
      reApplication: json['re_application'] as bool? ?? false,
      cabinetType: json['cabinet_type'] as String?,
      applicantName: json['applicant_name'] as String?,
      applicantTin: json['applicant_tin'] as String?,
      registrationDate: json['registration_date'] as String?,
      reviewExpiry: json['review_expiry'] as String?,
      correctionExpiry: json['correction_expiry'] as String?,
      paymentExpiry: json['payment_expiry'] as String?,
      registrationNumber: json['registration_number'] as String?,
      createdBy: json['created_by'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (subId != null) 'sub_id': subId,
        if (document != null) 'document': document!.toJson(),
        if (category != null) 'category': category!.toJson(),
        if (documentType != null) 'document_type': documentType,
        if (type != null) 'type': type!.toJson(),
        if (applicationType != null) 'application_type': applicationType!.toJson(),
        if (status != null) 'status': status!.toJson(),
        if (reviewStatus != null) 'review_status': reviewStatus!.toJson(),
        if (step != null) 'step': step!.toJson(),
        if (reApplication != null) 're_application': reApplication,
        if (cabinetType != null) 'cabinet_type': cabinetType,
        if (applicantName != null) 'applicant_name': applicantName,
        if (applicantTin != null) 'applicant_tin': applicantTin,
        if (registrationDate != null) 'registration_date': registrationDate,
        if (reviewExpiry != null) 'review_expiry': reviewExpiry,
        if (correctionExpiry != null) 'correction_expiry': correctionExpiry,
        if (paymentExpiry != null) 'payment_expiry': paymentExpiry,
        if (registrationNumber != null) 'registration_number': registrationNumber,
        if (createdBy != null) 'created_by': createdBy,
      };
}

// Вспомогательные классы (все безопасные)

class MultiLang {
  final String? tj;
  final String? ru;
  final String? en;

  MultiLang({this.tj, this.ru, this.en});

  factory MultiLang.fromJson(Map<String, dynamic>? json) {
    if (json == null) return MultiLang();
    return MultiLang(
      tj: json['tj'] as String?,
      ru: json['ru'] as String?,
      en: json['en'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (tj != null) 'tj': tj,
        if (ru != null) 'ru': ru,
        if (en != null) 'en': en,
      };

  String get any => tj ?? ru ?? en ?? '';

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
  final MultiLang? title;
  final String? iconId;
  final String? gradientStartColor;
  final String? gradientEndColor;

  Category({
    this.title,
    this.iconId,
    this.gradientStartColor,
    this.gradientEndColor,
  });

  factory Category.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Category();
    return Category(
      title: MultiLang.fromJson(json['title']),
      iconId: json['icon_id'] as String?,
      gradientStartColor: json['gradient_start_color'] as String?,
      gradientEndColor: json['gradient_end_color'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title!.toJson(),
        if (iconId != null) 'icon_id': iconId,
        if (gradientStartColor != null) 'gradient_start_color': gradientStartColor,
        if (gradientEndColor != null) 'gradient_end_color': gradientEndColor,
      };
}

class ApplicationType {
  final String? key;
  final MultiLang? title;

  ApplicationType({this.key, this.title});

  factory ApplicationType.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ApplicationType();
    return ApplicationType(
      key: json['key'] as String?,
      title: MultiLang.fromJson(json['title']),
    );
  }

  Map<String, dynamic> toJson() => {
        if (key != null) 'key': key,
        if (title != null) 'title': title!.toJson(),
      };
}

class Step {
  final MultiLang? title;
  final int? position;
  final int? count;

  Step({this.title, this.position, this.count});

  factory Step.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Step();
    return Step(
      title: MultiLang.fromJson(json['title']),
      position: json['position'] as int?,
      count: json['count'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (title != null) 'title': title!.toJson(),
        if (position != null) 'position': position,
        if (count != null) 'count': count,
      };
}