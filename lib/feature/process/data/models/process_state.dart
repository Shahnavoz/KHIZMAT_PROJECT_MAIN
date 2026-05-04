import 'package:khizmat_new/feature/home/data/models/drop_down_options_model.dart';
import 'package:khizmat_new/feature/home/data/models/field_value_model.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';
import 'package:khizmat_new/feature/home/data/models/step_requirement_model.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_specialization.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ProcessState
// ─────────────────────────────────────────────────────────────────────────────
//
// React equivalent: modules/process/reducer.ts  IState
//
// The server drives the "current step" via [lastStepId] (= step.id, not
// step.position or list index).  Every process/update and process/resume
// response returns a new [lastStepId].  The UI derives the visual index from
// this value — never from a local counter.

class ProcessState {
  /// The running application's ID returned by POST /process/start.
  final int applicationId;

  /// The document (service) this application belongs to.
  final int documentId;

  /// Server status string: "IN_PROCESS" | "COMPLETED" | etc.
  final String status;

  /// True once the server sets is_complete = true.
  final bool isComplete;

  /// The *id* of the step the server considers current (= data.last_step_id).
  /// This is NOT a list index – use [currentStepIndex] for that.
  final int currentStepId;

  /// Full form schema: steps + fieldGroups + fields.
  /// Reuses the existing model so nothing in StepContentWidget changes.
  final ShagiPolucheniyeUslugiModel info;

  /// Requirements list for the REQUIREMENTS step type.
  final StepRequirementModel requirements;

  /// Specialization items for the SPECIALIZATION step type.
  final List<MySpecialization> specializations;

  /// Server-prefilled field values (returned alongside process responses).
  final List<FieldValueModel> fieldValues;

  /// Dropdown options keyed by actionId (populated in parallel at load time).
  final Map<String, List<ChoiceOption>> dropDownOptions;

  /// Runtime field property overrides from actionEvent responses.
  ///
  /// Keyed by [FieldEvent.actionId].  When the server's actionEvent response
  /// includes `visible`, `disabled`, `required`, or `value` for a field, those
  /// override the schema defaults.
  ///
  /// React equivalent: actionEventList mapper merges properties onto field
  /// entities in Redux (modules/process/mappers.ts → actionEventList).
  final Map<String, FieldEvent> fieldOverrides;

  /// True while an API call (next / back / cancel) is in flight.
  final bool isSubmitting;

  /// Non-null when an API call failed; cleared on the next successful call.
  final String? submitError;

  const ProcessState({
    required this.applicationId,
    required this.documentId,
    required this.status,
    required this.isComplete,
    required this.currentStepId,
    required this.info,
    required this.requirements,
    required this.specializations,
    required this.fieldValues,
    required this.dropDownOptions,
    this.fieldOverrides = const {},
    this.isSubmitting = false,
    this.submitError,
  });

  // ── Derived helpers ────────────────────────────────────────────────────

