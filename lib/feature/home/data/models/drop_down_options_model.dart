import 'dart:ui';

import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';

class DropDownOptionsModel {
  final int statusCode;
  final String statusMessage;
  final FieldEventsData data;

  DropDownOptionsModel({
    required this.statusCode,
    required this.statusMessage,
    required this.data,
  });

  factory DropDownOptionsModel.fromJson(Map<String, dynamic> json) {
    return DropDownOptionsModel(
      statusCode: json['status_code'] as int,
      statusMessage: json['status_message'] as String,
      data: FieldEventsData.fromJson(json['data']),
    );
  }
}

class FieldEventsData {
  final List<FieldEvent> fieldEvents;

  FieldEventsData({required this.fieldEvents});

  factory FieldEventsData.fromJson(Map<String, dynamic> json) {
    return FieldEventsData(
      fieldEvents:
          (json['field_events'] as List)
              .map((e) => FieldEvent.fromJson(e))
              .toList(),
    );
  }
}

class FieldEvent {
  final String actionId;
  final String? key;
  final List<ChoiceOption> choiceOptions;

  FieldEvent({
    required this.actionId,
    required this.key,
    required this.choiceOptions,
  });

  factory FieldEvent.fromJson(Map<String, dynamic> json) {
    return FieldEvent(
      actionId: json['actionId'] as String,
      key: json['key'] ?? "",
      choiceOptions:
          (json['choice_options'] as List)
              .map((e) => ChoiceOption.fromJson(e))
              .toList(),
    );
  }
}

// class DropDownChoiceOption {
//   final String code;
//   final LocalizedName name;

//   DropDownChoiceOption({required this.code, required this.name});

//   factory DropDownChoiceOption.fromJson(Map<String, dynamic> json) {
//     return DropDownChoiceOption(
//       code: json['code'] as String,
//       name: LocalizedName.fromJson(json['name']),
//     );
//   }
// }

// class LocalizedName {
//   final String tj;
//   final String ru;
//   final String en;

//   LocalizedName({required this.tj, required this.ru, required this.en});

//   factory LocalizedName.fromJson(Map<String, dynamic> json) {
//     return LocalizedName(
//       tj: json['tj'] ?? '',
//       ru: json['ru'] ?? '',
//       en: json['en'] ?? '',
//     );
//   }

//   String getText(Locale locale) {
//     switch (locale.languageCode) {
//       case 'ru':
//         return ru ?? en ?? tj ?? '';
//       case 'en':
//         return en ?? ru ?? tj ?? '';
//       case 'tj':
//       case 'fr':
//         return tj ?? en ?? ru ?? '';
//       default:
//         return ru ?? en ?? tj ?? '';
//     }
//   }


