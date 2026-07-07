import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_providers.dart';
import '../../auth/data/rider_api.dart';
import '../data/hazzard_api.dart';
import '../data/spot_api.dart';
import '../data/spot_comment_api.dart';
import '../data/spot_hazard_rating_api.dart';
import '../data/spot_photo_api.dart';
import '../data/spot_rating_api.dart';
import '../data/spot_video_api.dart';
import '../data/vote_api.dart';
import '../domain/hazzard.dart';
import '../domain/spot.dart';
import '../domain/spot_element.dart';
import '../domain/spot_photo.dart';
import '../domain/spot_video.dart';
import '../domain/sport.dart';
import 'spot_detail.dart';

part 'spots_providers.g.dart';

/// Real spots near the user, fetched from `GET /spots`.
@riverpod
Future<List<Spot>> nearbySpots(Ref ref) {
  return ref.read(spotApiProvider).list();
}

/// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
/// spotId so Home's list and the Spot detail screen share one fetch.
///
/// keepAlive: without it, this (and the other small per-spot providers
/// below) gets disposed the instant nothing is watching it even for a
/// single frame — which happened during scroll on the Spot screen's media
/// gallery (a nested widget watching it independently of the parent's
/// `spotDetailProvider` watch), making it silently refetch and show fewer
/// items right after the fetch, then the full list again once it resolved.
@Riverpod(keepAlive: true)
Future<List<Sport>> spotSports(Ref ref, int spotId) {
  return ref.read(spotApiProvider).getSports(spotId);
}

/// A spot's hazards — cached per spotId so Home's map quick-view sheet and
/// the Spot detail screen share one fetch.
@Riverpod(keepAlive: true)
Future<List<Hazzard>> spotHazzards(Ref ref, int spotId) {
  return ref.read(hazzardApiProvider).listBySpot(spotId);
}

/// A spot's physical elements — cached per spotId so Home's map quick-view
/// sheet (just needs the count) and the Spot detail screen share one fetch.
@Riverpod(keepAlive: true)
Future<List<SpotElement>> spotElements(Ref ref, int spotId) {
  return ref.read(spotApiProvider).getElements(spotId);
}

/// A spot's photos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery.
@Riverpod(keepAlive: true)
Future<List<SpotPhoto>> spotPhotos(Ref ref, int spotId) {
  return ref.read(spotPhotoApiProvider).listBySpot(spotId);
}

/// A spot's videos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery.
@Riverpod(keepAlive: true)
Future<List<SpotVideo>> spotVideos(Ref ref, int spotId) {
  return ref.read(spotVideoApiProvider).listBySpot(spotId);
}

/// Everything the Spot detail screen needs for one spot, fetched in
/// parallel and combined: the spot itself, its sports, hazards, comments
/// (each resolved to its author), the creator's profile, whether the
/// signed-in rider already liked it, and their own star rating if any.
///
/// keepAlive: SpotScreen's `detailAsync.when()` renders a completely
/// different widget for `loading` vs `data` — if this provider isn't kept
/// alive, a momentary listener gap (e.g. during scroll) disposes it, and the
/// next watch briefly returns `loading` again, tearing down and rebuilding
/// the whole `_SpotScreenBody` subtree (which is why the media gallery's
/// own local state — the video/photo tab — was resetting on scroll).
@Riverpod(keepAlive: true)
Future<SpotDetailData> spotDetail(Ref ref, int spotId) async {
  final spotApi = ref.read(spotApiProvider);
  final commentApi = ref.read(spotCommentApiProvider);
  final riderApi = ref.read(riderApiProvider);
  final voteApi = ref.read(voteApiProvider);
  final ratingApi = ref.read(spotRatingApiProvider);
  final hazardRatingApi = ref.read(spotHazardRatingApiProvider);

  final spot = await spotApi.get(spotId);

  final user = ref.read(firebaseAuthProvider).currentUser;
  final idToken = await user?.getIdToken();

  final sportsFuture = ref.read(spotSportsProvider(spotId).future);
  final elementsFuture = ref.read(spotElementsProvider(spotId).future);
  final hazzardsFuture = ref.read(spotHazzardsProvider(spotId).future);
  final commentsFuture = commentApi.listForSpot(spotId);
  final creatorFuture = riderApi.get(spot.createdBy);
  // Personalization signals only — if these fail (e.g. the rider hasn't
  // finished syncing with the backend yet) the rest of the screen should
  // still render, just without a like/rating state for this rider.
  final likedFuture = idToken == null
      ? Future.value(false)
      : voteApi
          .check(targetType: 'spot', targetId: spotId, idToken: idToken)
          .catchError((_) => false);
  final myRatingFuture = idToken == null
      ? Future.value(null)
      : ratingApi
          .getMine(spotId: spotId, idToken: idToken)
          .catchError((_) => null);
  final myHazardRatingFuture = idToken == null
      ? Future.value(null)
      : hazardRatingApi
          .getMine(spotId: spotId, idToken: idToken)
          .catchError((_) => null);

  final sports = await sportsFuture;
  final elements = await elementsFuture;
  final hazzards = await hazzardsFuture;
  final comments = await commentsFuture;
  final creator = await creatorFuture;
  final iLiked = await likedFuture;
  final myRating = await myRatingFuture;
  final myHazardRating = await myHazardRatingFuture;

  final riderIds = {for (final c in comments) c.riderId};
  final ridersById = {for (final id in riderIds) id: await riderApi.get(id)};
  final commentsWithAuthor = [
    for (final c in comments)
      SpotCommentWithAuthor(comment: c, author: ridersById[c.riderId]!),
  ];

  return SpotDetailData(
    spot: spot,
    sports: sports,
    elements: elements,
    hazzards: hazzards,
    comments: commentsWithAuthor,
    creator: creator,
    iLiked: iLiked,
    myRating: myRating,
    myHazardRating: myHazardRating,
  );
}
