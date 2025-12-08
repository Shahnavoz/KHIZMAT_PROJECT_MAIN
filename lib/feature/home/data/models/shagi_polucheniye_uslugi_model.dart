// To parse this JSON data, do
//
//     final shagiPolucheniyeUslugiModel = shagiPolucheniyeUslugiModelFromJson(jsonString);

import 'dart:convert';
import 'dart:ui';

ShagiPolucheniyeUslugiModel shagiPolucheniyeUslugiModelFromJson(String str) =>
    ShagiPolucheniyeUslugiModel.fromJson(json.decode(str));

String shagiPolucheniyeUslugiModelToJson(ShagiPolucheniyeUslugiModel data) =>
    json.encode(data.toJson());

class ShagiPolucheniyeUslugiModel {
  int statusCode;
  String statusMessage;
  DataShagov data;

  ShagiPolucheniyeUslugiModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory ShagiPolucheniyeUslugiModel.fromJson(Map<String, dynamic> json) =>
      ShagiPolucheniyeUslugiModel(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        data: DataShagov.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "status_message": statusMessage,
    "data": data.toJson(),
  };
}

class DataShagov {
  Document document;
  List<StepInfo> steps;
  List<FieldGroup> fieldGroups;

  DataShagov({
    required this.document,
    required this.steps,
    required this.fieldGroups,
  });

