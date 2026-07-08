import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/sport.dart';

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
    return data.map((json) => Sport.fromJson(json as Map<String, dynamic>)).toList();
  }
}

@riverpod
SportApi sportApi(Ref ref) => SportApi();