  /// Steps sorted by position, matching the visual order in the step-bar.
  List<StepInfo> get sortedSteps {
    final steps = List<StepInfo>.from(info.data.steps);
    steps.sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));
    return steps;
  }

  /// 0-based index of the step whose position == [currentStepId].
  /// The server's last_step_id is a position (1, 2, 3...), not a database id.
  /// Returns 0 if not found (safe default).
  int get currentStepIndex {
    final idx = sortedSteps.indexWhere((s) => s.position == currentStepId);
    return idx >= 0 ? idx : 0;
  }

  /// The currently active step, or the first step as a fallback.
  StepInfo? get currentStep {
    final steps = sortedSteps;
    if (steps.isEmpty) return null;
    final idx = currentStepIndex;
    return idx < steps.length ? steps[idx] : steps.last;
  }

  /// Convenience: FieldGroups that belong to the current step.
  List<FieldGroup> get currentStepGroups {
    final step = currentStep;
    if (step == null) return [];
    return info.data.fieldGroups
        .where((g) => g.stepId == step.id)
        .toList()
      ..sort((a, b) => (a.position ?? 0).compareTo(b.position ?? 0));
  }

  /// Step position (1-based number used in /process/update as step_id param).
  /// The React API call uses `position` not `id` as the step_id query param.
  int get currentStepPosition => currentStep?.position ?? 0;

  /// True if the user is on the last step.
  bool get isLastStep => currentStepIndex >= sortedSteps.length - 1;

  /// The position value of the previous step (used in Back calls).
  int? get previousStepPosition {
    final idx = currentStepIndex;
    if (idx <= 0) return null;
    return sortedSteps[idx - 1].position;
  }

  /// The previous step object (used in Back calls to get its database id).
  StepInfo? get previousStep {
    final idx = currentStepIndex;
    if (idx <= 0) return null;
    return sortedSteps[idx - 1];
  }

  // ── copyWith ───────────────────────────────────────────────────────────

  ProcessState copyWith({
    int? applicationId,
    int? documentId,
    String? status,
    bool? isComplete,
    int? currentStepId,
    ShagiPolucheniyeUslugiModel? info,
    StepRequirementModel? requirements,
    List<MySpecialization>? specializations,
    List<FieldValueModel>? fieldValues,
    Map<String, List<ChoiceOption>>? dropDownOptions,
    Map<String, FieldEvent>? fieldOverrides,
    bool? isSubmitting,
    String? submitError,
    bool clearError = false,
  }) {
    return ProcessState(
      applicationId: applicationId ?? this.applicationId,
      documentId: documentId ?? this.documentId,
      status: status ?? this.status,
      isComplete: isComplete ?? this.isComplete,
      currentStepId: currentStepId ?? this.currentStepId,
      info: info ?? this.info,
      requirements: requirements ?? this.requirements,
      specializations: specializations ?? this.specializations,
      fieldValues: fieldValues ?? this.fieldValues,
      dropDownOptions: dropDownOptions ?? this.dropDownOptions,
      fieldOverrides: fieldOverrides ?? this.fieldOverrides,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitError: clearError ? null : (submitError ?? this.submitError),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ProcessApiData  (raw API response models)
// ─────────────────────────────────────────────────────────────────────────────

/// Parsed core fields returned by start / update / resume / cancel responses.
/// React equivalent: IEntity.Process (modules/process/types.ts)
class ProcessApiData {
  final int applicationId;
  final int documentId;
  final String applicationType;
  final int lastStepId;
  final bool isComplete;
  final String status;
  final List<FieldValueModel> values;

  const ProcessApiData({
    required this.applicationId,
    required this.documentId,
    required this.applicationType,
    required this.lastStepId,
    required this.isComplete,
    required this.status,
    required this.values,
  });

  factory ProcessApiData.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final rawValues = data['values'] as List<dynamic>? ?? [];

    return ProcessApiData(
      applicationId: (data['application_id'] as num?)?.toInt() ?? 0,
      documentId: (data['document_id'] as num?)?.toInt() ?? 0,
      applicationType: data['application_type'] as String? ?? '',
      lastStepId: (data['last_step_id'] as num?)?.toInt() ?? 0,
      isComplete: data['is_complete'] as bool? ?? false,
      status: data['status'] as String? ?? '',
      values: rawValues
          .map((v) {
            final key = v['key'] as String? ?? '';
            // Top-level value first; if empty fall back to duplicable_values[0].value
            // (React reads invoice/payment fields from duplicable_values[index].value).
            final topValue = v['value']?.toString() ?? '';
            final duplicables = v['duplicable_values'] as List<dynamic>? ?? [];
            final value = topValue.isNotEmpty
                ? topValue
                : (duplicables.isNotEmpty
                    ? (duplicables.first['value']?.toString() ?? '')
                    : '');
            return FieldValueModel(key: key, value: value);
          })
          .toList(),
    );
  }
}
