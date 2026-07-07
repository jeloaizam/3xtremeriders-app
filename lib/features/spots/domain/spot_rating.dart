import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot_rating.freezed.dart';
part 'spot_rating.g.dart';

/// Mirrors the backend's `SpotRatingRead` schema
/// (`app/schemas/spot_rating.py`) — the signed-in rider's own star rating
/// for a spot, if they've given one.
@freezed
abstract class SpotRating with _$SpotRating {
  const factory SpotRating({
    required int id,
    @JsonKey(name: 'spot_id') required int spotId,
    @JsonKey(name: 'rider_id') required int riderId,
    required int stars,
  }) = _SpotRating;

  factory SpotRating.fromJson(Map<String, dynamic> json) =>
      _$SpotRatingFromJson(json);
}
