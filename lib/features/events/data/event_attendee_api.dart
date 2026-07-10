import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_config.dart';
import '../../../core/network/api_exception.dart';
import '../domain/event_attendee.dart';

part 'event_attendee_api.g.dart';

/// Talks to the backend's `/events/{id}/attendees` endpoints
/// (`app/routers/event_attendee.py`) — RSVP (going/interested/declined).
class EventAttendeeApi {
  Future<List<EventAttendee>> listByEvent(int eventId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/events/$eventId/attendees/'),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((json) => EventAttendee.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<EventAttendee> rsvp({
    required int eventId,
    required int status,
    required String idToken,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/events/$eventId/attendees/'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'status': status}),
    );
    if (response.statusCode != 201) {
      throw ApiException(response.statusCode, response.body);
    }
    return EventAttendee.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<EventAttendee> updateRsvp({
    required int eventId,
    required int riderId,
    required int status,
    required String idToken,
  }) async {
    final response = await http.patch(
      Uri.parse('${ApiConfig.baseUrl}/events/$eventId/attendees/$riderId'),
      headers: {
        'Authorization': 'Bearer $idToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'status': status}),
    );
    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
    return EventAttendee.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<void> cancelRsvp({
    required int eventId,
    required int riderId,
    required String idToken,
  }) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/events/$eventId/attendees/$riderId'),
      headers: {'Authorization': 'Bearer $idToken'},
    );
    if (response.statusCode != 204) {
      throw ApiException(response.statusCode, response.body);
    }
  }
}

@riverpod
EventAttendeeApi eventAttendeeApi(Ref ref) => EventAttendeeApi();
