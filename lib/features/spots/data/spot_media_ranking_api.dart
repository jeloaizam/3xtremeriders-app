import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/spot_media_ranking.dart';

part 'spot_media_ranking_api.g.dart';

/// Talks to the backend's `GET /spots/{id}/media-ranking`
/// (`app/routers/spot_media_ranking.py`).
class SpotMediaRankingApi {
  Future<SpotMediaRanking> get(int spotId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/media-ranking'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return SpotMediaRanking.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

@riverpod
SpotMediaRankingApi spotMediaRankingApi(Ref ref) => SpotMediaRankingApi();

/// A spot's media-by-gender ranking — not `keepAlive`: unlike
/// `spotDetailProvider`, this doesn't need to survive brief listener gaps,
/// and votes on individual photos/videos happen from *other* screens
/// (photo detail, video player) that invalidate this by spotId on change.
@riverpod
Future<SpotMediaRanking> spotMediaRanking(Ref ref, int spotId) {
  return ref.read(spotMediaRankingApiProvider).get(spotId);
}
