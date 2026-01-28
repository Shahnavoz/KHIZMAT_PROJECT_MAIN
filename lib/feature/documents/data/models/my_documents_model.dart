import 'dart:convert';
import 'dart:ui';

MyDocumentsModel myDocumentModelFromJson(String str) =>
    MyDocumentsModel.fromJson(json.decode(str));

String myDocumentModelToJson(MyDocumentsModel data) =>
    json.encode(data.toJson());

class MyDocumentsModel {
  final int? statusCode;
  final String? statusMessage;
  final Data? data;

  MyDocumentsModel({this.statusCode, this.statusMessage, this.data});

  factory MyDocumentsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return MyDocumentsModel();
    }
    return MyDocumentsModel(
      statusCode: json['status_code'] as int?,
      statusMessage: json['status_message'] as String?,
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    if (statusCode != null) 'status_code': statusCode,
    if (statusMessage != null) 'status_message': statusMessage,
    if (data != null) 'data': data!.toJson(),
  };
}

class Data {
  final List<Register> registers;
  final dynamic statistics;
  final int totalItems;
  final int totalPages;
  final int currentPage;

  Data({
    List<Register>? registers,
    this.statistics,
    this.totalItems = 0,
    this.totalPages = 0,
    this.currentPage = 0,
  }) : registers = registers ?? [];

  factory Data.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Data();
    }
    return Data(
      registers:
          (json['registers'] as List<dynamic>?)
              ?.map((e) => Register.fromJson(e as Map<String, dynamic>?))
              .whereType<Register>()
              .toList() ??
          [],
      statistics: json['statistics'],
      totalItems: json['totalItems'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      currentPage: json['currentPage'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'registers': registers.map((e) => e.toJson()).toList(),
    'statistics': statistics,
    'totalItems': totalItems,
    'totalPages': totalPages,
    'currentPage': currentPage,
  };
}

class Register {
  final int? id;
  final bool? active;
  final Status? status;
  final String? type;
  final MultiLang? typeTitle;
  final MultiLang? document;
  final Category? category;
  final String? expiryDate;
  final String? name;
  final String? tin;
  final String? pin;
  final String? registerNumber;
  final dynamic serial;
  final String? number;
  final String? registrationDate;
  final dynamic feesPeriodEnd;
  final bool? importRegister;

  Register({
    this.id,
    this.active,
    this.status,
    this.type,
    this.typeTitle,
    this.document,
    this.category,
    this.expiryDate,
    this.name,
    this.tin,
    this.pin,
    this.registerNumber,
    this.serial,
    this.number,
    this.registrationDate,
    this.feesPeriodEnd,
    this.importRegister,
  });

  factory Register.fromJson(Map<String, dynamic>? json) {
    if (json == null) return Register();

    return Register(
      id: json['id'] as int?,
      active: json['active'] as bool?,
      status: Status.fromJson(json['status']),
      type: json['type'] as String?,
      typeTitle: MultiLang.fromJson(json['type_title']),
      document: MultiLang.fromJson(json['document']),
      category: Category.fromJson(json['category']),
      expiryDate: json['expiry_date']?.toString(),
      name: json['name']?.toString(),
      tin: json['tin'] as String?,
      pin: json['pin'] as String?,
      registerNumber: json['register_number'] as String?,
      serial: json['serial'],
      number: json['number'] as String?,
      registrationDate: json['registration_date']?.toString(),
      feesPeriodEnd: json['fees_period_end'],
      importRegister: json['import_register'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    if (active != null) 'active': active,
    if (status != null) 'status': status!.toJson(),
    if (type != null) 'type': type,
    if (typeTitle != null) 'type_title': typeTitle!.toJson(),
    if (document != null) 'document': document!.toJson(),
    if (category != null) 'category': category!.toJson(),
    if (expiryDate != null) 'expiry_date': expiryDate,
    if (name != null) 'name': name,
    if (tin != null) 'tin': tin,
    if (pin != null) 'pin': pin,
    if (registerNumber != null) 'register_number': registerNumber,
    'serial': serial,
    if (number != null) 'number': number,
    if (registrationDate != null) 'registration_date': registrationDate,
    'fees_period_end': feesPeriodEnd,
    if (importRegister != null) 'import_register': importRegister,
  };
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

class Status {
  final StatusValue value;
  final String? background;
  final MultiLang? title;

  Status({StatusValue? value, this.background, this.title})
    : value = value ?? StatusValue.unknown;

  factory Status.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Status();
    }

    return Status(
      value: StatusValue.fromApi(json['status'] as String?),
      background: json['background'] as String?,
      title: MultiLang.fromJson(json['title']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': value.toApi(),
    if (background != null) 'background': background,
    if (title != null) 'title': title!.toJson(),
  };

  bool get isActive => value == StatusValue.active;
  bool get isNotAsigned => value == StatusValue.notSigned;
  bool get isExpired => value == StatusValue.expired;
  bool get isUnknown => value == StatusValue.unknown;
}

enum StatusValue {
  active('ACTIVE'),
  expired('EXPIRED'),
  notSigned('NOT_SIGNED'),
  unknown('UNKNOWN'); 

  final String apiValue;
  const StatusValue(this.apiValue);

 
  factory StatusValue.fromApi(String? value) {
    if (value == null) return StatusValue.unknown;
    final normalized = value.trim().toUpperCase();
    return StatusValue.values.firstWhere(
      (e) => e.apiValue == normalized,
      orElse: () => StatusValue.unknown,
    );
  }

  
  String toApi() => apiValue;
}
