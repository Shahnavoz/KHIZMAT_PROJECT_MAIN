/// Mirrors React IEntity.FieldValue (modules/process/types.ts)
///
/// The server's [duplicable_values] is a positional list used for repeating
/// field groups (groupDuplicate == true in the schema).  React sends:
///   { key, value: "", duplicable_values: [{ position: 1, value: "…" }] }
class DuplicableValue {
  final int position;
  final String value;

  const DuplicableValue({required this.position, required this.value});

  factory DuplicableValue.fromJson(Map<String, dynamic> json) =>
      DuplicableValue(
        position: (json['position'] as num?)?.toInt() ?? 0,
        value: json['value']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {'position': position, 'value': value};
}

class FieldValueModel {
  String key;
  String value;
  List<DuplicableValue> duplicableValues;

  FieldValueModel({
    required this.key,
    required this.value,
    List<DuplicableValue>? duplicableValues,
  }) : duplicableValues = duplicableValues ?? [];

  factory FieldValueModel.fromJson(Map<String, dynamic> json) =>
      FieldValueModel(
        key: json['key'] as String? ?? '',
        value: json['value']?.toString() ?? '',
        duplicableValues:
            (json['duplicable_values'] as List<dynamic>? ?? []).map((d) {
              if (d is Map<String, dynamic>) {
                return DuplicableValue.fromJson(d);
              }
              // Legacy: plain string value
              return DuplicableValue(position: 0, value: d.toString());
            }).toList(),
      );

  Map<String, dynamic> toJson() => {
    'key': key,
    'value': value,
    'duplicable_values':
        duplicableValues.map((d) => d.toJson()).toList(),
  };
}
