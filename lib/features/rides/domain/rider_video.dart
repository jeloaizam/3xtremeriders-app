import 'package:freezed_annotation/freezed_annotation.dart';

part 'rider_video.freezed.dart';
part 'rider_video.g.dart';

/// Mirrors the backend's `RiderVideoRead` schema
/// (`app/schemas/rider_video.py`) — a video on the rider's own profile,
/// optionally tagged with a [Ride] via `rideId`.
@freezed
abstract class RiderVideo with _$RiderVideo {
  const factory RiderVideo({
    required int id,
    @JsonKey(name: 'rider_id') required int riderId,
    @JsonKey(name: 'ride_id') int? rideId,
    required String url,
    String? provider,
    String? caption,
    @JsonKey(name: 'created_date') required DateTime createdDate,
  }) = _RiderVideo;

  factory RiderVideo.fromJson(Map<String, dynamic> json) =>
      _$RiderVideoFromJson(json);
}
