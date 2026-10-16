import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_providers.dart';
import '../data/spot_photo_api.dart';
import '../data/spot_video_api.dart';
import '../data/vote_api.dart';
import '../domain/spot_photo.dart';
import '../domain/spot_video.dart';

part 'spot_media_providers.g.dart';

/// A spot's photos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery. `sportId` scopes the
/// ranking to one of the spot's sports (null = every photo on the spot,
/// only meaningful for spots with a single sport or legacy untagged media).
@Riverpod(keepAlive: true)
Future<List<SpotPhoto>> spotPhotos(Ref ref, int spotId, int? sportId) {
  return ref.read(spotPhotoApiProvider).listBySpot(spotId, sportId: sportId);
}

/// A spot's videos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery. See [spotPhotos] for
/// what `sportId` does.
@Riverpod(keepAlive: true)
Future<List<SpotVideo>> spotVideos(Ref ref, int spotId, int? sportId) {
  return ref.read(spotVideoApiProvider).listBySpot(spotId, sportId: sportId);
}

/// Whether the signed-in rider has already voted each of a spot's photos,
/// keyed by photo id — drives the filled/outline heart on each media tile.
/// One `/votes/check` call per photo (N+1, acceptable given spots only have
/// a handful of photos).
@Riverpod(keepAlive: true)
Future<Map<int, bool>> spotPhotoVotes(Ref ref, int spotId, int? sportId) async {
  final photos = await ref.watch(spotPhotosProvider(spotId, sportId).future);
  return _checkVotes(
    ref,
    targetType: 'photo',
    ids: [for (final p in photos) p.id],
  );
}

/// Same as [spotPhotoVotes] but for videos.
@Riverpod(keepAlive: true)
Future<Map<int, bool>> spotVideoVotes(Ref ref, int spotId, int? sportId) async {
  final videos = await ref.watch(spotVideosProvider(spotId, sportId).future);
  return _checkVotes(
    ref,
    targetType: 'video',
    ids: [for (final v in videos) v.id],
  );
}

Future<Map<int, bool>> _checkVotes(
  Ref ref, {
  required String targetType,
  required List<int> ids,
}) async {
  if (ids.isEmpty) return {};

  final user = ref.read(firebaseAuthProvider).currentUser;
  final idToken = await user?.getIdToken();
  if (idToken == null) return {for (final id in ids) id: false};

  final voteApi = ref.read(voteApiProvider);
  final results = await Future.wait([
    for (final id in ids)
      voteApi
          .check(targetType: targetType, targetId: id, idToken: idToken)
          .catchError((_) => false),
  ]);
  return {for (var i = 0; i < ids.length; i++) ids[i]: results[i]};
}
