import 'dart:convert';
import 'dart:ui';

MyApplicationDetailModel? myApplicationDetailModelFromJson(String str) {
  try {
    final jsonMap = json.decode(str) as Map<String, dynamic>?;
    if (jsonMap == null) return null;
    return MyApplicationDetailModel.fromJson(jsonMap);
  } catch (_) {
    return null;
  }
}

String myApplicationDetailModelToJson(MyApplicationDetailModel? data) =>
    data == null ? '{}' : json.encode(data.toJson());

class MyApplicationDetailModel {
  final int statusCode;
  final String statusMessage;
  final Data data;

  MyApplicationDetailModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory MyApplicationDetailModel.fromJson(Map<String, dynamic> json) {
    return MyApplicationDetailModel(
      statusCode: _parseInt(json['status_code'], fallback: 0),
      statusMessage: _parseString(json['status_message'], fallback: 'Unknown'),
      data: Data.fromJson(_safeMap(json['data'])),
    );
  }

  Map<String, dynamic> toJson() => {
    'status_code': statusCode,
    'status_message': statusMessage,
    'data': data.toJson(),
  };
}

class Data {
  final int id;
  final dynamic subId;
  final TypeClass document;
  final Category category;
  final TypeClass type;
  final ApplicationTypeClass applicationType;
  final Status status;
  final Status reviewStatus;
  final bool reApplication;
  final List<Step> steps;
  final List<dynamic> invoices;
  final List<dynamic> fees;
  final List<ActionLog> actionLog;
  final List<dynamic> oldApplications;
  final List<DocumentElement> documents;
  final String cabinetType;
  final String applicantName;
  final String applicantTin;
  final String pin;
  final String registrationDate;
  final String registrationNumber;
  final String number;
  final String? terminationDate;
  final String? changeDate;
  final String? reviewExpiry;
  final String? correctionExpiry;
  final String? paymentExpiry;
  final dynamic termination;
  final String uuid;
  final int registerId;
  final bool usageFee;
  final List<dynamic> acts;
  final String createdAt;
  final String? deletedAt;
  final String? completedAt;
  final String? expiryDate;
  final String? sentDate;
  final List<dynamic> attachments;

