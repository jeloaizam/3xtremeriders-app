import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/spot.dart';
import '../domain/spot_element.dart';
import '../domain/sport.dart';

part 'spot_api.g.dart';

/// Talks to the backend's `/spots` endpoints (`app/routers/spot.py`).
class SpotApi {
  Future<List<Spot>> list({int skip = 0, int limit = 50}) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/?skip=$skip&limit=$limit'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Spot.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Filtered/ranked search backing the Search screen — mirrors
  /// `GET /spots` query params added in `app/routers/spot.py`
  /// (`crud_spot.search`). All filters are optional and combine with AND;
  /// `lat`/`lng` (together) sort by distance and, with `radiusKm`, also
  /// restrict to that radius.
  Future<List<Spot>> search({
    String? q,
    List<int> sportIds = const [],
    int? difficulty,
    String? bestSeason,
    String? hazardLevel,
    double? lat,
    double? lng,
    double? radiusKm,
    int limit = 100,
  }) async {
    final params = <String, String>{'limit': '$limit'};
    if (q != null && q.isNotEmpty) params['q'] = q;
    if (difficulty != null) params['difficulty'] = '$difficulty';
    if (bestSeason != null) params['best_season'] = bestSeason;
    if (hazardLevel != null) params['hazard_level'] = hazardLevel;
    if (lat != null) params['lat'] = '$lat';
    if (lng != null) params['lng'] = '$lng';
    if (radiusKm != null) params['radius_km'] = '$radiusKm';

    // Uri's `queryParameters:` map can't express a repeated key
    // (sport_ids=1&sport_ids=2), so the query string is built by hand.
    final query = [
      for (final entry in params.entries)
        '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}',
      for (final id in sportIds) 'sport_ids=$id',
    ].join('&');

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/?$query'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Spot.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Spot> get(int spotId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Spot.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<List<Sport>> getSports(int spotId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/sports'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Sport.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<SpotElement>> getElements(int spotId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/elements'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => SpotElement.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Spot> create({
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    int? difficulty,
    String? bestSeason,
    required List<int> sportIds,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/spots/'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'description': description,
        'latitude': latitude,
        'longitude': longitude,
        'difficulty': ?difficulty,
        'best_season': ?bestSeason,
        'sport_ids': sportIds,
      }),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return Spot.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<SpotElement> addElement({
    required int spotId,
    required String name,
    String? type,
    int? difficulty,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/elements'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'type': ?type,
        'difficulty': ?difficulty,
      }),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return SpotElement.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

@riverpod
SpotApi spotApi(Ref ref) => SpotApi();
