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
    String? city,
    @JsonKey(name: 'social_links') Map<String, dynamic>? socialLinks,
    @JsonKey(name: 'reputation_pts') required int reputationPts,
    @JsonKey(name: 'created_date') required DateTime createdDate,
    @JsonKey(name: 'updated_date') DateTime? updatedDate,
  }) = _Rider;

  factory Rider.fromJson(Map<String, dynamic> json) => _$RiderFromJson(json);
}
