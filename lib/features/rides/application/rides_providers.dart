import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/ride_api.dart';
import '../data/rider_photo_api.dart';
import '../data/rider_video_api.dart';
import '../domain/ride.dart';
import '../domain/ride_state.dart';
import 'ride_detail.dart';

part 'rides_providers.g.dart';

/// A rider's rides (gear/vehicles), fetched from `GET /riders/{id}/rides`.
@riverpod
Future<List<Ride>> ridesByOwner(Ref ref, int riderId) {
  return ref.read(rideApiProvider).listByOwner(riderId);
}

/// The fixed catalog of ride states (active/onSale/wasted/toGift) — used by
/// CreateRideScreen's state picker and RideScreen's status badge.
@Riverpod(keepAlive: true)
Future<List<RideState>> rideStates(Ref ref) {
  return ref.read(rideApiProvider).listStates();
}

/// Everything the Ride detail screen needs for one ride, fetched in
/// parallel: the ride itself, its elements, and the owner's photos/videos
/// tagged with this ride specifically.
@Riverpod(keepAlive: true)
Future<RideDetailData> rideDetail(Ref ref, int rideId) async {
  final rideApi = ref.read(rideApiProvider);
  final ride = await rideApi.get(rideId);

  final elementsFuture = rideApi.getElements(rideId);
  final photosFuture = ref
      .read(riderPhotoApiProvider)
      .listByRider(ride.ownerId, rideId: rideId);
  final videosFuture = ref
      .read(riderVideoApiProvider)
      .listByRider(ride.ownerId, rideId: rideId);

  final elements = await elementsFuture;
  final photos = await photosFuture;
  final videos = await videosFuture;

  return RideDetailData(
    ride: ride,
    elements: elements,
    photos: photos,
    videos: videos,
  );
}
