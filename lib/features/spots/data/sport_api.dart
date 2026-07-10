import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../../auth/domain/rider.dart';
import '../domain/sport.dart';
import '../domain/spot_photo.dart';
import '../domain/spot_video.dart';

part 'sport_api.g.dart';

/// Talks to the backend's `/sports` endpoint (`app/routers/sport.py`) — the
/// full sport catalog, not scoped to a spot (see `SpotApi.getSports` for
/// that).
class SportApi {
  Future<List<Sport>> list() async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/sports/'));
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Sport.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Sport> get(int sportId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/sports/$sportId'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Sport.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Riders who favorited this sport, ordered by reputation — backs the
  /// Sport detail screen's ranking section.
  Future<List<Rider>> getTopRiders(int sportId, {int limit = 10}) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/sports/$sportId/top-riders?limit=$limit'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Rider.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<SpotPhoto>> getTopPhotos(int sportId, {int limit = 10}) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/sports/$sportId/top-photos?limit=$limit'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => SpotPhoto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<SpotVideo>> getTopVideos(int sportId, {int limit = 10}) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/sports/$sportId/top-videos?limit=$limit'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => SpotVideo.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
SportApi sportApi(Ref ref) => SportApi();
