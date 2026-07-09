import 'package:freezed_annotation/freezed_annotation.dart';

part 'rider_photo.freezed.dart';
part 'rider_photo.g.dart';

/// Mirrors the backend's `RiderPhotoRead` schema
/// (`app/schemas/rider_photo.py`) — a photo on the rider's own profile,
/// optionally tagged with a [Ride] via `rideId`.
@freezed
abstract class RiderPhoto with _$RiderPhoto {
  const factory RiderPhoto({
    required int id,
    @JsonKey(name: 'rider_id') required int riderId,
    @JsonKey(name: 'ride_id') int? rideId,
    required String url,
    String? caption,
    @JsonKey(name: 'created_date') required DateTime createdDate,
  }) = _RiderPhoto;

  factory RiderPhoto.fromJson(Map<String, dynamic> json) =>
      _$RiderPhotoFromJson(json);
}
