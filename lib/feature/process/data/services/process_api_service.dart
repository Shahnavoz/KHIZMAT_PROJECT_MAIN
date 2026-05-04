import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:khizmat_new/core/config/app_config.dart';
import 'package:khizmat_new/core/network/api_client.dart';
import 'package:khizmat_new/feature/home/data/models/drop_down_options_model.dart';
import 'package:khizmat_new/feature/home/data/models/field_value_model.dart';
import 'package:khizmat_new/feature/home/data/models/shagi_polucheniye_uslugi_model.dart';
import 'package:khizmat_new/feature/home/data/models/step_requirement_model.dart';
import 'package:khizmat_new/feature/home/data/models/usluga_specialization.dart';
import 'package:khizmat_new/feature/process/data/models/process_state.dart';

// ─────────────────────────────────────────────────────────────────────────────
// ProcessApiService
// ─────────────────────────────────────────────────────────────────────────────
//
// React equivalent: modules/process/api.ts
//
// Every public method mirrors a function in api.ts.  Types returned are the
// existing Flutter model classes so nothing in the UI or FormProvider changes.

class ProcessApiService {
  final _client = ApiClient();

  // ── Process lifecycle ────────────────────────────────────────────────────

  /// POST /process/start
  /// React: Api.Start
  Future<ProcessApiData> start(int documentId) async {
    final body = await _client.post(AppConfig.processStart(documentId));
    return ProcessApiData.fromJson(body);
  }

  /// POST /process/start?register_id=…&application_type=…
  /// React: Api.StartByRegister
  Future<ProcessApiData> startByRegister(int registerId, String type) async {
    final body = await _client.post(
      AppConfig.processStartByRegister(registerId, type),
    );
    return ProcessApiData.fromJson(body);
  }

  /// POST /process/update  — advance to next step
  /// React: Api.Update
  Future<ProcessApiData> update({
    required int applicationId,
    required int stepId,
    required List<FieldValueModel> values,
  }) async {
    final payload = values.map((v) => v.toJson()).toList();
    final url = AppConfig.processUpdate(applicationId, stepId);
    // DEBUG — remove after fix
    print('===== UPDATE REQUEST =====');
    print('URL: $url');
    print('PAYLOAD: ${jsonEncode(payload)}');
    // Check for any filename values that slipped through (should be IDs for FILE fields)
    for (final v in payload) {
      final val = v['value']?.toString() ?? '';
      if (val.contains('.jpg') || val.contains('.png') || val.contains('.pdf')) {
        print('WARNING: field ${v['key']} has filename value "$val" instead of fileId!');
      }
    }
    print('==========================');
    try {
      final body = await _client.post(url, body: payload);
      print('===== UPDATE RESPONSE =====');
      print(body);
      print('===========================');
      return ProcessApiData.fromJson(body);
    } on ApiException catch (e) {
      // The server occasionally returns HTTP 403 with a valid response body that
      // still contains an advanced last_step_id.  This happens when the step itself
      // was accepted but some global application-level validation triggered.
      // React (axios) receives the same 403, but the error object exposes
      // error.response.data so React can read last_step_id from it.
      // We mirror that: if last_step_id in the error body is > submitted step,
      // treat it as a success so the UI advances correctly.
      if (e.statusCode == 403 && e.body != null) {
        try {
          final data = ProcessApiData.fromJson(e.body!);
          if (data.lastStepId > stepId) {
            print('[update] HTTP 403 but last_step_id=${data.lastStepId} > stepId=$stepId — treating as success');
            return data;
          }
        } catch (_) {
          // Body couldn't be parsed — fall through to rethrow
        }
      }
      rethrow;
    }
  }

  /// POST /process/update with change_step_id — go back to a previous step
  /// React: Api.Back
  Future<ProcessApiData> back({
    required int applicationId,
    required int currentStepId,
    required int targetStepId,
  }) async {
    // React sends null body for Back calls
    final body = await _client.post(
      AppConfig.processBack(
        applicationId,
        currentStepId,
        targetStepId,
      ),
    );
    return ProcessApiData.fromJson(body);
  }

  /// POST /process/resume  — re-open an existing application
  /// React: Api.Resume
  Future<ProcessApiData> resume(int applicationId) async {
    final body = await _client.post(AppConfig.processResume(applicationId));
    return ProcessApiData.fromJson(body);
  }

  /// POST /process/cancel
  /// React: Api.Cancel
  Future<void> cancel(int applicationId) async {
    await _client.post(AppConfig.processCancel(applicationId));
  }

