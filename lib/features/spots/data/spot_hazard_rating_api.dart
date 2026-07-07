import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/spot_hazard_rating.dart';

part 'spot_hazard_rating_api.g.dart';

/// Talks to the backend's `/spots/{id}/hazard-rating` endpoints
/// (`app/routers/spot_hazard_rating.py`).
class SpotHazardRatingApi {
  Future<SpotHazardRating?> getMine({
    required int spotId,
    required String idToken,
  }) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/hazard-rating/me'),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    if (response.body == 'null') return null;
    return SpotHazardRating.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<SpotHazardRating> rate({
    required int spotId,
    required int crutches,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/hazard-rating'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'crutches': crutches}),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return SpotHazardRating.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

@riverpod
SpotHazardRatingApi spotHazardRatingApi(Ref ref) => SpotHazardRatingApi();
