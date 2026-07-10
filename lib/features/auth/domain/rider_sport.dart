import 'package:freezed_annotation/freezed_annotation.dart';

part 'rider_sport.freezed.dart';
part 'rider_sport.g.dart';

/// Mirrors the backend's `RiderSportRead` schema (`app/schemas/rider_sport.py`)
/// — one of a rider's favorite sports (up to 10, ranked by `order`, 1 =
/// highest favorite). Drives the Home bottom nav's personalized sport chip
/// and the Settings favorite-sports picker.
@freezed
abstract class RiderSport with _$RiderSport {
  const factory RiderSport({
    required int id,
    @JsonKey(name: 'rider_id') required int riderId,
    @JsonKey(name: 'sport_id') required int sportId,
    required int order,
  }) = _RiderSport;

  factory RiderSport.fromJson(Map<String, dynamic> json) =>
      _$RiderSportFromJson(json);
}
