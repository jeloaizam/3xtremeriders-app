import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_attendee.freezed.dart';
part 'event_attendee.g.dart';

/// Mirrors the backend's `EventAttendeeRead` schema
/// (`app/schemas/event_attendee.py`) — an RSVP. `status`: 1=going,
/// 2=interested, 3=declined.
@freezed
abstract class EventAttendee with _$EventAttendee {
  const factory EventAttendee({
    required int id,
    @JsonKey(name: 'event_id') required int eventId,
    @JsonKey(name: 'rider_id') required int riderId,
    int? status,
    @JsonKey(name: 'created_date') required DateTime createdDate,
  }) = _EventAttendee;

  factory EventAttendee.fromJson(Map<String, dynamic> json) =>
      _$EventAttendeeFromJson(json);
}

const rsvpGoing = 1;
const rsvpInterested = 2;
const rsvpDeclined = 3;
