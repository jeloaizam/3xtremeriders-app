import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/rider_sport_api.dart';
import '../domain/rider_sport.dart';

part 'rider_sports_providers.g.dart';

/// A rider's favorite sports, ordered by `order` ascending (1 = highest
/// favorite) — backend already returns them ordered
/// (`crud_rider_sport.get_all`). The lowest-`order` entry drives the Home
/// bottom nav's personalized sport chip.
@riverpod
Future<List<RiderSport>> riderSports(Ref ref, int riderId) {
  return ref.read(riderSportApiProvider).list(riderId);
}
