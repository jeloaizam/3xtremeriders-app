import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/hazzard.dart';

part 'hazzard_api.g.dart';

/// Talks to the backend's `/spots/{id}/hazzards` endpoints
/// (`app/routers/hazzard.py`).
class HazzardApi {
  Future<List<Hazzard>> listBySpot(int spotId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/hazzards'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Hazzard.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<Hazzard> get(int hazzardId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/hazzards/$hazzardId'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Hazzard.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// 'skull' (confirma el peligro) o 'broom' (está mejorando) — tocar la
  /// misma reacción otra vez la quita, tocar la otra la cambia (ver
  /// `app/crud/hazzard_vote.py`). Devuelve el hazard con los conteos ya
  /// actualizados.
  Future<Hazzard> vote({
    required int hazzardId,
    required String reaction,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/hazzards/$hazzardId/vote'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'reaction': reaction}),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Hazzard.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// La reacción ('skull'/'broom') del rider autenticado sobre ese hazard,
  /// o null si no ha votado.
  Future<String?> checkVote({
    required int hazzardId,
    required String idToken,
  }) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/hazzards/$hazzardId/vote/check'),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    if (response.body == 'null') return null;
    return jsonDecode(response.body) as String;
  }

  Future<Hazzard> create({
    required int spotId,
    required String name,
    int? severity,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/spots/$spotId/hazzards'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': name, 'severity': ?severity}),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return Hazzard.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Only the spot's owner or a moderator+ can edit/delete a hazard —
  /// Hazzard doesn't track who reported it (see `app/routers/hazzard.py`).
  Future<Hazzard> update({
    required int hazzardId,
    String? name,
    int? severity,
    required String idToken,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/hazzards/$hazzardId'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'name': ?name, 'severity': ?severity}),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Hazzard.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<void> delete({required int hazzardId, required String idToken}) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/hazzards/$hazzardId'),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 204) {
      throw ApiException(response.statusCode, response.body);
    }
  }
}

@riverpod
HazzardApi hazzardApi(Ref ref) => HazzardApi();
