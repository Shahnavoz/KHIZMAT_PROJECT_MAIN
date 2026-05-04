/// Central configuration for API base URLs and environment constants.
///
/// React maps:  process.env.REACT_APP_API_BASE_URL    → [AppConfig.baseV1]
///              process.env.REACT_APP_API_BASE_URL_V2  → [AppConfig.baseV2]
///
/// All calls (including file upload) use the same host [_host].
/// File endpoints use [baseV2] (not v1) — matching React's api.ts which calls
/// `/v2/file/application/upload`. Using v1 returns file IDs that the v2
/// process/update endpoint does NOT recognise, causing 403.
class AppConfig {
  AppConfig._();

  // ── Base URLs ────────────────────────────────────────────────────────────
  static const String _host = 'https://api.ekhizmat.tj';

  /// v1 – reference data, actions
  static const String baseV1 = '$_host/v1';

  /// v2 – process lifecycle, file operations
  static const String baseV2 = '$_host/v2';

  // ── Process (v2) ─────────────────────────────────────────────────────────
  static String processStart(int documentId) =>
      '$baseV2/process/start?document_id=$documentId';

  static String processStartByRegister(int registerId, String type) =>
      '$baseV2/process/start?register_id=$registerId&application_type=$type';

  static String processUpdate(int applicationId, int stepId) =>
      '$baseV2/process/update?application_id=$applicationId&step_id=$stepId';

  static String processBack(
    int applicationId,
    int currentStepId,
    int targetStepId,
  ) =>
      '$baseV2/process/update?application_id=$applicationId'
      '&step_id=$currentStepId&change_step_id=$targetStepId';

  static String processResume(int applicationId) =>
      '$baseV2/process/resume?application_id=$applicationId';

  static String processCancel(int applicationId) =>
      '$baseV2/process/cancel?application_id=$applicationId';

  // ── Reference / Info (v1) ────────────────────────────────────────────────
  static String processInfo(int documentId, int applicationId) =>
      '$baseV1/reference/documents/process'
      '?document_id=$documentId&application_id=$applicationId';

  static String specializations(int documentId) =>
      '$baseV1/reference/documents/specialization?document_id=$documentId';

  static String requirements(int documentId, List<String> specializationIds) =>
      '$baseV1/reference/documents/requirement'
      '?document_id=$documentId'
      '&SELECTED_SPECIALIZATIONS=${specializationIds.join(',')}';

  static String actionEvent(
    int applicationId,
    String lang,
    String actionKey,
  ) =>
      '$baseV1/action'
      '?application_id=$applicationId&lang=$lang&action_key=$actionKey';

  // ── File (v1) ────────────────────────────────────────────────────────────
  static String fileUpload(int applicationId) =>
      '$baseV1/file/application/upload?application_id=$applicationId';

  static String openSourceFileUpload(int applicationId) =>
      '$baseV1/file/open_source/upload?application_id=$applicationId';

  static String fileInfo(int fileId, int applicationId) =>
      '$baseV1/file/application/info/$fileId?application_id=$applicationId';

  static String fileDownload(int fileId, int applicationId) =>
      '$baseV1/file/application/download/$fileId?application_id=$applicationId';

  // ── Payment (v1) ─────────────────────────────────────────────────────────
  static String paymentFees = '$baseV1/payment/fees';
  static String paymentSendSms = '$baseV1/payment/online/send_sms';
  static String paymentConfirmSms = '$baseV1/payment/online/confirm_sms';
  static String paymentSmartpay = '$baseV1/payment/external/smartpay/invoice';
  static String paymentDcNext = '$baseV1/payment/external/dcnext/invoice';
  static String paymentUnifiedQr = '$baseV1/payment/external/unified-qr';

  static String paymentCheck(String serial) =>
      '$baseV1/payment/invoice/checking/$serial';

  // ── Open-source organizations (v1) ──────────────────────────────────────
  static String get openSourceOrganizations =>
      '$baseV1/admin/opensource/organizations';

  static String openSourceOrganizationById(int id) =>
      '$baseV1/admin/opensource/organizations/$id';
}
