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
    return data.map((json) => Spot.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<Spot> get(int spotId) async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}/spots/$spotId'));
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
    return data.map((json) => Sport.fromJson(json as Map<String, dynamic>)).toList();
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
    return SpotElement.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}

@riverpod
SpotApi spotApi(Ref ref) => SpotApi();
