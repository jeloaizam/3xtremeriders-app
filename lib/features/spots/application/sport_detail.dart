import '../../auth/domain/rider.dart';
import '../../events/domain/event.dart';
import '../domain/spot.dart';
import '../domain/spot_photo.dart';
import '../domain/spot_video.dart';
import '../domain/sport.dart';

/// Everything the Sport detail screen needs, combined by
/// [sportDetailProvider].
class SportDetailData {
  const SportDetailData({
    required this.sport,
    required this.topRiders,
    required this.topSpots,
    required this.topPhotos,
    required this.topVideos,
    required this.events,
  });

  final Sport sport;
  final List<Rider> topRiders;
  final List<Spot> topSpots;
  final List<SpotPhoto> topPhotos;
  final List<SpotVideo> topVideos;

  /// Ordered by `start_date` asc (backend order) — split into past/upcoming
  /// client-side by the screen, same as `EventsListScreen`.
  final List<Event> events;
}
