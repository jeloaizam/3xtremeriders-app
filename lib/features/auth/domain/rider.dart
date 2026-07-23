import 'package:freezed_annotation/freezed_annotation.dart';

part 'rider.freezed.dart';
part 'rider.g.dart';

/// Mirrors the backend's `RiderRead` schema (`app/schemas/rider.py`).
@freezed
abstract class Rider with _$Rider {
  const factory Rider({
    required int id,
    @JsonKey(name: 'firebase_uid') required String firebaseUid,
    @JsonKey(name: 'role_id') required int roleId,
    required String email,
    required String name,
    @JsonKey(name: 'last_name') required String lastName,
    required String nickname,
    @JsonKey(name: 'icon_image') String? iconImage,
    String? bio,
    @JsonKey(name: 'city_id') int? cityId,
    @JsonKey(name: 'city_text') String? cityText,
    @JsonKey(name: 'city_name') String? cityName,
    @JsonKey(name: 'country_id') int? countryId,
    @JsonKey(name: 'social_links') Map<String, dynamic>? socialLinks,
    @JsonKey(name: 'reputation_pts') required int reputationPts,
    // The rider's "current" sport — prioritizes Home's ordering and
    // preselects the sport picker when creating a spot. Null until the
    // rider explicitly picks one (see `needsProfileCompletionProvider`'s
    // sibling `effectiveActiveSport` in auth_providers.dart for the
    // favorite-#1 fallback used while this is unset).
    @JsonKey(name: 'active_sport_id') int? activeSportId,
    // Sport ids the rider chose to show on Home's map ("Personalizar
    // mapa") — null means no filter (show every sport).
    @JsonKey(name: 'map_sport_filter') List<int>? mapSportFilter,
    @JsonKey(name: 'created_date') required DateTime createdDate,
    @JsonKey(name: 'updated_date') DateTime? updatedDate,
  }) = _Rider;

  factory Rider.fromJson(Map<String, dynamic> json) => _$RiderFromJson(json);
}