  Data({
    required this.id,
    this.subId,
    required this.document,
    required this.category,
    required this.type,
    required this.applicationType,
    required this.status,
    required this.reviewStatus,
    required this.reApplication,
    required this.steps,
    required this.invoices,
    required this.fees,
    required this.actionLog,
    required this.oldApplications,
    required this.documents,
    required this.cabinetType,
    required this.applicantName,
    required this.applicantTin,
    required this.pin,
    required this.registrationDate,
    required this.registrationNumber,
    required this.number,
    this.terminationDate,
    this.changeDate,
    this.reviewExpiry,
    this.correctionExpiry,
    this.paymentExpiry,
    this.termination,
    required this.uuid,
    required this.registerId,
    required this.usageFee,
    required this.acts,
    required this.createdAt,
    this.deletedAt,
    this.completedAt,
    this.expiryDate,
    this.sentDate,
    required this.attachments,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: _parseInt(json['id']),
      subId: json['sub_id'],
      document: TypeClass.fromJson(_safeMap(json['document'])),
      category: Category.fromJson(_safeMap(json['category'])),
      type: TypeClass.fromJson(_safeMap(json['type'])),
      applicationType: ApplicationTypeClass.fromJson(
        _safeMap(json['application_type']),
      ),
      status: Status.fromJson(_safeMap(json['status'])),
      reviewStatus: Status.fromJson(_safeMap(json['review_status'])),
      reApplication: _parseBool(json['re_application']),
      steps: _parseList<Step>(json['steps'], Step.fromJsonSafe),
      invoices: _parseList<dynamic>(json['invoices'], null),
      fees: _parseList<dynamic>(json['fees'], null),
      actionLog: _parseList<ActionLog>(
        json['action_log'],
        ActionLog.fromJsonSafe,
      ),
      oldApplications: _parseList<dynamic>(json['old_applications'], null),
      documents: _parseList<DocumentElement>(
        json['documents'],
        DocumentElement.fromJsonSafe,
      ),
      cabinetType: _parseString(json['cabinet_type']),
      applicantName: _parseString(json['applicant_name']),
      applicantTin: _parseString(json['applicant_tin']),
      pin: _parseString(json['pin']),
      registrationDate: _parseString(json['registration_date']),
      registrationNumber: _parseString(json['registration_number']),
      number: _parseString(json['number']),
      terminationDate: _parseStringNullable(json['termination_date']),
      changeDate: _parseStringNullable(json['change_date']),
      reviewExpiry: _parseStringNullable(json['review_expiry']),
      correctionExpiry: _parseStringNullable(json['correction_expiry']),
      paymentExpiry: _parseStringNullable(json['payment_expiry']),
      termination: json['termination'],
      uuid: _parseString(json['uuid']),
      registerId: _parseInt(json['register_id']),
      usageFee: _parseBool(json['usage_fee']),
      acts: _parseList<dynamic>(json['acts'], null),
      createdAt: _parseString(json['created_at']),
      deletedAt: _parseStringNullable(json['deleted_at']),
      completedAt: _parseStringNullable(json['completed_at']),
      expiryDate: _parseStringNullable(json['expiry_date']),
      sentDate: _parseStringNullable(json['sent_date']),
      attachments: _parseList<dynamic>(json['attachments'], null),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'sub_id': subId,
    'document': document.toJson(),
    'category': category.toJson(),
    'type': type.toJson(),
    'application_type': applicationType.toJson(),
    'status': status.toJson(),
    'review_status': reviewStatus.toJson(),
    're_application': reApplication,
    'steps': steps.map((e) => e.toJson()).toList(),
    'invoices': invoices,
    'fees': fees,
    'action_log': actionLog.map((e) => e.toJson()).toList(),
    'old_applications': oldApplications,
    'documents': documents.map((e) => e.toJson()).toList(),
    'cabinet_type': cabinetType,
    'applicant_name': applicantName,
    'applicant_tin': applicantTin,
    'pin': pin,
    'registration_date': registrationDate,
    'registration_number': registrationNumber,
    'number': number,
    'termination_date': terminationDate,
    'change_date': changeDate,
    'review_expiry': reviewExpiry,
    'correction_expiry': correctionExpiry,
    'payment_expiry': paymentExpiry,
    'termination': termination,
    'uuid': uuid,
    'register_id': registerId,
    'usage_fee': usageFee,
    'acts': acts,
    'created_at': createdAt,
    'deleted_at': deletedAt,
    'completed_at': completedAt,
    'expiry_date': expiryDate,
    'sent_date': sentDate,
    'attachments': attachments,
  };
}

Map<String, dynamic> _safeMap(dynamic value) =>
    value is Map<String, dynamic> ? value : <String, dynamic>{};

int _parseInt(dynamic v, {int fallback = 0}) {
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v) ?? fallback;
  return fallback;
}

bool _parseBool(dynamic v, {bool fallback = false}) {
  if (v is bool) return v;
  if (v is num) return v != 0;
  if (v is String) {
    final s = v.toLowerCase().trim();
    return s == 'true' || s == '1' || s == 'yes' || s == 'on';
  }
  return fallback;
}

String _parseString(dynamic v, {String fallback = ''}) {
  if (v == null) return fallback;
  return v.toString().trim();
}

String? _parseStringNullable(dynamic v) {
  final s = _parseString(v);
  return s.isEmpty ? null : s;
}

List<T> _parseList<T>(
  dynamic value,
  T? Function(Map<String, dynamic>)? fromJson, {
  List<T> fallback = const [],
}) {
  if (value is! Iterable) return fallback;
  final list = <T>[];
  for (final item in value) {
    if (item is Map<String, dynamic> && fromJson != null) {
      final parsed = fromJson(item);
      if (parsed != null) list.add(parsed);
    } else if (fromJson == null) {
      list.add(item as T);
    }
  }
  return list;
}

// ──────────────────────────────────────────────
// Модели с безопасным парсингом (Safe-версии)
// ──────────────────────────────────────────────

class TypeClass {
  final String? tj;
  final String? ru;
  final String? en;

  TypeClass({this.tj, this.ru, this.en});

  factory TypeClass.fromJson(Map<String, dynamic> json) => TypeClass(
    tj: json['tj'] as String?,
    ru: json['ru'] as String?,
    en: json['en'] as String?,
  );

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

class ApplicationTypeClass {
  final String? key;
  final TypeClass? title;

  ApplicationTypeClass({this.key, this.title});

  factory ApplicationTypeClass.fromJson(Map<String, dynamic> json) =>
      ApplicationTypeClass(
        key: json['key'] as String?,
        title:
            json['title'] != null
                ? TypeClass.fromJson(_safeMap(json['title']))
                : null,
      );

