import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/rider_api.dart';
import '../domain/rider.dart';

part 'rider_profile_providers.g.dart';

/// A single rider's public profile, fetched from `GET /riders/{id}` —
/// backs [RiderProfileScreen] (viewing any rider, not just the signed-in
/// one — see [CurrentRider] for that).
@riverpod
Future<Rider> riderProfile(Ref ref, int riderId) {
  return ref.read(riderApiProvider).get(riderId);
}
