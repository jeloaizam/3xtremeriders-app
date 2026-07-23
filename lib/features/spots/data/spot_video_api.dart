import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/spot_video.dart';

part 'spot_video_api.g.dart';

/// Talks to the backend's `/spots/{id}/videos` endpoint
/// (`app/routers/video.py`) — already returned ranked by `vote_count` desc.
class SpotVideoApi {
  Future<List<SpotVideo>> listBySpot(int spotId, {int? sportId}) async {
    final query = sportId == null ? '' : '?sport_id=$sportId';
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/videos$query'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => SpotVideo.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// `sportId` is required by the backend when the spot has 2+ sports,
  /// auto-resolved (and safe to omit) when it only has one.
  Future<SpotVideo> create({
    required int spotId,
    required String url,
    String? provider,
    int? sportId,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/videos'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'url': url,
        'provider': ?provider,
        'sport_id': ?sportId,
      }),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return SpotVideo.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

@riverpod
SpotVideoApi spotVideoApi(Ref ref) => SpotVideoApi();
