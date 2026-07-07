import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot.freezed.dart';
part 'spot.g.dart';

/// Mirrors the backend's `SpotRead` schema (`app/schemas/spot.py`).
@freezed
abstract class Spot with _$Spot {
  const factory Spot({
    required int id,
    required String name,
    required String description,
    required double latitude,
    required double longitude,
    int? difficulty,
    @JsonKey(name: 'best_season') String? bestSeason,
    String? neighborhood,
    @JsonKey(name: 'open_hour') String? openHour,
    @JsonKey(name: 'close_hour') String? closeHour,
    @JsonKey(name: 'created_by') required int createdBy,
    @JsonKey(name: 'state_id') int? stateId,
    @JsonKey(name: 'rating_avg') double? ratingAvg,
    @JsonKey(name: 'rating_count') required int ratingCount,
    @JsonKey(name: 'hazard_avg') double? hazardAvg,
    @JsonKey(name: 'hazard_count') required int hazardCount,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,
    @JsonKey(name: 'cover_video_url') String? coverVideoUrl,
    @JsonKey(name: 'created_date') required DateTime createdDate,
    @JsonKey(name: 'updated_date') DateTime? updatedDate,
  }) = _Spot;

  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);
}
