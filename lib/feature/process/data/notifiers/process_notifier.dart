import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khizmat_new/feature/home/data/models/drop_down_options_model.dart';
import 'package:khizmat_new/feature/home/data/models/field_value_model.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';
import 'package:khizmat_new/feature/process/data/models/process_state.dart';
import 'package:khizmat_new/feature/process/data/services/process_api_service.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ProcessNotifier
// ─────────────────────────────────────────────────────────────────────────────
//
// React equivalent: modules/process/sagas.ts  (Start, Update, Back, Resume,
//                  Cancel, ActionEvent) + modules/process/reducer.ts
//
// Key design rule (mirrors React):
//   The CURRENT STEP is always driven by the server's [last_step_id].
//   Never increment a local counter; always read [ProcessApiData.lastStepId]
//   after every API call and update [ProcessState.currentStepId].
//
// The notifier state is AsyncValue<ProcessState> so the UI can show
// loading / error / data using the standard `.when(...)` pattern.

class ProcessNotifier extends AutoDisposeNotifier<AsyncValue<ProcessState>> {
  final _service = ProcessApiService();

  @override
  AsyncValue<ProcessState> build() {
    // Start in loading state; caller must invoke [start] or [resume].
    return const AsyncValue.loading();
  }

  // ── Start ────────────────────────────────────────────────────────────────