  Map<String, dynamic> toJson() => {
    if (key != null) 'key': key,
    if (title != null) 'title': title!.toJson(),
  };
}

class Category {
  final TypeClass title;
  final String iconId;
  final dynamic gradientStartColor;
  final dynamic gradientEndColor;

  Category({
    required this.title,
    this.iconId = '',
    this.gradientStartColor,
    this.gradientEndColor,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    title: TypeClass.fromJson(_safeMap(json['title'])),
    iconId: _parseString(json['icon_id']),
    gradientStartColor: json['gradient_start_color'],
    gradientEndColor: json['gradient_end_color'],
  );

  Map<String, dynamic> toJson() => {
    'title': title.toJson(),
    'icon_id': iconId,
    if (gradientStartColor != null) 'gradient_start_color': gradientStartColor,
    if (gradientEndColor != null) 'gradient_end_color': gradientEndColor,
  };
}

class Status {
  final String key;
  final TypeClass title;
  final String backgroundColor;
  final String? can;

  Status({
    this.key = '',
    required this.title,
    this.backgroundColor = '',
    this.can,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    key: _parseString(json['key']),
    title: TypeClass.fromJson(_safeMap(json['title'])),
    backgroundColor: _parseString(json['background_color']),
    can: json['can'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'key': key,
    'title': title.toJson(),
    'background_color': backgroundColor,
    if (can != null) 'can': can,
  };
}

class ActionLog {
  final String date;
  final Status oldReviewStatus;
  final Status reviewStatus;
  final String user;

  ActionLog({
    required this.date,
    required this.oldReviewStatus,
    required this.reviewStatus,
    required this.user,
  });

  factory ActionLog.fromJsonSafe(Map<String, dynamic> json) => ActionLog(
    date: _parseString(json['date']),
    oldReviewStatus: Status.fromJson(_safeMap(json['old_review_status'])),
    reviewStatus: Status.fromJson(_safeMap(json['review_status'])),
    user: _parseString(json['user']),
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'old_review_status': oldReviewStatus.toJson(),
    'review_status': reviewStatus.toJson(),
    'user': user,
  };
}

class FileClass {
  final int fileId;
  final String name;
  final String extension;
  final int size;
  final String downloadUri;

  FileClass({
    required this.fileId,
    required this.name,
    required this.extension,
    required this.size,
    required this.downloadUri,
  });

  factory FileClass.fromJsonSafe(Map<String, dynamic> json) => FileClass(
    fileId: _parseInt(json['fileId']),
    name: _parseString(json['name']),
    extension: _parseString(json['extension']),
    size: _parseInt(json['size']),
    downloadUri: _parseString(json['download_uri']),
  );

  Map<String, dynamic> toJson() => {
    'fileId': fileId,
    'name': name,
    'extension': extension,
    'size': size,
    'download_uri': downloadUri,
  };
}

class Step {
  final int position;
  final TypeClass title;
  final String type;
  final List<Group> groups;

  Step({
    required this.position,
    required this.title,
    required this.type,
    required this.groups,
  });

  factory Step.fromJsonSafe(Map<String, dynamic> json) => Step(
    position: _parseInt(json['position']),
    title: TypeClass.fromJson(_safeMap(json['title'])),
    type: _parseString(json['type'], fallback: 'unknown'),
    groups: _parseList<Group>(json['groups'], Group.fromJsonSafe),
  );

  Map<String, dynamic> toJson() => {
    'position': position,
    'title': title.toJson(),
    'type': type,
    'groups': groups.map((e) => e.toJson()).toList(),
  };
}

class Group {
  final int position;
  final TypeClass title;
  final bool groupDuplicate;
  final List<Field> fields;

  Group({
    required this.position,
    required this.title,
    required this.groupDuplicate,
    required this.fields,
  });

  factory Group.fromJsonSafe(Map<String, dynamic> json) => Group(
    position: _parseInt(json['position']),
    title: TypeClass.fromJson(_safeMap(json['title'])),
    groupDuplicate: _parseBool(json['group_duplicate']),
    fields: _parseList<Field>(json['fields'], Field.fromJsonSafe),
  );

  Map<String, dynamic> toJson() => {
    'position': position,
    'title': title.toJson(),
    'group_duplicate': groupDuplicate,
    'fields': fields.map((e) => e.toJson()).toList(),
  };
}

class DocumentElement {
  final TypeClass organization;
  final String? number;
  final String date;
  final String deadline;
  final FileClass? file;
  final String status;
  final List<Step> steps;
  final ApplicationTypeClass type;

  DocumentElement({
    required this.organization,
    this.number,
    required this.date,
    required this.deadline,
    this.file,
    required this.status,
    required this.steps,
    required this.type,
  });

  factory DocumentElement.fromJsonSafe(Map<String, dynamic> json) =>
      DocumentElement(
        organization: TypeClass.fromJson(_safeMap(json['organization'])),
        number: _parseStringNullable(json['number']),
        date: _parseString(json['date']),
        deadline: _parseString(json['deadline']),
        file:
            json['file'] is Map
                ? FileClass.fromJsonSafe(_safeMap(json['file']))
                : null,
        status: _parseString(json['status'], fallback: 'unknown'),
        steps: _parseList<Step>(json['steps'], Step.fromJsonSafe),
        type: ApplicationTypeClass.fromJson(_safeMap(json['type'])),
      );

  Map<String, dynamic> toJson() => {
    'organization': organization.toJson(),
    'number': number,
    'date': date,
    'deadline': deadline,
    if (file != null) 'file': file!.toJson(),
    'status': status,
    'steps': steps.map((e) => e.toJson()).toList(),
    'type': type.toJson(),
  };
}

class Field {
  final int position;
  final TypeClass? title;
  final TypeEnum? type;
  final String? key;
  final String? value;
  final TypeClass? option;
  final List<DuplicableValue> duplicableValues;

  Field({
    required this.position,
    this.title,
    this.type,
    this.key,
    this.value,
    this.option,
    this.duplicableValues = const [],
  });

  factory Field.fromJsonSafe(Map<String, dynamic> json) => Field(
    position: _parseInt(json['position']),
    title:
        json['title'] != null
            ? TypeClass.fromJson(_safeMap(json['title']))
            : null,
    type: _parseTypeEnum(json['type']),
    key: _parseStringNullable(json['key']),
    value: _parseStringNullable(json['value']),
    option:
        json['option'] != null
            ? TypeClass.fromJson(_safeMap(json['option']))
            : null,
    duplicableValues: _parseList<DuplicableValue>(
      json['duplicable_values'],
      DuplicableValue.fromJsonSafe,
    ),
  );

  Map<String, dynamic> toJson() => {
    'position': position,
    if (title != null) 'title': title!.toJson(),
    if (type != null) 'type': typeEnumValues.reverse[type],
    if (key != null) 'key': key,
    if (value != null) 'value': value,
    if (option != null) 'option': option!.toJson(),
    'duplicable_values': duplicableValues.map((e) => e.toJson()).toList(),
  };
}

class DuplicableValue {
  final int position;
  final String value;

  DuplicableValue({required this.position, required this.value});

  factory DuplicableValue.fromJsonSafe(Map<String, dynamic> json) =>
      DuplicableValue(
        position: _parseInt(json['position']),
        value: _parseString(json['value']),
      );

  Map<String, dynamic> toJson() => {'position': position, 'value': value};
}

enum TypeEnum {
  dropDown('DROP_DOWN'),
  file('FILE'),
  input('INPUT'),
  radioButton('RADIO_BUTTON'),
  switch_('SWITCH'),
  textArea('TEXT_AREA'),
  textBlock('TEXT_BLOCK'),
  requirement('REQUIREMENTS'),
  payment('PAYMENT'),
  unknown('UNKNOWN');

  final String value;
  const TypeEnum(this.value);
}

final typeEnumValues = _TypeEnumValues({
  'DROP_DOWN': TypeEnum.dropDown,
  'FILE': TypeEnum.file,
  'INPUT': TypeEnum.input,
  'RADIO_BUTTON': TypeEnum.radioButton,
  'SWITCH': TypeEnum.switch_,
  'TEXT_AREA': TypeEnum.textArea,
  'TEXT_BLOCK': TypeEnum.textBlock,
});

TypeEnum? _parseTypeEnum(dynamic value) {
  if (value is! String) return null;
  return typeEnumValues.map[value] ?? TypeEnum.unknown;
}

class _TypeEnumValues<T> {
  final Map<String, T> map;
  late final Map<T, String> reverse;

  _TypeEnumValues(this.map) {
    reverse = map.map((k, v) => MapEntry(v, k));
  }
}