  factory DataShagov.fromJson(Map<String, dynamic> json) => DataShagov(
    document: Document.fromJson(json["document"]),
    steps: List<StepInfo>.from(json["steps"].map((x) => StepInfo.fromJson(x))),
    fieldGroups: List<FieldGroup>.from(
      json["field_groups"].map((x) => FieldGroup.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "document": document.toJson(),
    "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
    "field_groups": List<dynamic>.from(fieldGroups.map((x) => x.toJson())),
  };
}

class Document {
  int? id;
  int? position;
  Description title;
  Description description;
  String type;
  Description typeTitle;
  String icon;

  Document({
    required this.id,
    required this.position,
    required this.title,
    required this.description,
    required this.type,
    required this.typeTitle,
    required this.icon,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["id"] ?? 1,
    position: json["position"] ?? 1,
    title: Description.fromJson(json["title"]),
    description: Description.fromJson(json["description"]),
    type: json["type"],
    typeTitle: Description.fromJson(json["type_title"]),
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "position": position,
    "title": title.toJson(),
    "description": description.toJson(),
    "type": type,
    "type_title": typeTitle.toJson(),
    "icon": icon,
  };
}

class Description {
  String? tj;
  String? ru;
  String? en;

  Description({required this.tj, required this.ru, required this.en});

  factory Description.fromJson(Map<String, dynamic> json) =>
      Description(tj: json["tj"], ru: json["ru"], en: json["en"]);

  Map<String, dynamic> toJson() => {"tj": tj, "ru": ru, "en": en};

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

class FieldGroup {
  String key;
  String type;
  Description title;
  int? position;
  bool groupDuplicate;
  int? stepId;
  List<Field> fields;

  FieldGroup({
    required this.key,
    required this.type,
    required this.title,
    required this.position,
    required this.groupDuplicate,
    required this.stepId,
    required this.fields,
  });

  factory FieldGroup.fromJson(Map<String, dynamic> json) => FieldGroup(
    key: json["key"],
    type: json["type"],
    title: Description.fromJson(json["title"]),
    position: json["position"] ?? 1,
    groupDuplicate: json["group_duplicate"],
    stepId: json["step_id"] ?? 1,
    fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "type": type,
    "title": title.toJson(),
    "position": position,
    "group_duplicate": groupDuplicate,
    "step_id": stepId,
    "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
  };
}

class Field {
  String key;
  String type;
  Description title;
  Description placeholder;
  bool required;
  bool visible;
  bool readonly;
  bool disabled;
  String? actionKey;
  String? choiceOptionsAuto;
  String? actionId;
  int position;
  PositionSide positionSide;
  String dateStart;
  String dateEnd;
  Description textBlockContent;
  List<ChoiceOption> choiceOptions;
  List<dynamic> groupItems;
  Description infoContent;
  String? inputKeyboard;
  String? inputMask;
  String? inputPrefix;
  String? inputSuffix;
  bool? hasInfo;
  String? textBlockColor;
  String? textBlockType;
  int? inputMinLength;
  int? inputMaxLength;

  Field({
    required this.key,
    required this.type,
    required this.title,
    required this.placeholder,
    required this.required,
    required this.visible,
    required this.readonly,
    required this.disabled,
    this.actionKey,
    this.choiceOptionsAuto,
    this.actionId,
    required this.position,
    required this.positionSide,
    required this.dateStart,
    required this.dateEnd,
    required this.textBlockContent,
    required this.choiceOptions,
    required this.groupItems,
    required this.infoContent,
    this.inputKeyboard,
    this.inputMask,
    this.inputPrefix,
    this.inputSuffix,
    this.hasInfo,
    this.textBlockColor,
    this.textBlockType,
    this.inputMinLength,
    this.inputMaxLength,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
    key: json["key"],
    type: json["type"],
    title: Description.fromJson(json["title"]),
    placeholder: Description.fromJson(json["placeholder"]),
    required: json["required"],
    visible: json["visible"],
    readonly: json["readonly"],
    disabled: json["disabled"],
    actionKey: json["actionKey"],
    choiceOptionsAuto: json["choiceOptionsAuto"],
    actionId: json["actionId"],
    position: json["position"],
    positionSide: positionSideValues.map[json["position_side"]]!,
    dateStart: json["date_start"],
    dateEnd: json["date_end"],
    textBlockContent: Description.fromJson(json["text_block_content"]),
    choiceOptions: List<ChoiceOption>.from(
      json["choice_options"].map((x) => ChoiceOption.fromJson(x)),
    ),
    groupItems: List<dynamic>.from(json["group_items"].map((x) => x)),
    infoContent: Description.fromJson(json["infoContent"]),
    inputKeyboard: json["input_keyboard"],
    inputMask: json["input_mask"],
    inputPrefix: json["input_prefix"],
    inputSuffix: json["input_suffix"],
    hasInfo: json["hasInfo"],
    textBlockColor: json["text_block_color"],
    textBlockType: json["text_block_type"],
    inputMinLength: json["input_min_length"],
    inputMaxLength: json["input_max_length"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "type": type,
    "title": title.toJson(),
    "placeholder": placeholder.toJson(),
    "required": required,
    "visible": visible,
    "readonly": readonly,
    "disabled": disabled,
    "actionKey": actionKey,
    "choiceOptionsAuto": choiceOptionsAuto,
    "actionId": actionId,
    "position": position,
    "position_side": positionSideValues.reverse[positionSide],
    "date_start": dateStart,
    "date_end": dateEnd,
    "text_block_content": textBlockContent.toJson(),
    "choice_options": List<dynamic>.from(choiceOptions.map((x) => x.toJson())),
    "group_items": List<dynamic>.from(groupItems.map((x) => x)),
    "infoContent": infoContent.toJson(),
    "input_keyboard": inputKeyboard,
    "input_mask": inputMask,
    "input_prefix": inputPrefix,
    "input_suffix": inputSuffix,
    "hasInfo": hasInfo,
    "text_block_color": textBlockColor,
    "text_block_type": textBlockType,
    "input_min_length": inputMinLength,
    "input_max_length": inputMaxLength,
  };
}

class ChoiceOption {
  String? code;
  Description name;

  ChoiceOption({required this.code, required this.name});

  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
    code: json["code"] ?? "",
    name: Description.fromJson(json["name"]),
  );

  Map<String, dynamic> toJson() => {"code": code, "name": name.toJson()};
}

enum PositionSide { FULL, LEFT }

final positionSideValues = EnumValues({
  "FULL": PositionSide.FULL,
  "LEFT": PositionSide.LEFT,
});

class StepInfo {
  int? id;
  int? position;
  Description title;
  String? type;

  StepInfo({
    required this.id,
    required this.position,
    required this.title,
    required this.type,
  });

  factory StepInfo.fromJson(Map<String, dynamic> json) => StepInfo(
    id: json["id"] ?? 1,
    position: json["position"] ?? 1,
    title: Description.fromJson(json["title"]),
    type: json["type"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "position": position,
    "title": title.toJson(),
    "type": type,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
