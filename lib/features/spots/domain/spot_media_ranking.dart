import 'package:freezed_annotation/freezed_annotation.dart';

import 'ranked_media_item.dart';

part 'spot_media_ranking.freezed.dart';
part 'spot_media_ranking.g.dart';

/// Mirrors the backend's `SpotMediaRanking` schema
/// (`app/schemas/spot_media_ranking.py`) — a spot's photos/videos grouped
/// by the gender of whoever uploaded them, each list already sorted by
/// votes descending. Riders with no gender set don't appear in any list.
@freezed
abstract class SpotMediaRanking with _$SpotMediaRanking {
  const factory SpotMediaRanking({
    required List<RankedMediaItem> female,
    required List<RankedMediaItem> male,
    required List<RankedMediaItem> alien,
  }) = _SpotMediaRanking;

  factory SpotMediaRanking.fromJson(Map<String, dynamic> json) =>
      _$SpotMediaRankingFromJson(json);
}
