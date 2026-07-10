import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/spot_photo.dart';

part 'spot_photo_api.g.dart';

/// Talks to the backend's `/spots/{id}/photos` endpoint
/// (`app/routers/photo.py`) — already returned ranked by `vote_count` desc.
class SpotPhotoApi {
  Future<List<SpotPhoto>> listBySpot(int spotId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/photos'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => SpotPhoto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<SpotPhoto> create({
    required int spotId,
    required String url,
    String? caption,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/photos'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'url': url, 'caption': ?caption}),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return SpotPhoto.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

@riverpod
SpotPhotoApi spotPhotoApi(Ref ref) => SpotPhotoApi();
