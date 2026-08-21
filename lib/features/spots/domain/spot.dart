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
    // Resueltos por reverse geocoding de Mapbox al crear/editar el spot —
    // ninguno es obligatorio (spots viejos, o geocoding que falló).
    @JsonKey(name: 'city_id') int? cityId,
    @JsonKey(name: 'country_id') int? countryId,
    @JsonKey(name: 'city_name') String? cityName,
    @JsonKey(name: 'country_name') String? countryName,
    @JsonKey(name: 'category_id') required int categoryId,
    // 'xtremespot' | 'publico' | 'privado' | 'iconico'
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'rating_avg') double? ratingAvg,
    @JsonKey(name: 'rating_count') required int ratingCount,
    @JsonKey(name: 'hazard_avg') double? hazardAvg,
    @JsonKey(name: 'hazard_count') required int hazardCount,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'cover_photo_url') String? coverPhotoUrl,
    @JsonKey(name: 'cover_video_url') String? coverVideoUrl,
    @JsonKey(name: 'cover_video_thumbnail_url') String? coverVideoThumbnailUrl,
    // 'photo' | 'video' | null — cuál portada tiene más votos, para elegir
    // qué ícono mostrar en tarjetas compactas sin pedir el conteo aparte.
    @JsonKey(name: 'top_media_type') String? topMediaType,
    @JsonKey(name: 'created_date') required DateTime createdDate,
    @JsonKey(name: 'updated_date') DateTime? updatedDate,
    // Drives the map pin icon: one sport shows its icon, several show the
    // multi-sport badge — resolved client-side against `allSportsProvider`.
    @JsonKey(name: 'sport_ids') @Default([]) List<int> sportIds,
  }) = _Spot;

  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);
}
