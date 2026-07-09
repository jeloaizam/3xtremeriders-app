import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/rider.dart';

part 'rider_api.g.dart';

/// Talks to the backend's `/riders` endpoints (`app/routers/rider.py`).
class RiderApi {
  /// Fetches a rider's public profile by id — no auth required.
  Future<Rider> get(int riderId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Rider.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Filtered search backing the Search screen's Riders tab — mirrors
  /// `GET /riders` query params added in `crud_rider.search`.
  Future<List<Rider>> search({
    String? q,
    List<int> sportIds = const [],
    int limit = 100,
  }) async {
    final params = <String, String>{'limit': '$limit'};
    if (q != null && q.isNotEmpty) params['q'] = q;

    final query = [
      for (final entry in params.entries)
        '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}',
      for (final id in sportIds) 'sport_ids=$id',
    ].join('&');

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/riders/?$query'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Rider.fromJson(json as Map<String, dynamic>))
        .toList();
  }

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
