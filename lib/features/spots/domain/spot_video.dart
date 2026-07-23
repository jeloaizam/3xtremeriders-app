import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot_video.freezed.dart';
part 'spot_video.g.dart';

/// Mirrors the backend's `VideoRead` schema (`app/schemas/video.py`).
@freezed
abstract class SpotVideo with _$SpotVideo {
  const factory SpotVideo({
    required int id,
    @JsonKey(name: 'spot_id') required int spotId,
    @JsonKey(name: 'sport_id') int? sportId,
    required String url,
    String? provider,
    String? caption,
    @JsonKey(name: 'vote_count') required int voteCount,
  }) = _SpotVideo;

  factory SpotVideo.fromJson(Map<String, dynamic> json) =>
      _$SpotVideoFromJson(json);
}
