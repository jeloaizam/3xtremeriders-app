import 'package:freezed_annotation/freezed_annotation.dart';

part 'ranked_media_item.freezed.dart';
part 'ranked_media_item.g.dart';

/// Mirrors the backend's `RankedMediaItem` schema
/// (`app/schemas/spot_media_ranking.py`) — a photo or video already
/// resolved to a common shape, tagged with `type` so the client knows how
/// to open it (photo detail vs. video player) without a separate lookup.
@freezed
abstract class RankedMediaItem with _$RankedMediaItem {
  const factory RankedMediaItem({
    required int id,
    // 'photo' | 'video'
    required String type,
    required String url,
    @JsonKey(name: 'thumbnail_url') String? thumbnailUrl,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'uploaded_by') required int uploadedBy,
    String? caption,
    @JsonKey(name: 'created_date') required DateTime createdDate,
  }) = _RankedMediaItem;

  factory RankedMediaItem.fromJson(Map<String, dynamic> json) =>
      _$RankedMediaItemFromJson(json);
}
