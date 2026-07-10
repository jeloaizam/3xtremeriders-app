import '../../auth/domain/rider.dart';
import '../../spots/domain/sport.dart';
import '../domain/event.dart';
import '../domain/event_attendee.dart';

/// Everything the Event detail screen needs, combined by
/// [eventDetailProvider].
class EventDetailData {
  const EventDetailData({
    required this.event,
    required this.sports,
    required this.attendees,
    required this.creator,
  });

  final Event event;
  final List<Sport> sports;
  final List<EventAttendee> attendees;
  final Rider creator;
}
