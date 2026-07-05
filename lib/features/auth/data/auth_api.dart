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
      }),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Rider.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
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
