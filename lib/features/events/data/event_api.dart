import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/event.dart';

part 'event_api.g.dart';

/// Talks to the backend's `/events` endpoints (`app/routers/event.py`).
class EventApi {
  /// Filtered search backing the Search screen's Eventos tab — mirrors
  /// `GET /events` query params added in `crud_event.search`.
  Future<List<Event>> search({
    String? q,
    List<int> sportIds = const [],
    int limit = 100,
  }) async {
    final params = <String, String>{'limit': '$limit'};
    if (q != null && q.isNotEmpty) params['q'] = q;

    final query = [
      for (final entry in params.entries)
        '${Uri.encodeQueryComponent(entry.key)}=${Uri.encodeQueryComponent(entry.value)}',
      for (final id in sportIds) 'sport_ids=$id',
    ].join('&');

    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/events/?$query'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Event.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@riverpod
EventApi eventApi(Ref ref) => EventApi();
