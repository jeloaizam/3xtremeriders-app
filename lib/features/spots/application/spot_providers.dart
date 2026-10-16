import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/search/search_query.dart';
import '../data/spot_api.dart';
import '../domain/spot.dart';
import '../domain/sport.dart';

part 'spot_providers.g.dart';

/// Real spots near the user, fetched from `GET /spots`.
@riverpod
Future<List<Spot>> nearbySpots(Ref ref) {
  return ref.read(spotApiProvider).list();
}

/// Search results for the Search screen's Spots tab, re-fetched from the
/// backend on every filter change (live filtering, no separate "apply"
/// step). See [SearchQuery].
@riverpod
Future<List<Spot>> searchSpots(Ref ref, SearchQuery query) {
  return ref
      .read(spotApiProvider)
      .search(
        q: query.q,
        sportIds: searchQuerySportIds(query.sportIdsKey),
        difficulty: query.difficulty,
        bestSeason: query.bestSeason,
        hazardLevel: query.hazardLevel,
        lat: query.lat,
        lng: query.lng,
        radiusKm: query.radiusKm,
      );
}

/// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
/// spotId so Home's list and the Spot detail screen share one fetch.
///
/// keepAlive: without it, this (and the other small per-spot providers
/// below) gets disposed the instant nothing is watching it even for a
/// single frame — which happened during scroll on the Spot screen's media
/// gallery (a nested widget watching it independently of the parent's
/// `spotDetailProvider` watch), making it silently refetch and show fewer
/// items right after the fetch, then the full list again once it resolved.
@Riverpod(keepAlive: true)
Future<List<Sport>> spotSports(Ref ref, int spotId) {
  return ref.read(spotApiProvider).getSports(spotId);
}
