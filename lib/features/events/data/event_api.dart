import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../../spots/domain/sport.dart';
import '../domain/event.dart';

part 'event_api.g.dart';

/// Talks to the backend's `/events` endpoints (`app/routers/event.py`).
class EventApi {
  /// Filtered search backing the Search screen's Eventos tab, and (with no
  /// filters) the plain event list — mirrors `GET /events` query params
  /// added in `crud_event.search`. Already ordered by `start_date` asc.
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

  Future<Event> get(int eventId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/events/$eventId'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Event.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  Future<List<Sport>> getSports(int eventId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/events/$eventId/sports'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => Sport.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  /// Only succeeds server-side if the caller is an admin — events are
  /// "official", not something any rider can publish.
  Future<Event> create({
    required String name,
    required String description,
    required DateTime startDate,
    DateTime? endDate,
    int? spotId,
    double? latitude,
    double? longitude,
    String? coverImageUrl,
    List<int> sportIds = const [],
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/events/'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'description': description,
        'start_date': startDate.toUtc().toIso8601String(),
        'end_date': ?endDate?.toUtc().toIso8601String(),
        'spot_id': ?spotId,
        'latitude': ?latitude,
        'longitude': ?longitude,
        'cover_image_url': ?coverImageUrl,
        'sport_ids': sportIds,
      }),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return Event.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }

  /// Sets the banner shown on `EventsListScreen`/`EventScreen` — called
  /// after the event exists so the Storage path can include its id
  /// (`events/{eventId}/{fileName}`).
  Future<Event> updateCoverImage({
    required int eventId,
    required String coverImageUrl,
    required String idToken,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/events/$eventId'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'cover_image_url': coverImageUrl}),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return Event.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}

@riverpod
EventApi eventApi(Ref ref) => EventApi();
