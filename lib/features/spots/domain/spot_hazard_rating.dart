import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot_hazard_rating.freezed.dart';
part 'spot_hazard_rating.g.dart';

/// Mirrors the backend's `SpotHazardRatingRead` schema
/// (`app/schemas/spot_hazard_rating.py`) — the signed-in rider's own
/// "crutches" (1-5) danger rating for a spot, if they've given one. Distinct
/// from [Hazzard], which are named/described point reports.
@freezed
abstract class SpotHazardRating with _$SpotHazardRating {
  const factory SpotHazardRating({
    required int id,
    @JsonKey(name: 'spot_id') required int spotId,
    @JsonKey(name: 'rider_id') required int riderId,
    required int crutches,
  }) = _SpotHazardRating;

  factory SpotHazardRating.fromJson(Map<String, dynamic> json) =>
      _$SpotHazardRatingFromJson(json);
}
