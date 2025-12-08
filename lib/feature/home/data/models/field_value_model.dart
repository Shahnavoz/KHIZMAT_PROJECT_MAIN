class FieldValueModel {
  String key;
  String value;
  List<String> duplicableValues; // добавляем поле

  FieldValueModel({
    required this.key,
    required this.value,
    List<String>? duplicableValues,
  }) : duplicableValues = duplicableValues ?? [];

  factory FieldValueModel.fromJson(Map<String, dynamic> json) =>
      FieldValueModel(
        key: json["key"],
        value: json["value"] ?? "",
        duplicableValues: List<String>.from(json["duplicable_values"] ?? []),
      );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
    "duplicable_values": duplicableValues,
  };
}
