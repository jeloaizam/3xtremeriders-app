import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/spot_comment.dart';

part 'spot_comment_api.g.dart';

/// Talks to the backend's polymorphic `/comments` endpoint
/// (`app/routers/comment.py`) — `targetType` is any of the backend's
/// `TargetType` values ('spot', 'photo', 'video', ...), so this same
/// client backs the spot's own comment thread as well as a photo/video's.
class SpotCommentApi {
  Future<List<SpotComment>> listFor({
    required String targetType,
    required int targetId,
  }) async {
    final response = await http.get(
      Uri.parse(
        '${ApiConfig.baseUrl}/comments/?target_type=$targetType&target_id=$targetId',
      ),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => SpotComment.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<SpotComment> create({
    required String targetType,
    required int targetId,
    required String body,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/comments/'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'target_type': targetType,
        'target_id': targetId,
        'body': body,
      }),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return SpotComment.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

@riverpod
SpotCommentApi spotCommentApi(Ref ref) => SpotCommentApi();
