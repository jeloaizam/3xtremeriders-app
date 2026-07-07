import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';

part 'vote_api.g.dart';

/// Talks to the backend's polymorphic `/votes` endpoint
/// (`app/routers/vote.py`) — a simple like/unlike, distinct from
/// [SpotRatingApi]'s star rating.
class VoteApi {
  Future<bool> check({
    required String targetType,
    required int targetId,
    required String idToken,
  }) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConfig.baseUrl}/votes/check?target_type=$targetType&target_id=$targetId',
      ),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return jsonDecode(response.body) as bool;
  }

  Future<void> vote({
    required String targetType,
    required int targetId,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/votes/'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'target_type': targetType, 'target_id': targetId}),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
  }

  Future<void> unvote({
    required String targetType,
    required int targetId,
    required String idToken,
  }) async {
    final response = await http.delete(
      Uri.parse(
        '${ApiConfig.baseUrl}/votes/?target_type=$targetType&target_id=$targetId',
      ),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 204) {
      throw ApiException(response.statusCode, response.body);
    }
  }
}

@riverpod
VoteApi voteApi(Ref ref) => VoteApi();
