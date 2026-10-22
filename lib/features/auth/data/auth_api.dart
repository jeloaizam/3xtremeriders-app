import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/rider.dart';

/// Talks to the backend's `/auth` endpoints (`app/routers/auth.py`).
class AuthApi {
  /// Creates or returns the Rider profile for the caller's Firebase UID.
  ///
  /// For an existing rider the backend ignores the body and returns the
  /// stored profile unchanged, so a plain sign-in can pass empty profile
  /// fields — only first-time registration actually needs real values.
  Future<Rider> sync({
    required String idToken,
    required String name,
    required String lastName,
    required String nickname,
    String? iconImage,
    // Only meaningful for a brand-new rider's first sync — the backend
    // ignores the whole body for one that already exists.
    DateTime? birthDate,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/auth/sync'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'last_name': lastName,
        'nickname': nickname,
        'icon_image': ?iconImage,
        if (birthDate != null)
          'birth_date': _dateOnly(birthDate),
      }),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Rider.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Writes the two audit-log rows (`terms` + `privacy`) proving this rider
  /// accepted the legal documents, with the versions they actually saw.
  /// `POST /riders/me/consent` — see `backend/app/routers/consent.py`.
  Future<void> acceptConsent({
    required String idToken,
    required String termsVersion,
    required String privacyVersion,
    required String deviceInfo,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/riders/me/consent'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'terms_version': termsVersion,
        'privacy_version': privacyVersion,
        'device_info': deviceInfo,
      }),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
  }

  static String _dateOnly(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<Rider> me({required String idToken}) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/auth/me'),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Rider.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
