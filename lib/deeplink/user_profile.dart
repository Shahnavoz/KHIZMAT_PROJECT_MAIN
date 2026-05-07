import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProfile {
  final String? firstname;
  final String? lastname;
  final String? middlename;
  final String? tin;
  final String? pinfl;
  final String? mobilePhone;
  final String? gender;
  final String? birthDate;
  final String? address;

  const UserProfile({
    this.firstname,
    this.lastname,
    this.middlename,
    this.tin,
    this.pinfl,
    this.mobilePhone,
    this.gender,
    this.birthDate,
    this.address,
  });

  String get displayName =>
      '${firstname ?? ''} ${lastname ?? ''}'.trim();

  String get displayPhone =>
      mobilePhone != null && mobilePhone!.isNotEmpty
          ? '+${mobilePhone!}'
          : '';

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    firstname: json['firstname'] as String?,
    lastname: json['lastname'] as String?,
    middlename: json['middlename'] as String?,
    tin: json['tin'] as String?,
    pinfl: json['pinfl'] as String?,
    mobilePhone: json['mobilePhone'] as String?,
    gender: json['gender'] as String?,
    birthDate: json['birthDate'] as String?,
    address: json['address'] as String?,
  );

  /// Parse from the SSO access_token response: data.user object
  factory UserProfile.fromUserObject(Map<String, dynamic> user) => UserProfile(
    firstname: user['firstname'] as String?,
    lastname: user['lastname'] as String?,
    middlename: user['middlename'] as String?,
    tin: user['tin'] as String?,
    pinfl: user['pinfl'] as String?,
    mobilePhone: user['mobile_phone'] as String?,
    gender: user['gender'] as String?,
    birthDate: user['birth_date'] as String?,
  );

  /// Parse from check_token values array:
  /// [{"key": "APPLICANT_FIRST_NAME", "value": "..."}, ...]
  factory UserProfile.fromValuesList(List<dynamic> values) {
    final map = <String, String>{};
    for (final item in values) {
      final key = item['key'] as String?;
      final value = item['value'];
      if (key != null && value != null) {
        map[key] = value.toString();
      }
    }
    return UserProfile(
      firstname: map['APPLICANT_FIRST_NAME'],
      lastname: map['APPLICANT_LAST_NAME'],
      middlename: map['APPLICANT_MIDDLE_NAME'],
      tin: map['APPLICANT_TIN'],
      pinfl: map['APPLICANT_PINFL'],
      mobilePhone: map['APPLICANT_MOBILE_PHONE'],
      gender: map['APPLICANT_GENDER'],
      birthDate: map['APPLICANT_BIRTH_DATE'],
      address: map['APPLICANT_ADDRESS'],
    );
  }

  /// Merge: keeps non-null fields from [other], falls back to [this].
  UserProfile merge(UserProfile other) => UserProfile(
    firstname: other.firstname ?? firstname,
    lastname: other.lastname ?? lastname,
    middlename: other.middlename ?? middlename,
    tin: other.tin ?? tin,
    pinfl: other.pinfl ?? pinfl,
    mobilePhone: other.mobilePhone ?? mobilePhone,
    gender: other.gender ?? gender,
    birthDate: other.birthDate ?? birthDate,
    address: other.address ?? address,
  );

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'lastname': lastname,
    'middlename': middlename,
    'tin': tin,
    'pinfl': pinfl,
    'mobilePhone': mobilePhone,
    'gender': gender,
    'birthDate': birthDate,
    'address': address,
  };
}

class UserProfileNotifier extends StateNotifier<UserProfile?> {
  static const _key = 'user_profile';
  final _storage = const FlutterSecureStorage();

  UserProfileNotifier() : super(null) {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final raw = await _storage.read(key: _key);
    if (raw != null) {
      try {
        state = UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
      } catch (_) {}
    }
  }

  Future<void> update(UserProfile profile) async {
    // Merge with existing so we never lose data from a previous richer response
    state = state != null ? state!.merge(profile) : profile;
    await _storage.write(key: _key, value: jsonEncode(state!.toJson()));
  }

  Future<void> reload() => _loadFromStorage();

  Future<void> clear() async {
    state = null;
    await _storage.delete(key: _key);
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfile?>(
  (ref) => UserProfileNotifier(),
);
