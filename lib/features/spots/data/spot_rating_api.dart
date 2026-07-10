import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/spot_rating.dart';

part 'spot_rating_api.g.dart';

/// Talks to the backend's `/spots/{id}/rating` endpoints
/// (`app/routers/spot_rating.py`).
class SpotRatingApi {
  Future<SpotRating?> getMine({
    required int spotId,
    required String idToken,
  }) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/rating/me'),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    if (response.body == 'null') return null;
    return SpotRating.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<SpotRating> rate({
    required int spotId,
    required int stars,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/rating'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'stars': stars}),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return SpotRating.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

@riverpod
SpotRatingApi spotRatingApi(Ref ref) => SpotRatingApi();
