import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/consts/global_providers/locale_provider.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';
import 'package:khizmat_new/feature/home/data/models/step_requirement_model.dart';
import 'package:khizmat_new/feature/home/data/repos/shagi_polucheniye_uslugi_service.dart';

class StepsInfoAndRequirement {
  int applicationId;
  List<ShagiPolucheniyeUslugiModel> stepsInfo;
  StepRequirementModel stepRequirement;
  Map<String, List<ChoiceOption>> dropDownOptions;

  StepsInfoAndRequirement({
    required this.applicationId,
    required this.stepsInfo,
    required this.stepRequirement,
    required this.dropDownOptions,
  });
}

final shagiProvider = FutureProvider.family<StepsInfoAndRequirement, int>((
  ref,
  documentId,
) async {
  // final repo = CategoryService();
  final repo1 = ShagiPolucheniyeUslugiService();
  final currentLocale = ref.watch(localeProvider);

  // 1. Запускаем форму
  final application = await repo1.startPostForm(documentId);
  final applicationId = application.data.applicationId;

  // 2. Zagrughaem ШАГИ ТОЛЬКО ДЛЯ ЭТОГО documentId
  final stepResponse = await repo1.getStepsWithInfo(documentId, applicationId);

  // 3. Zagrughaem требования
  final stepRequirement = await repo1.getStepRequirement(documentId);

  // 4. Собираем actionKey из ЭТОГО документа
  final actionKeys =
      stepResponse.data.fieldGroups
          .expand((group) => group.fields)
          .where(
            (field) =>
                field.type == "DROP_DOWN" &&
                // field.actionKey!=null &&
                field.choiceOptionsAuto != null,
          )
          .map((field) => field.choiceOptionsAuto!)
          .toSet()
          .toList();

          for (var element in actionKeys) {
            print("******CHOICEOPTIONAUTO**************");
            print(element);
            print("********************");

          }
  // final actionKeysForRef =
  //     stepResponse.data.fieldGroups
  //         .expand((group) => group.fields)
  //         .where(
  //           (field) =>
  //               field.type == "DROP_DOWN" &&
  //               field.actionKey!=null
  //         )
  //         .map((field) => field.actionKey!)
  //         .toSet()
  //         .toList();

  //         for (var element in actionKeys) {
  //           print("********************");
  //           print(element);
  //           print("********************");

  //         }

  // 5. Параллельно zagrughaem все DropDown
  final dropDownFutures = actionKeys.map((actionKey) {
    return repo1.getDropDownInfo(applicationId, currentLocale, actionKey);
  });

  // final refDropdowns=actionKeysForRef.map((action){
  //   return repo1.getSubRegionDropDown(applicationId, currentLocale, action, , code)
  // })

  final dropDownResponses = await Future.wait(dropDownFutures);

  // 6. Собираем в Map
  final dropDownOptionsMap = <String, List<ChoiceOption>>{};
  for (final resp in dropDownResponses) {
    for (final event in resp.data.fieldEvents) {
      dropDownOptionsMap[event.actionId] = event.choiceOptions;
      print("/////////ACTIONID/////////////");
      print(event.actionId);
      print("//////////////////////");

    }
  }

  return StepsInfoAndRequirement(
    applicationId: applicationId,
    stepsInfo: [stepResponse],
    stepRequirement: stepRequirement,
    dropDownOptions: dropDownOptionsMap,
  );
});


/////////////////////////////////
// final shagiProvider = FutureProvider.family<StepsInfoAndRequirement, int>((ref, docId) async {
//   final repo = ShagiPolucheniyeUslugiService();
//   final locale = ref.watch(localeProvider);

//   // 1. Запускаем форму
//   final applicationResp = await repo.startPostForm(docId);
//   final applicationId = applicationResp.data.applicationId;

//   // 2. Получаем шаги (с fieldGroups и полями)
//   final stepsResp = await repo.getStepsWithInfo(docId, applicationId);

//   // 3. Получаем требования к шагам
//   final stepRequirement = await repo.getStepRequirement(docId);

//   // 4. Собираем ВСЕ actionKey, где choiceOptionsAuto НЕ пустой
//   final Set<String> actionKeys = {};

//   for (final group in stepsResp.data.fieldGroups) {
//     for (final field in group.fields) {
//       final autoKey = field.choiceOptionsAuto;
//       if (autoKey != null && autoKey.trim().isNotEmpty) {
//         actionKeys.add(autoKey.trim());
//       }
//     }
//   }

//   // 5. Если есть что грузить — параллельно загружаем ВСЕ dropdown-ы
//   Map<String, List<DropDownChoiceOption>> dropDownOptions = {};

//   if (actionKeys.isNotEmpty) {
//     final futures = actionKeys.map((key) =>
//         repo.getDropDownInfo(applicationId, locale, key));

//     final responses = await Future.wait(futures);

//     for (final resp in responses) {
//       if (resp.data.fieldEvents.isNotEmpty) {
//         for (final event in resp.data.fieldEvents) {
//           // event.key — это ключ поля, которое зависит от этого actionKey
//           dropDownOptions[event.key] = event.choiceOptions;
//         }
//       }
//     }
//   }

//   // 6. Возвращаем всё вместе
//   return StepsInfoAndRequirement(
//     applicationId: applicationId,
//     stepsInfo: [stepsResp], // или просто stepsResp, если не List нужен
//     stepRequirement: stepRequirement,
//     dropDownOptions: dropDownOptions,
//   );
// });

/*
// allSteps = List<ShagiPolucheniyeUslugiModel>
  final allActionKeys =
      allSteps
          .expand((step) => step.data.fieldGroups)
          .expand((group) => group.fields)
          .map((field) => field.actionKey)
          .where((key) => key != null && key.isNotEmpty)
          .toSet()
          .toList();

  print(allActionKeys);
  // Получаем все поля из allSteps
  final allFields =
      allSteps
          .expand((step) => step.data.fieldGroups)
          .expand((group) => group.fields)
          .toList();

  // Преобразуем в FieldValueModel
  final List<FieldValueModel> fieldValues =
      allFields.map((field) {
        final value = formFamilyWatch.getValue(
          field.key,
        ); // текущее выбранное значение
        return FieldValueModel(
          key:
              field
                  .actionId!, // или field.key, если API ожидает именно ключ поля
          value: value ?? '',
        );
      }).toList();

  //DROPDOWNOPTIONS
  final dropDownOptionsMap = <String, List<DropDownChoiceOption>>{};
  for (var actionKey in allActionKeys) {
    if (actionKey == null || actionKey.isEmpty)
      continue; // пропускаем null или пустой
    final dropDownOptions = await repo1.getDropDownInfo(
      applicationId,
      currentLocale,
      actionKey,
      fieldValues, // если требуется
    );

    // if (dropDownOptions.data.fieldEvents == null) continue;

    for (var fieldEvent in dropDownOptions.data.fieldEvents) {
      dropDownOptionsMap[fieldEvent.key] = fieldEvent.choiceOptions;
    }
  }*/