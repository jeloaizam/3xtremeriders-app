import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../events/data/event_api.dart';
import '../data/spot_api.dart';
import '../data/sport_api.dart';
import 'sport_detail.dart';

part 'sport_detail_providers.g.dart';

/// Everything the Sport detail screen needs, fetched in parallel: the sport
/// itself, its top riders/spots/photos/videos, and its events — mirrors
/// `eventDetailProvider`'s parallel-fetch pattern (`events_providers.dart`).
@Riverpod(keepAlive: true)
Future<SportDetailData> sportDetail(Ref ref, int sportId) async {
  final sportApi = ref.read(sportApiProvider);

  final sportFuture = sportApi.get(sportId);
  final topRidersFuture = sportApi.getTopRiders(sportId);
  final topSpotsFuture = ref
      .read(spotApiProvider)
      .search(sportIds: [sportId], limit: 10);
  final topPhotosFuture = sportApi.getTopPhotos(sportId);
  final topVideosFuture = sportApi.getTopVideos(sportId);
  final eventsFuture = ref
      .read(eventApiProvider)
      .search(sportIds: [sportId], limit: 100);

  return SportDetailData(
    sport: await sportFuture,
    topRiders: await topRidersFuture,
    topSpots: await topSpotsFuture,
    topPhotos: await topPhotosFuture,
    topVideos: await topVideosFuture,
    events: await eventsFuture,
  );
}