  // ── Reference / schema ───────────────────────────────────────────────────

  /// GET /reference/documents/process
  /// React: Api.Info
  ///
  /// Returns the full form schema (steps + field_groups) for this document.
  Future<ShagiPolucheniyeUslugiModel> info({
    required int documentId,
    required int applicationId,
  }) async {
    final body = await _client.get(
      AppConfig.processInfo(documentId, applicationId),
    );
    return shagiPolucheniyeUslugiModelFromJson(_encodeForModel(body));
  }

  /// GET /reference/documents/specialization
  /// React: Api.Specializations
  Future<UslugaSpecialization> fetchSpecializations({
    required int documentId,
  }) async {
    final body = await _client.get(AppConfig.specializations(documentId));
    return uslugaSpecializationFromJson(_encodeForModel(body));
  }

  /// GET /reference/documents/requirement
  /// React: Api.Requirements
  Future<StepRequirementModel> requirements({
    required int documentId,
    List<String> specializationIds = const [],
  }) async {
    final body = await _client.get(
      AppConfig.requirements(documentId, specializationIds),
    );
    return stepRequirementModelFromJson(_encodeForModel(body));
  }

  // ── Dynamic dropdowns (action events) ───────────────────────────────────

  /// POST /action?application_id=…&lang=…&action_key=…
  /// React: Api.ActionEvent
  ///
  /// [fields] is an optional list of key/value pairs sent in the body when
  /// loading a cascaded (dependent) dropdown (e.g. district after region).
  Future<DropDownOptionsModel> actionEvent({
    required int applicationId,
    required String lang,
    required String actionKey,
    List<Map<String, String>>? fields,
  }) async {
    // React always sends an array body (even empty []) — server returns NO_CONTENT for {}
    final body = await _client.post(
      AppConfig.actionEvent(applicationId, lang, actionKey),
      body: fields ?? [],
    );
    return DropDownOptionsModel.fromJson(body);
  }

  // ── File operations ──────────────────────────────────────────────────────

  /// POST /file/application/upload  (multipart)
  /// React: Api.FileUpload
  Future<FileUploadResult> uploadFile({
    required int applicationId,
    required File file,
    required String filename,
  }) async {
    final multipart = await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: filename,
    );
    final body = await _client.postMultipart(
      AppConfig.fileUpload(applicationId),
      files: [multipart],
    );
    print('===== UPLOAD RESPONSE =====');
    print(body);
    print('===========================');
    return FileUploadResult.fromJson(body);
  }

  /// POST /file/open_source/upload  (multipart)
  /// React: Api.OpenFileUpload — used for OPEN_SOURCE_FILE field type.
  Future<FileUploadResult> uploadOpenSourceFile({
    required int applicationId,
    required File file,
    required String filename,
  }) async {
    final multipart = await http.MultipartFile.fromPath(
      'file',
      file.path,
      filename: filename,
    );
    final body = await _client.postMultipart(
      AppConfig.openSourceFileUpload(applicationId),
      files: [multipart],
    );
    print('===== OPEN-SOURCE UPLOAD RESPONSE =====');
    print(body);
    print('=======================================');
    return FileUploadResult.fromJson(body);
  }

  /// GET /file/application/info/:id
  /// React: Api.FileInfo
  Future<FileUploadResult> fileInfo({
    required int fileId,
    required int applicationId,
  }) async {
    final body =
        await _client.get(AppConfig.fileInfo(fileId, applicationId));
    return FileUploadResult.fromJson(body);
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  /// The existing Dart model constructors accept a JSON string, not a Map.
  /// This helper re-serialises the Map back to a string for compatibility.
  String _encodeForModel(Map<String, dynamic> body) {
    return jsonEncode(body);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FileUploadResult
// ─────────────────────────────────────────────────────────────────────────────

/// Mirrors React IApi.FileUpload.Response
class FileUploadResult {
  final int fileId;
  final String name;
  final String extension;
  final int size;

  const FileUploadResult({
    required this.fileId,
    required this.name,
    required this.extension,
    required this.size,
  });

  factory FileUploadResult.fromJson(Map<String, dynamic> json) {
    // Response shape: { status_code, data: { fileId, name, extension, size } }
    final data = json['data'] as Map<String, dynamic>? ?? json;
    return FileUploadResult(
      fileId: (data['fileId'] as num?)?.toInt() ?? 0,
      name: data['name'] as String? ?? '',
      extension: data['extension'] as String? ?? '',
      size: (data['size'] as num?)?.toInt() ?? 0,
    );
  }
}
