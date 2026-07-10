import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/search/search_query.dart';
import '../../auth/data/rider_api.dart';
import '../data/event_api.dart';
import '../data/event_attendee_api.dart';
import '../domain/event.dart';
import '../domain/event_attendee.dart';
import 'event_detail.dart';

part 'events_providers.g.dart';

/// Search results for the Search screen's Eventos tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.
@riverpod
Future<List<Event>> searchEvents(Ref ref, SearchQuery query) {
  return ref
      .read(eventApiProvider)
      .search(q: query.q, sportIds: searchQuerySportIds(query.sportIdsKey));
}

/// The plain event list backing `EventsListScreen`'s "PRÓXIMOS" tab —
/// already ordered by `start_date` ascending server-side. "CERCA" and
/// "VOY" are derived from this same list client-side (see
/// [eventsAttendeesByIdProvider] for "VOY").
@riverpod
Future<List<Event>> eventsList(Ref ref) {
  return ref.read(eventApiProvider).search();
}

/// Everything the Event detail screen needs for one event, fetched in
/// parallel: the event itself, its sports, its attendees (RSVPs), and the
/// organizer's profile.
@Riverpod(keepAlive: true)
Future<EventDetailData> eventDetail(Ref ref, int eventId) async {
  final eventApi = ref.read(eventApiProvider);
  final event = await eventApi.get(eventId);

  final sportsFuture = eventApi.getSports(eventId);
  final attendeesFuture = ref
      .read(eventAttendeeApiProvider)
      .listByEvent(eventId);
  final creatorFuture = ref.read(riderApiProvider).get(event.createdBy);

  final sports = await sportsFuture;
  final attendees = await attendeesFuture;
  final creator = await creatorFuture;

  return EventDetailData(
    event: event,
    sports: sports,
    attendees: attendees,
    creator: creator,
  );
}

/// Attendees per event, for every event in [eventsListProvider] — backs
/// both the "going" count shown on each card and the "VOY" filter tab
/// (events where the signed-in rider has a `status == rsvpGoing` RSVP).
/// One `/attendees` fetch per event (N+1, acceptable at the event counts
/// this app deals with — same tradeoff as the Search screen's per-item
/// vote checks).
@riverpod
Future<Map<int, List<EventAttendee>>> eventsAttendeesById(Ref ref) async {
  final events = await ref.watch(eventsListProvider.future);
  final attendeeApi = ref.read(eventAttendeeApiProvider);
  final results = await Future.wait([
    for (final event in events) attendeeApi.listByEvent(event.id),
  ]);
  return {for (var i = 0; i < events.length; i++) events[i].id: results[i]};
}
