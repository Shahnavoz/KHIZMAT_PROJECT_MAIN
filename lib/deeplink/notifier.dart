import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:khizmat_new/deeplink/stateModel.dart';
import 'package:khizmat_new/deeplink/user_profile.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;
  final _storage = const FlutterSecureStorage();

  AuthNotifier(this._ref) : super(AuthState.initial());

  // Called on app start — navigates to home if token is still valid.
  Future<void> checkToken() async {
    final token = await _storage.read(key: 'token');
    if (token == null || token.isEmpty) return;

    state = state.copyWith(status: AuthStatus.loading);

    try {
      final response = await http.post(
        Uri.parse('https://api.ekhizmat.tj/v1/oauth/check_token'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        _parseAndSaveProfile(jsonDecode(response.body));
        state = state.copyWith(status: AuthStatus.success);
        print("Response.body: ${response.body}");
      } else {
        await _storage.delete(key: 'token');
        state = state.copyWith(status: AuthStatus.initial);
      }
    } catch (_) {
      state = state.copyWith(status: AuthStatus.initial);
    }
  }

  // Called when IMZO redirects back via khizmatapp://sso?code=CODE&state=STATE.
  Future<void> handleDeepLink(String code, String? stateParam) async {
    state = state.copyWith(status: AuthStatus.loading);

    try {
      final token = await _storage.read(key: 'token');

      final uri = Uri.https(
        'api.ekhizmat.tj',
        '/v1/oauth/sso/access_token',
        {'code': code, if (stateParam != null) 'state': stateParam},
      );

      final headers = <String, String>{
        'Content-Type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      final response = await http.post(uri, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final newToken =
            json['data']?['token']?['access_token'] ??
            json['data']?['access_token'] ??
            json['access_token'];
        if (newToken != null) {
          await _storage.write(key: 'token', value: newToken.toString());
          print("Response.body: ${response.body}");
        }
        _parseAndSaveProfile(json);
        state = state.copyWith(status: AuthStatus.success);
      } else {
        state = state.copyWith(status: AuthStatus.error, error: response.body);
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.error, error: e.toString());
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'token');
    _ref.read(userProfileProvider.notifier).clear();
    state = AuthState.initial();
  }

  void _parseAndSaveProfile(Map<String, dynamic> json) {
    final data = json['data'];
    if (data == null) return;

    UserProfile? profile;

    // SSO exchange response: data.user object
    final userObj = data['user'];
    if (userObj is Map<String, dynamic>) {
      profile = UserProfile.fromUserObject(userObj);
    }

    // check_token / application response: data.values array
    final values = data['values'];
    if (values is List && values.isNotEmpty) {
      final fromValues = UserProfile.fromValuesList(values);
      profile = profile != null ? profile.merge(fromValues) : fromValues;
    }

    if (profile != null) {
      _ref.read(userProfileProvider.notifier).update(profile);
    }
  }
}
