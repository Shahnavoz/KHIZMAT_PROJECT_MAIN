import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/// Thin authenticated HTTP wrapper.
///
/// React equivalent: `services/http.ts` (Axios instance with Bearer token
/// injected via request interceptor).
///
/// Usage:
///   final client = ApiClient();
///   final body = await client.get('/reference/documents/...');
///   final body = await client.post('/process/start?...', {});
class ApiClient {
  final _storage = const FlutterSecureStorage();

  // ── Headers ──────────────────────────────────────────────────────────────

  Future<Map<String, String>> _authHeaders() async {
    final token = await _storage.read(key: 'token');
    return {
      'Content-Type': 'application/json; charset=utf-8',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  // ── GET ──────────────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> get(String url) async {
    final headers = await _authHeaders();
    final response = await http.get(Uri.parse(url), headers: headers);
    return _handleResponse(response);
  }

  // ── POST ─────────────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> post(
    String url, {
    dynamic body,
  }) async {
    final headers = await _authHeaders();
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body != null ? jsonEncode(body) : jsonEncode({}),
    );
    return _handleResponse(response);
  }

  /// POST with multipart form-data (file uploads).
  Future<Map<String, dynamic>> postMultipart(
    String url, {
    required List<http.MultipartFile> files,
    Map<String, String>? fields,
  }) async {
    final token = await _storage.read(key: 'token');
    final request = http.MultipartRequest('POST', Uri.parse(url));

    if (token != null && token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }
    if (fields != null) request.fields.addAll(fields);
    request.files.addAll(files);

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    return _handleResponse(response);
  }

  // ── Response handler ─────────────────────────────────────────────────────

  Map<String, dynamic> _handleResponse(http.Response response) {
    final Map<String, dynamic> body;
    try {
      body = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (_) {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'Invalid JSON response',
      );
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    // Log error responses so we can see what the server actually says
    print('===== ERROR RESPONSE [${response.statusCode}] =====');
    print(response.body);
    print('=================================================');

    // Extract server-side message (mirrors React error handling in sagas)
    final message = _extractErrorMessage(body) ??
        'Server error ${response.statusCode}';

    throw ApiException(
      statusCode: response.statusCode,
      message: message,
      body: body,
    );
  }

  String? _extractErrorMessage(Map<String, dynamic> body) {
    // React pattern: errorResponse?.response?.data?.message
    if (body['message'] is String) return body['message'] as String;

    // message.title.ru pattern (used in startPostForm)
    final title = body['message']?['title'];
    if (title is Map) {
      return (title['ru'] ?? title['en'] ?? title['tj']) as String?;
    }

    return body['status_message'] as String?;
  }
}

/// Thrown when the server returns a non-2xx status code.
class ApiException implements Exception {
  final int statusCode;
  final String message;
  final Map<String, dynamic>? body;

  const ApiException({
    required this.statusCode,
    required this.message,
    this.body,
  });

  /// Extra data sometimes returned with errors (e.g. register_id for duplicates)
  dynamic get data => body?['data'];

  @override
  String toString() => 'ApiException($statusCode): $message';
}
