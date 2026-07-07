import 'package:freezed_annotation/freezed_annotation.dart';

import '../../auth/domain/rider.dart';
import '../domain/hazzard.dart';
import '../domain/spot.dart';
import '../domain/spot_comment.dart';
import '../domain/spot_element.dart';
import '../domain/spot_hazard_rating.dart';
import '../domain/spot_rating.dart';
import '../domain/sport.dart';

part 'spot_detail.freezed.dart';

/// A [SpotComment] paired with the [Rider] who wrote it, resolved client-side
/// since `CommentRead` only carries `rider_id`.
@freezed
abstract class SpotCommentWithAuthor with _$SpotCommentWithAuthor {
  const factory SpotCommentWithAuthor({
    required SpotComment comment,
    required Rider author,
  }) = _SpotCommentWithAuthor;
}

/// Everything the Spot detail screen needs, fetched in parallel from several
/// real endpoints and combined for the UI.
@freezed
abstract class SpotDetailData with _$SpotDetailData {
  const factory SpotDetailData({
    required Spot spot,
    required List<Sport> sports,
    required List<SpotElement> elements,
    required List<Hazzard> hazzards,
    required List<SpotCommentWithAuthor> comments,
    required Rider creator,
    required bool iLiked,
    SpotRating? myRating,
    SpotHazardRating? myHazardRating,
  }) = _SpotDetailData;
}
