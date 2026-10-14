import 'package:freezed_annotation/freezed_annotation.dart';

import 'ranked_media_item.dart';

part 'spot_media_ranking.freezed.dart';
part 'spot_media_ranking.g.dart';

/// Mirrors the backend's `MediaBucket` schema
/// (`app/schemas/spot_media_ranking.py`) — one gender's photos and videos,
/// each already sorted by votes descending and kept separate so the client
/// can apply the same Video/Foto toggle it uses elsewhere.
@freezed
abstract class MediaBucket with _$MediaBucket {
  const factory MediaBucket({
    required List<RankedMediaItem> photos,
    required List<RankedMediaItem> videos,
  }) = _MediaBucket;

  factory MediaBucket.fromJson(Map<String, dynamic> json) =>
      _$MediaBucketFromJson(json);
}

/// Mirrors the backend's `SpotMediaRanking` schema
/// (`app/schemas/spot_media_ranking.py`) — a spot's photos/videos grouped
/// by the gender of whoever uploaded them. Riders with no gender set don't
/// appear in any bucket. No "general" bucket here — that category is
/// served client-side from `spotPhotosProvider`/`spotVideosProvider`.
@freezed
abstract class SpotMediaRanking with _$SpotMediaRanking {
  const factory SpotMediaRanking({
    required MediaBucket female,
    required MediaBucket male,
    required MediaBucket alien,
  }) = _SpotMediaRanking;

  factory SpotMediaRanking.fromJson(Map<String, dynamic> json) =>
      _$SpotMediaRankingFromJson(json);
}
