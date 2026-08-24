import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/data/rider_api.dart';
import '../data/spot_comment_api.dart';
import 'spot_detail.dart';

part 'media_comments.g.dart';

/// Comments (with author resolved) for a photo or video's own comment
/// thread — same shape/resolution as `spotDetailProvider`'s `comments`
/// field, just for `targetType` 'photo'/'video' instead of 'spot'. Kept as
/// its own provider (not folded into `spotDetailProvider`) since a
/// photo/video's comments are only ever needed once its own detail screen
/// opens, not every time the spot loads.
@riverpod
Future<List<SpotCommentWithAuthor>> mediaComments(
  Ref ref,
  String targetType,
  int targetId,
) async {
  final commentApi = ref.read(spotCommentApiProvider);
  final riderApi = ref.read(riderApiProvider);

  final comments = await commentApi.listFor(
    targetType: targetType,
    targetId: targetId,
  );

  final riderIds = {for (final c in comments) c.riderId};
  final ridersById = {for (final id in riderIds) id: await riderApi.get(id)};

  return [
    for (final c in comments)
      SpotCommentWithAuthor(comment: c, author: ridersById[c.riderId]!),
  ];
}
