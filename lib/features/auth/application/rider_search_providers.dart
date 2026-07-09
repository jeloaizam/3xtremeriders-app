import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/search/search_query.dart';
import '../data/rider_api.dart';
import '../domain/rider.dart';

part 'rider_search_providers.g.dart';

/// Search results for the Search screen's Riders tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.
@riverpod
Future<List<Rider>> searchRiders(Ref ref, SearchQuery query) {
  return ref
      .read(riderApiProvider)
      .search(q: query.q, sportIds: searchQuerySportIds(query.sportIdsKey));
}
