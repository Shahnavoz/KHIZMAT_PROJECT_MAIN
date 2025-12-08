// 1. Новый провайдер специально для зависимых dropdown-ов
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';
import 'package:khizmat_new/feature/home/data/repos/shagi_polucheniye_uslugi_service.dart';


final selectedParentProvider = StateProvider.family<String?, String>((ref, actionId) => null);

final dependentDropdownProvider = FutureProvider.family<
    Map<String, List<ChoiceOption>>, 
    ({String actionKey,int applicationId, Locale locale,  String parentCode,String parentActionId})
  >((ref, params) async {

  final repo = ShagiPolucheniyeUslugiService();

  
  final response = await repo.getSubRegionDropDown(
    params.applicationId,
    params.locale,
    params.actionKey,
    params.parentCode,
    params.parentActionId, 
  );

  final Map<String, List<ChoiceOption>> result = {};

  for (final event in response.data.fieldEvents) {
    result[event.actionId] = event.choiceOptions;
  }

  return result;
});


