import '../domain/ride.dart';
import '../domain/ride_element.dart';
import '../domain/rider_photo.dart';
import '../domain/rider_video.dart';

/// Everything the Ride detail screen needs, combined by [rideDetailProvider].
class RideDetailData {
  const RideDetailData({
    required this.ride,
    required this.elements,
    required this.photos,
    required this.videos,
  });

  final Ride ride;
  final List<RideElement> elements;
  final List<RiderPhoto> photos;
  final List<RiderVideo> videos;
}
