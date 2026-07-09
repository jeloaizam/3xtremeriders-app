import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/search/search_query.dart';
import '../data/event_api.dart';
import '../domain/event.dart';

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
