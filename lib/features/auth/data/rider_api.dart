import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/rider.dart';

part 'rider_api.g.dart';

/// Talks to the backend's `/riders` endpoints (`app/routers/rider.py`).
class RiderApi {
  /// Updates the caller's own profile fields. Mirrors `RiderUpdate` — only
  /// non-null fields are sent, matching the backend's partial-update schema.
  Future<Rider> update({
    required int riderId,
    required String idToken,
    String? name,
    String? lastName,
    String? nickname,
    String? bio,
    String? city,
    int? countryId,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': ?name,
        'last_name': ?lastName,
        'nickname': ?nickname,
        'bio': ?bio,
        'city': ?city,
        'country_id': ?countryId,
      }),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Rider.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}

@riverpod
RiderApi riderApi(Ref ref) => RiderApi();
