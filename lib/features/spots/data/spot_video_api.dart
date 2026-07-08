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
  Future<List<SpotVideo>> listBySpot(int spotId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/videos'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => SpotVideo.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<SpotVideo> create({
    required int spotId,
    required String url,
    String? provider,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/videos'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'url': url, 'provider': ?provider}),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return SpotVideo.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}

@riverpod
SpotVideoApi spotVideoApi(Ref ref) => SpotVideoApi();