  /// React: Start saga
  ///
  /// 1. POST /process/start          → applicationId, lastStepId
  /// 2. GET  /reference/documents/process → schema (steps + fieldGroups)
  /// 3. GET  /reference/documents/requirement → requirements list
  /// 4. POST /action (parallel)      → populate all DROP_DOWN options
  ///
  /// Navigation: React pushes to /application/:id after start.
  /// Flutter: caller stays on StepsPage (no navigation needed).
  Future<void> start(int documentId, Locale locale) async {
    state = const AsyncValue.loading();

    try {
      // 1. Start the application
      final process = await _service.start(documentId);

      // 2. Load schema
      final info = await _service.info(
        documentId: documentId,
        applicationId: process.applicationId,
      );

      // 3. Load requirements and specializations in parallel
      final reqFuture = _service.requirements(documentId: documentId);
      final specFuture = _service.fetchSpecializations(documentId: documentId);
      final requirements = await reqFuture;
      final specializationResponse = await specFuture;

      // 4. Pre-load all DROP_DOWN options in parallel
      final loaded = await _loadDropDownOptions(
        applicationId: process.applicationId,
        info: info,
        locale: locale,
        fieldValues: process.values,
      );

      state = AsyncValue.data(
        ProcessState(
          applicationId: process.applicationId,
          documentId: documentId,
          status: process.status,
          isComplete: process.isComplete,
          currentStepId: process.lastStepId,
          info: info,
          requirements: requirements,
          specializations: specializationResponse.data.specializations,
          fieldValues: process.values,
          dropDownOptions: loaded.options,
          fieldOverrides: loaded.overrides,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // ── Resume (open existing application) ───────────────────────────────────

  /// React: Resume saga
  ///
  /// Called when navigating to an existing application from the history list.
  Future<void> resume(int applicationId, Locale locale) async {
    state = const AsyncValue.loading();

    try {
      // Resume tells the server we're re-opening the app; returns current step
      final process = await _service.resume(applicationId);

      // Load the schema
      final info = await _service.info(
        documentId: process.documentId,
        applicationId: applicationId,
      );

      final reqFuture = _service.requirements(documentId: process.documentId);
      final specFuture = _service.fetchSpecializations(documentId: process.documentId);
      final requirements = await reqFuture;
      final specializationResponse = await specFuture;

      final loaded = await _loadDropDownOptions(
        applicationId: applicationId,
        info: info,
        locale: locale,
        fieldValues: process.values,
      );

      state = AsyncValue.data(
        ProcessState(
          applicationId: applicationId,
          documentId: process.documentId,
          status: process.status,
          isComplete: process.isComplete,
          currentStepId: process.lastStepId,
          info: info,
          requirements: requirements,
          specializations: specializationResponse.data.specializations,
          fieldValues: process.values,
          dropDownOptions: loaded.options,
          fieldOverrides: loaded.overrides,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // ── Next (advance to next step) ───────────────────────────────────────────

  /// React: Update saga
  ///
  /// Sends the current step's field values to the server.
  /// The server validates, saves, and returns the next [last_step_id].
  /// [currentStepId] is updated from the response — never incremented locally.
  Future<bool> next({
    required List<FieldValueModel> values,
    // The visual step's position — passed explicitly from the UI so that
    // the correct step_id is sent even when the server's last_step_id hasn't
    // yet advanced to the next step.  React does the same: stepId = step.number
    // (the currently shown step's position), NOT the server's lastStepId.
    int? stepPosition,
  }) async {
    final current = state.valueOrNull;
    if (current == null) return false;

    state = AsyncValue.data(
      current.copyWith(isSubmitting: true, clearError: true),
    );

    try {
      final response = await _service.update(
        applicationId: current.applicationId,
        stepId: stepPosition ?? current.currentStepPosition,
        values: values,
      );

      // Merge server-returned values into accumulated values (don't replace).
      // React: the saga accumulates all field values across steps; the server
      // only returns values it knows about in the response, but we must keep
      // every prior step's values so subsequent update calls send them all.
      final mergedFieldValues = {
        for (final fv in current.fieldValues) fv.key: fv,
        for (final fv in response.values) fv.key: fv,
      };

      state = AsyncValue.data(
        current.copyWith(
          currentStepId: response.lastStepId,
          isComplete: response.isComplete,
          fieldValues: mergedFieldValues.values.toList(),
          isSubmitting: false,
          clearError: true,
        ),
      );

      return true;
    } catch (e) {
      state = AsyncValue.data(
        current.copyWith(
          isSubmitting: false,
          submitError: e.toString(),
        ),
      );
      return false;
    }
  }

  // ── Back ──────────────────────────────────────────────────────────────────

  /// React: Back saga
  ///
  /// Sends a process/update call with [change_step_id] to tell the server
  /// which step to revert to.  The server returns the new [last_step_id].
  Future<void> back() async {
    final current = state.valueOrNull;
    if (current == null) return;

    final targetStep = current.previousStep;
    if (targetStep == null) return; // already at first step

    state = AsyncValue.data(
      current.copyWith(isSubmitting: true, clearError: true),
    );

    try {
      final response = await _service.back(
        applicationId: current.applicationId,
        currentStepId: current.currentStepPosition,
        targetStepId: targetStep.position ?? 0,
      );

      // React (reducer): { ...state.info.fields.entities, ...values }
      // React MERGES existing entities with server-returned values on back —
      // never replaces. Flutter must do the same so previously-accumulated
      // field values (from earlier steps) survive a back navigation.
      final mergedFieldValues = {
        for (final fv in current.fieldValues) fv.key: fv,
        for (final fv in response.values) fv.key: fv,
      };
      state = AsyncValue.data(
        current.copyWith(
          currentStepId: response.lastStepId,
          fieldValues: mergedFieldValues.values.toList(),
          isSubmitting: false,
          clearError: true,
        ),
      );
    } catch (e) {
      state = AsyncValue.data(
        current.copyWith(
          isSubmitting: false,
          submitError: e.toString(),
        ),
      );
    }
  }

  // ── Cancel ────────────────────────────────────────────────────────────────

  /// React: Cancel saga
  Future<bool> cancel() async {
    final current = state.valueOrNull;
    if (current == null) return false;

    state = AsyncValue.data(
      current.copyWith(isSubmitting: true, clearError: true),
    );

    try {
      await _service.cancel(current.applicationId);
      // Reset to loading so the page knows the process ended
      state = const AsyncValue.loading();
      return true;
    } catch (e) {
      state = AsyncValue.data(
        current.copyWith(
          isSubmitting: false,
          submitError: e.toString(),
        ),
      );
      return false;
    }
  }

  // ── Reload requirements (with selected specialization IDs) ───────────────

  /// React: Requirements.tsx calls useRequirements({ documentId, specializationIds })
  /// which dispatches Requirements.request with the currently selected specialization IDs.
  /// In Flutter we call this when entering the REQUIREMENTS step so we get the
  /// exact same filtered list the server will validate against.
  Future<void> reloadRequirements({required List<String> specializationIds}) async {
    final current = state.valueOrNull;
    if (current == null) return;
    try {
      final requirements = await _service.requirements(
        documentId: current.documentId,
        specializationIds: specializationIds,
      );
      state = AsyncValue.data(current.copyWith(requirements: requirements));
    } catch (e) {
      print('[reloadRequirements] error: $e');
      // Non-fatal — keep existing requirements list
    }
  }

  // ── Refresh dropdown options (after ActionEvent) ─────────────────────────

  /// Called after a parent dropdown changes (e.g. selecting a region
  /// triggers reloading the district list) or after TIN search.
  ///
  /// React: ActionEvent saga.
  ///
  /// Returns a [Map<String,String>] of auto-fill values to apply to the form
  /// (e.g. vehicle brand, year after selecting a vehicle by TIN).
  Future<Map<String, String>> refreshDropDown({
    required String actionKey,
    required String lang,
    List<Map<String, String>>? fields,
  }) async {
    final current = state.valueOrNull;
    if (current == null) return {};

    try {
      final result = await _service.actionEvent(
        applicationId: current.applicationId,
        lang: lang,
        actionKey: actionKey,
        fields: fields,
      );

      // Update dropdown option cache AND field property overrides
      final newOptions = Map<String, List<ChoiceOption>>.from(
        current.dropDownOptions,
      );
      final newOverrides = Map<String, FieldEvent>.from(
        current.fieldOverrides,
      );
      for (final event in result.data.fieldEvents) {
        print('[refreshDropDown] event: actionId=${event.actionId} options=${event.choiceOptions.length} value=${event.value}');
        if (event.actionId.isNotEmpty) {
          // Don't overwrite an existing non-empty options list with an empty one.
          // The server returns empty choice_options for the parent (triggering)
          // dropdown in a cascade response — we must keep its car list visible
          // so the selected value still resolves to a label in the widget.
          final existing = newOptions[event.actionId];
          final hasExistingOptions = existing != null && existing.isNotEmpty;
          if (event.choiceOptions.isNotEmpty || !hasExistingOptions) {
            newOptions[event.actionId] = event.choiceOptions;
          }
          if (event.hasOverrides) {
            newOverrides[event.actionId] = event;
          }
        }
      }

      state = AsyncValue.data(current.copyWith(
        dropDownOptions: newOptions,
        fieldOverrides: newOverrides,
      ));

      // Return auto-fill values: top-level 'values' array + per-event 'value' fields.
      // React stores both; the server for transport/vehicle puts autofill data in
      // field_events[].value (not in a separate 'values' array).
      final allFills = Map<String, String>.from(result.data.autoFillValues);
      for (final event in result.data.fieldEvents) {
        if (event.actionId.isNotEmpty &&
            event.value != null &&
            event.value!.isNotEmpty) {
          allFills[event.actionId] = event.value!;
        }
      }
      return allFills;
    } catch (e) {
      // Non-fatal: dropdown just won't update
      print('[refreshDropDown] error for actionKey=$actionKey: $e');
      return {};
    }
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  /// Finds all fields with [choiceOptionsAuto] set and loads their options
  /// in parallel.  Each future is individually error-handled so one failure
  /// doesn't prevent the rest from loading.
  ///
  /// Also collects field property overrides (visible/disabled/required/value)
  /// from the actionEvent responses — same as [refreshDropDown] does when the
  /// user manually changes a dropdown.  Without this, fields that are hidden by
  /// default (e.g. APPLICANT_QUANTITY_CATTLE, visible:false in schema) would
  /// never become visible when resuming an application whose parent dropdown
  /// already has a value (e.g. APPLICANT_CELEBRATION_TYPE=OSH_EVENT), because
  /// the parent actionKey fires on load but the visibility override was silently
  /// discarded.  React equivalent: ActionSelect useEffect([value]) fires on
  /// mount and merges visible/disabled/required/value onto the field entity.
  Future<({Map<String, List<ChoiceOption>> options, Map<String, FieldEvent> overrides})>
      _loadDropDownOptions({
    required int applicationId,
    required ShagiPolucheniyeUslugiModel info,
    required Locale locale,
    List<FieldValueModel> fieldValues = const [],
  }) async {
    final allFields = info.data.fieldGroups.expand((g) => g.fields).toList();

    // 1. choiceOptionsAuto keys — pre-load static dropdown lists
    final autoKeys = allFields
        .where((f) => f.type == 'DROP_DOWN' && f.choiceOptionsAuto != null)
        .map((f) => f.choiceOptionsAuto!)
        .toSet()
        .toList();

    // 2. Parent action fields — fire actionKey for fields that already have a value
    //    (React: ActionSelect useEffect([value]) fires on mount with existing value)
    final valueMap = {for (final fv in fieldValues) fv.key: fv.value};
    final parentFields = allFields
        .where((f) =>
            f.type == 'DROP_DOWN' &&
            f.actionKey != null &&
            valueMap.containsKey(f.key) &&
            (valueMap[f.key] ?? '').isNotEmpty)
        .toList();

    // 3. INPUT action fields (e.g. TIN search) — when an INPUT field with
    //    actionKey already has a value (e.g. pre-filled TIN from server or
    //    carried over from a previous step), fire actionEvent so that dependent
    //    dropdowns (e.g. car list) are pre-populated automatically.
    //    React: ActionInput useEffect([value]) fires on mount with existing value.
    final inputParentFields = allFields
        .where((f) =>
            f.type == 'INPUT' &&
            f.actionKey != null &&
            valueMap.containsKey(f.key) &&
            (valueMap[f.key] ?? '').isNotEmpty)
        .toList();

    final optionsMap  = <String, List<ChoiceOption>>{};
    final overridesMap = <String, FieldEvent>{};

    final futures = [
      // choiceOptionsAuto futures
      ...autoKeys.map((key) async {
        // Check if an INPUT field with this actionKey has a stored value.
        // If so, pass it so TIN-dependent car lists are loaded correctly.
        final inputField = inputParentFields
            .where((f) => f.actionKey == key)
            .firstOrNull;
        try {
          final result = await _service.actionEvent(
            applicationId: applicationId,
            lang: locale.languageCode,
            actionKey: key,
            fields: inputField != null
                ? [{'key': inputField.actionId ?? inputField.key, 'value': valueMap[inputField.key]!}]
                : null,
          );
          for (final event in result.data.fieldEvents) {
            if (event.actionId.isNotEmpty) {
              optionsMap[event.actionId] = event.choiceOptions;
              if (event.hasOverrides) {
                overridesMap[event.actionId] = event;
              }
            }
          }
        } catch (e) {
          print('[_loadDropDownOptions] failed for key=$key: $e');
        }
      }),
      // Parent actionKey futures — populate child dropdowns from existing values
      ...parentFields.map((f) async {
        try {
          final result = await _service.actionEvent(
            applicationId: applicationId,
            lang: locale.languageCode,
            actionKey: f.actionKey!,
            fields: [{'key': f.actionId ?? f.key, 'value': valueMap[f.key]!}],
          );
          for (final event in result.data.fieldEvents) {
            if (event.actionId.isNotEmpty) {
              optionsMap[event.actionId] = event.choiceOptions;
              // React: actionEventList merges visible/disabled/required/value onto
              // the field entity — must do the same here so fields that become
              // visible/required based on the parent dropdown value are correctly
              // shown to the user from the very first render.
              if (event.hasOverrides) {
                overridesMap[event.actionId] = event;
              }
            }
          }
        } catch (e) {
          print('[_loadDropDownOptions] parent action failed for ${f.key}: $e');
        }
      }),
      // INPUT parent action futures — fire for TIN/search fields not covered by
      // choiceOptionsAuto (i.e. the INPUT field's actionKey doesn't appear in autoKeys)
      ...inputParentFields
          .where((f) => !autoKeys.contains(f.actionKey))
          .map((f) async {
        try {
          final result = await _service.actionEvent(
            applicationId: applicationId,
            lang: locale.languageCode,
            actionKey: f.actionKey!,
            fields: [{'key': f.actionId ?? f.key, 'value': valueMap[f.key]!}],
          );
          for (final event in result.data.fieldEvents) {
            if (event.actionId.isNotEmpty) {
              optionsMap[event.actionId] = event.choiceOptions;
              if (event.hasOverrides) overridesMap[event.actionId] = event;
            }
          }
        } catch (e) {
          print('[_loadDropDownOptions] input action failed for ${f.key}: $e');
        }
      }),
    ];

    await Future.wait(futures);
    return (options: optionsMap, overrides: overridesMap);
  }
}
