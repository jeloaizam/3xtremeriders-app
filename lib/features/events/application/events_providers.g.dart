// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Search results for the Search screen's Eventos tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.

@ProviderFor(searchEvents)
final searchEventsProvider = SearchEventsFamily._();

/// Search results for the Search screen's Eventos tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.

final class SearchEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  /// Search results for the Search screen's Eventos tab. Only `q` and the
  /// sport filter apply here — the rest of [SearchQuery] (difficulty,
  /// season, hazard, distance) is spot-specific and ignored.
  SearchEventsProvider._({
    required SearchEventsFamily super.from,
    required SearchQuery super.argument,
  }) : super(
         retry: null,
         name: r'searchEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchEventsHash();

  @override
  String toString() {
    return r'searchEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    final argument = this.argument as SearchQuery;
    return searchEvents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchEventsHash() => r'66aa88f9c015d5dae5f20524681958529d5b0d8b';

/// Search results for the Search screen's Eventos tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.

final class SearchEventsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Event>>, SearchQuery> {
  SearchEventsFamily._()
    : super(
        retry: null,
        name: r'searchEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Search results for the Search screen's Eventos tab. Only `q` and the
  /// sport filter apply here — the rest of [SearchQuery] (difficulty,
  /// season, hazard, distance) is spot-specific and ignored.

  SearchEventsProvider call(SearchQuery query) =>
      SearchEventsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchEventsProvider';
}

/// The plain event list backing `EventsListScreen`'s "PRÓXIMOS" tab —
/// already ordered by `start_date` ascending server-side. "CERCA" and
/// "VOY" are derived from this same list client-side (see
/// [eventsAttendeesByIdProvider] for "VOY").

@ProviderFor(eventsList)
final eventsListProvider = EventsListProvider._();

/// The plain event list backing `EventsListScreen`'s "PRÓXIMOS" tab —
/// already ordered by `start_date` ascending server-side. "CERCA" and
/// "VOY" are derived from this same list client-side (see
/// [eventsAttendeesByIdProvider] for "VOY").

final class EventsListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  /// The plain event list backing `EventsListScreen`'s "PRÓXIMOS" tab —
  /// already ordered by `start_date` ascending server-side. "CERCA" and
  /// "VOY" are derived from this same list client-side (see
  /// [eventsAttendeesByIdProvider] for "VOY").
  EventsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsListHash();

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    return eventsList(ref);
  }
}

String _$eventsListHash() => r'75a8a4fa683fb781ce1e9c5a3c74396276bc71d6';

/// Everything the Event detail screen needs for one event, fetched in
/// parallel: the event itself, its sports, its attendees (RSVPs), and the
/// organizer's profile.

@ProviderFor(eventDetail)
final eventDetailProvider = EventDetailFamily._();

/// Everything the Event detail screen needs for one event, fetched in
/// parallel: the event itself, its sports, its attendees (RSVPs), and the
/// organizer's profile.

final class EventDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<EventDetailData>,
          EventDetailData,
          FutureOr<EventDetailData>
        >
    with $FutureModifier<EventDetailData>, $FutureProvider<EventDetailData> {
  /// Everything the Event detail screen needs for one event, fetched in
  /// parallel: the event itself, its sports, its attendees (RSVPs), and the
  /// organizer's profile.
  EventDetailProvider._({
    required EventDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'eventDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventDetailHash();

  @override
  String toString() {
    return r'eventDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EventDetailData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EventDetailData> create(Ref ref) {
    final argument = this.argument as int;
    return eventDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventDetailHash() => r'5725795d6b8d4b98636195c1cd9994b8658f33cc';

/// Everything the Event detail screen needs for one event, fetched in
/// parallel: the event itself, its sports, its attendees (RSVPs), and the
/// organizer's profile.

final class EventDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EventDetailData>, int> {
  EventDetailFamily._()
    : super(
        retry: null,
        name: r'eventDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Everything the Event detail screen needs for one event, fetched in
  /// parallel: the event itself, its sports, its attendees (RSVPs), and the
  /// organizer's profile.

  EventDetailProvider call(int eventId) =>
      EventDetailProvider._(argument: eventId, from: this);

  @override
  String toString() => r'eventDetailProvider';
}

/// Attendees per event, for every event in [eventsListProvider] — backs
/// both the "going" count shown on each card and the "VOY" filter tab
/// (events where the signed-in rider has a `status == rsvpGoing` RSVP).
/// One `/attendees` fetch per event (N+1, acceptable at the event counts
/// this app deals with — same tradeoff as the Search screen's per-item
/// vote checks).

@ProviderFor(eventsAttendeesById)
final eventsAttendeesByIdProvider = EventsAttendeesByIdProvider._();

/// Attendees per event, for every event in [eventsListProvider] — backs
/// both the "going" count shown on each card and the "VOY" filter tab
/// (events where the signed-in rider has a `status == rsvpGoing` RSVP).
/// One `/attendees` fetch per event (N+1, acceptable at the event counts
/// this app deals with — same tradeoff as the Search screen's per-item
/// vote checks).

final class EventsAttendeesByIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<int, List<EventAttendee>>>,
          Map<int, List<EventAttendee>>,
          FutureOr<Map<int, List<EventAttendee>>>
        >
    with
        $FutureModifier<Map<int, List<EventAttendee>>>,
        $FutureProvider<Map<int, List<EventAttendee>>> {
  /// Attendees per event, for every event in [eventsListProvider] — backs
  /// both the "going" count shown on each card and the "VOY" filter tab
  /// (events where the signed-in rider has a `status == rsvpGoing` RSVP).
  /// One `/attendees` fetch per event (N+1, acceptable at the event counts
  /// this app deals with — same tradeoff as the Search screen's per-item
  /// vote checks).
  EventsAttendeesByIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventsAttendeesByIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventsAttendeesByIdHash();

  @$internal
  @override
  $FutureProviderElement<Map<int, List<EventAttendee>>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<int, List<EventAttendee>>> create(Ref ref) {
    return eventsAttendeesById(ref);
  }
}

String _$eventsAttendeesByIdHash() =>
    r'153da76c12fcc3d0e7c876aeaf2d1412873aef3a';
