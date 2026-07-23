import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/rider_sport.dart';

part 'rider_sport_api.g.dart';

/// Talks to the backend's `/riders/{rider_id}/sports` endpoints
/// (`app/routers/rider_sport.py`) — a rider's favorite sports (up to 10,
/// ranked by `order`).
class RiderSportApi {
  Future<List<RiderSport>> list(int riderId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId/sports/'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => RiderSport.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<RiderSport> add({
    required int riderId,
    required int sportId,
    required int order,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId/sports/'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'sport_id': sportId, 'order': order}),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return RiderSport.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<void> remove({
    required int riderId,
    required int sportId,
    required String idToken,
  }) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId/sports/$sportId'),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 204) {
      throw ApiException(response.statusCode, response.body);
    }
  }

  /// Replaces the rider's whole favorite-sports order in one call —
  /// `sportIds` must contain exactly the same sports the rider already has
  /// favorited, just reordered. The backend applies this as a single
  /// delete-then-reinsert transaction (see `crud_rider_sport.reorder`)
  /// because a series of individual PATCHes can't swap two `order` values
  /// without transiently violating the DB's unique(rider_id, order)
  /// constraint.
  Future<List<RiderSport>> reorder({
    required int riderId,
    required List<int> sportIds,
    required String idToken,
  }) async {
    final response = await http.put(
      Uri.parse('${ApiConfig.baseUrl}/riders/$riderId/sports/'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'sport_ids': sportIds}),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => RiderSport.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
RiderSportApi riderSportApi(Ref ref) => RiderSportApi();
