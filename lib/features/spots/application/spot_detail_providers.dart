import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../auth/application/auth_providers.dart';
import '../../auth/data/rider_api.dart';
import '../data/spot_api.dart';
import '../data/spot_comment_api.dart';
import '../data/spot_hazard_rating_api.dart';
import '../data/spot_rating_api.dart';
import '../data/vote_api.dart';
import 'spot_attributes_providers.dart';
import 'spot_detail.dart';
import 'spot_providers.dart';

part 'spot_detail_providers.g.dart';

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
  final commentsFuture = commentApi.listFor(
    targetType: 'spot',
    targetId: spotId,
  );
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
