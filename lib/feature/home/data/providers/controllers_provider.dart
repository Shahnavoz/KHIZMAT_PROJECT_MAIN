import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/home/data/models/field_value_model.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';

final formProviderFamily = ChangeNotifierProvider.family<FormProvider, int>(
  (ref, documentId) => FormProvider(),
);

class FormProvider extends ChangeNotifier {
  final Map<String, dynamic> fieldValues = {};
  final Map<String, TextEditingController> textControllers = {};
  final Map<String, GlobalKey> fieldKeys = {};

  // Для текстовых полей
  TextEditingController getTextController(String key) {
    if (!textControllers.containsKey(key)) {
      textControllers[key] = TextEditingController();
    }
    return textControllers[key]!;
  }

  GlobalKey getFieldKey(String key) {
    if (!fieldKeys.containsKey(key)) {
      fieldKeys[key] = GlobalKey();
    }
    return fieldKeys[key]!;
  }

  // Установка значения (для switch, radio, dropdown и т.д.)
  void setValue(String key, dynamic value) {
    fieldValues[key] = value;
    notifyListeners();
  }

  // Получение значения
  dynamic getValue<T>(String key) {
    return fieldValues[key];
  }

  ChoiceOption? getRadioChoiceValue(String key, List<ChoiceOption> options) {
    final code = fieldValues[key] as String?;
    if (code == null) return null;
    for (final o in options) {
      if (o.code == code) return o;
    }
    return null;
  }

  // Ochistka (например, при закрытии формы)
  void disposeControllers() {
    for (final controller in textControllers.values) {
      controller.dispose();
    }
    textControllers.clear();
    fieldValues.clear();
  }
}

extension FormProviderExtension on FormProvider {
  /// Получить значения полей для определённого шага
  List<FieldValueModel> getStepFieldValues(List<String> keys) {
    return keys.map((key) {
      final controller = getTextController(key);
      final value =
          controller.text.isNotEmpty ? controller.text : getValue(key);
      if (value == null || (value is String && value.isEmpty)) {
        throw Exception('Поле $key не заполнено');
      }
      return FieldValueModel(key: key, value: value.toString());
    }).toList();
  }
}
