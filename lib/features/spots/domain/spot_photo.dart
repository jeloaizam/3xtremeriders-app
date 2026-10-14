import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot_photo.freezed.dart';
part 'spot_photo.g.dart';

/// Mirrors the backend's `PhotoRead` schema (`app/schemas/photo.py`).
@freezed
abstract class SpotPhoto with _$SpotPhoto {
  const factory SpotPhoto({
    required int id,
    @JsonKey(name: 'spot_id') required int spotId,
    @JsonKey(name: 'sport_id') int? sportId,
    @JsonKey(name: 'uploaded_by') required int uploadedBy,
    @JsonKey(name: 'uploader_nickname') required String uploaderNickname,
    @JsonKey(name: 'uploader_icon_image') String? uploaderIconImage,
    required String url,
    String? caption,
    @JsonKey(name: 'vote_count') required int voteCount,
  }) = _SpotPhoto;

  factory SpotPhoto.fromJson(Map<String, dynamic> json) =>
      _$SpotPhotoFromJson(json);
}
