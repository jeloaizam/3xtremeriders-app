import 'package:freezed_annotation/freezed_annotation.dart';

part 'spot_comment.freezed.dart';
part 'spot_comment.g.dart';

/// Mirrors the backend's `CommentRead` schema (`app/schemas/comment.py`).
/// Comments are polymorphic server-side (spot/photo/video/profile/event);
/// this client only deals with `target_type == 'spot'` so far.
@freezed
abstract class SpotComment with _$SpotComment {
  const factory SpotComment({
    required int id,
    @JsonKey(name: 'rider_id') required int riderId,
    @JsonKey(name: 'parent_id') int? parentId,
    required String body,
    @JsonKey(name: 'vote_count') required int voteCount,
    @JsonKey(name: 'created_date') required DateTime createdDate,
  }) = _SpotComment;

  factory SpotComment.fromJson(Map<String, dynamic> json) =>
      _$SpotCommentFromJson(json);
}
