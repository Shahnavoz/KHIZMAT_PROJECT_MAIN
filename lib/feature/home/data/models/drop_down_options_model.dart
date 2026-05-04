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

  /// Auto-fill values returned alongside dropdown option updates.
  /// React: "values" array in ActionEvent response — used to auto-fill
  /// fields like vehicle brand, year, etc. after selecting a vehicle.
  final Map<String, String> autoFillValues;

  FieldEventsData({required this.fieldEvents, this.autoFillValues = const {}});

  factory FieldEventsData.fromJson(Map<String, dynamic> json) {
    // Parse field_events for dropdown options
    final events = (json['field_events'] as List? ?? [])
        .map((e) => FieldEvent.fromJson(e as Map<String, dynamic>))
        .toList();

    // Parse values array for auto-fill (vehicle fields, etc.)
    final rawValues = json['values'] as List? ?? [];
    final autoFills = <String, String>{};
    for (final v in rawValues) {
      if (v is Map) {
        final key = v['key']?.toString() ?? '';
        final value = v['value']?.toString() ?? '';
        if (key.isNotEmpty && value.isNotEmpty) autoFills[key] = value;
      }
    }

    return FieldEventsData(fieldEvents: events, autoFillValues: autoFills);
  }
}

class FieldEvent {
  final String actionId;
  final String? key;
  final List<ChoiceOption> choiceOptions;

  /// Runtime property overrides returned by the server in an actionEvent
  /// response.  null means the server did not send this property — in that
  /// case the schema default (from [Field]) should be used.
  ///
  /// React equivalent: actionEventList mapper merges these onto the field
  /// entity in Redux (visible, disabled, required, value).
  final bool? visible;
  final bool? disabled;
  final bool? required;
  final String? value;

  FieldEvent({
    required this.actionId,
    required this.key,
    required this.choiceOptions,
    this.visible,
    this.disabled,
    this.required,
    this.value,
  });

  factory FieldEvent.fromJson(Map<String, dynamic> json) {
    return FieldEvent(
      actionId: (json['actionId'] ?? json['action_id'])?.toString() ?? '',
      key: json['key']?.toString() ?? '',
      choiceOptions: (json['choice_options'] as List? ?? [])
          .map((e) => ChoiceOption.fromJson(e as Map<String, dynamic>))
          .toList(),
      // Only override when the key is explicitly present in the response.
      // This mirrors React's `pickBy(actionField, v => v !== undefined)`.
      visible: json.containsKey('visible') ? (json['visible'] as bool?) : null,
      disabled: json.containsKey('disabled') ? (json['disabled'] as bool?) : null,
      required: json.containsKey('required') ? (json['required'] as bool?) : null,
      value: json.containsKey('value') ? json['value']?.toString() : null,
    );
  }

  /// True if this event carries any field property overrides beyond options.
  bool get hasOverrides =>
      visible != null || disabled != null || required != null || value != null;
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


