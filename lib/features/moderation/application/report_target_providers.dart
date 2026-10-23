import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_exception.dart';
import '../../spots/data/spot_comment_api.dart';
import '../../spots/data/spot_photo_api.dart';
import '../../spots/data/spot_video_api.dart';
import '../../spots/domain/spot_comment.dart';
import '../../spots/domain/spot_photo.dart';
import '../../spots/domain/spot_video.dart';

part 'report_target_providers.g.dart';

/// Resolves the content a [Report] points at, for [ModerationQueueScreen] to
/// render inline (body text / thumbnail) instead of just the bare id — null
/// means it's gone (photo/video are hard-deleted, so a past "Accionado"
/// report 404s; a soft-deleted comment still resolves, just with
/// `state == commentStateDeleted`).
@riverpod
Future<SpotComment?> reportedComment(Ref ref, int commentId) async {
  try {
    return await ref.watch(spotCommentApiProvider).get(commentId);
  } on ApiException catch (e) {
    if (e.statusCode == 404) return null;
    rethrow;
  }
}

@riverpod
Future<SpotPhoto?> reportedPhoto(Ref ref, int photoId) async {
  try {
    return await ref.watch(spotPhotoApiProvider).get(photoId);
  } on ApiException catch (e) {
    if (e.statusCode == 404) return null;
    rethrow;
  }
}

@riverpod
Future<SpotVideo?> reportedVideo(Ref ref, int videoId) async {
  try {
    return await ref.watch(spotVideoApiProvider).get(videoId);
  } on ApiException catch (e) {
    if (e.statusCode == 404) return null;
    rethrow;
  }
}
