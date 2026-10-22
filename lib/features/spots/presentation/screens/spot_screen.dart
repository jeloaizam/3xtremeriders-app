import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../../auth/domain/role.dart';
import '../../application/spot_detail.dart';
import '../../application/spot_detail_providers.dart';
import '../../data/spot_hazard_rating_api.dart';
import '../../data/spot_rating_api.dart';
import '../../data/vote_api.dart';
import '../widgets/spot_detail/info_rating_box.dart';
import '../widgets/spot_detail/more_info_box.dart';
import '../widgets/spot_detail/rank_tv_box.dart';
import '../widgets/spot_detail/separator_box.dart';
import '../widgets/spot_detail/sport_button_box.dart';
import '../widgets/spot_detail/spot_name_box.dart';

/// Mirrors the `isSpot` state of `Deportes Extremos App v2.dc.html` (the
/// original full prototype) and, since the category-by-category redesign
/// (`squishy-wandering-truffle.md`), the 7-component mockup
/// (`RankTvBox`/`RankTvButtonBox`/`SeparatorBox`/`SpotNameBox`/
/// `SportButtonBox`/`InfoRatingBox`/`MoreInfoBox`, each its own file under
/// `widgets/spot_detail/`) — backed entirely by real data (`GET
/// /spots/{id}` and friends), no mocks.
class SpotScreen extends ConsumerStatefulWidget {
  const SpotScreen({super.key, required this.spotId});

  final int spotId;

  @override
  ConsumerState<SpotScreen> createState() => _SpotScreenState();
}

class _SpotScreenState extends ConsumerState<SpotScreen> {
  // Guards against duplicate taps while a like/rate request is in flight —
  // without it, a second tap before the refetch lands re-sends the same
  // action and the backend rejects it (e.g. 409 "Already voted"), which
  // otherwise silently does nothing from the rider's point of view.
  bool _busy = false;

  Future<void> _toggleLike(bool currentlyLiked) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;

      final voteApi = ref.read(voteApiProvider);
      if (currentlyLiked) {
        await voteApi.unvote(
          targetType: 'spot',
          targetId: widget.spotId,
          idToken: idToken,
        );
      } else {
        await voteApi.vote(
          targetType: 'spot',
          targetId: widget.spotId,
          idToken: idToken,
        );
      }
    } catch (_) {
      // e.g. already liked/unliked from a prior tap — reconcile via refetch
      // below rather than surfacing an error for something already in sync.
    } finally {
      ref.invalidate(spotDetailProvider(widget.spotId));
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _rate(int stars) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(spotRatingApiProvider)
          .rate(spotId: widget.spotId, stars: stars, idToken: idToken);
      ref.invalidate(spotDetailProvider(widget.spotId));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _rateHazard(int crutches) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;

      await ref
          .read(spotHazardRatingApiProvider)
          .rate(spotId: widget.spotId, crutches: crutches, idToken: idToken);
      ref.invalidate(spotDetailProvider(widget.spotId));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).comingSoon)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(spotDetailProvider(widget.spotId));
    final currentRider = ref.watch(currentRiderProvider).value;

    return Scaffold(
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (detail) {
            final canEdit =
                currentRider != null &&
                (currentRider.id == detail.spot.createdBy ||
                    currentRider.roleId >= roleAdmin);
            // 'iconico' spots only accept media uploads from admin/moderator
            // (see crud_spot.can_upload_media, backend is the real gate).
            final canUploadMedia =
                detail.spot.categoryName != 'iconico' ||
                (currentRider != null && currentRider.roleId >= roleModerator);
            return _SpotScreenBody(
              spotId: widget.spotId,
              detail: detail,
              busy: _busy,
              canEdit: canEdit,
              canUploadMedia: canUploadMedia,
              onBack: () => context.pop(),
              onEdit: () => context.push('/spot/${widget.spotId}/edit'),
              onToggleLike: () => _toggleLike(detail.iLiked),
              onRate: _rate,
              onRateHazard: _rateHazard,
              onComingSoon: _showComingSoon,
            );
          },
        ),
      ),
    );
  }
}

class _SpotScreenBody extends ConsumerWidget {
  const _SpotScreenBody({
    required this.spotId,
    required this.detail,
    required this.busy,
    required this.canEdit,
    required this.canUploadMedia,
    required this.onBack,
    required this.onEdit,
    required this.onToggleLike,
    required this.onRate,
    required this.onRateHazard,
    required this.onComingSoon,
  });

  final int spotId;
  final SpotDetailData detail;
  final bool busy;
  final bool canEdit;
  final bool canUploadMedia;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final VoidCallback onToggleLike;
  final void Function(int stars) onRate;
  final void Function(int crutches) onRateHazard;
  final VoidCallback onComingSoon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final spot = detail.spot;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        RankTvBox(
          spotId: spotId,
          sports: detail.sports,
          hasGeneralLibrary: spot.categoryName != 'xtremespot',
          hasGenderRankings: spot.categoryName != 'iconico',
          canUploadMedia: canUploadMedia,
          canEdit: canEdit,
          spotVoteCount: spot.voteCount,
          iLiked: detail.iLiked,
          busy: busy,
          onBack: onBack,
          onEdit: onEdit,
          onToggleLike: onToggleLike,
          onComingSoon: onComingSoon,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ordered content blocks, driven by the spot's category (see
              // `_sectionsFor` — plan `squishy-wandering-truffle.md`). All 4
              // categories share this exact order today; per-category
              // divergence lands one category at a time on top of this.
              for (final section in _sectionsFor(spot.categoryName)) ...[
                switch (section) {
                  _SpotSection.separator => const SeparatorBox(),
                  _SpotSection.spotName => SpotNameBox(spot: spot),
                  _SpotSection.sportButtons => SportButtonBox(
                    sports: detail.sports,
                  ),
                  _SpotSection.infoRating => InfoRatingBox(
                    ratingAvg: spot.ratingAvg,
                    hazardAvg: spot.hazardAvg,
                    bestSeason: spot.bestSeason,
                    difficulty: spot.difficulty,
                    myStars: detail.myRating?.stars ?? 0,
                    myCrutches: detail.myHazardRating?.crutches ?? 0,
                    busy: busy,
                    onRate: onRate,
                    onRateHazard: onRateHazard,
                  ),
                  _SpotSection.moreInfo => MoreInfoBox(
                    spot: spot,
                    creator: detail.creator,
                    elements: detail.elements,
                    hazzards: detail.hazzards,
                    spotId: spotId,
                    comments: detail.comments,
                  ),
                },
                SizedBox(height: _sectionGapAfter(section)),
              ],
              AppButton(
                label: l10n.spotBack,
                variant: AppButtonVariant.ghost,
                onPressed: onBack,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// One content block on the Spot screen, below `RankTvBox`/
/// `RankTvButtonBox` (page chrome, not reorderable/droppable per category)
/// — see `_sectionsFor` for the order each spot category renders them in.
enum _SpotSection { separator, spotName, sportButtons, infoRating, moreInfo }

/// Which blocks a spot screen shows, and in what order — the mechanism
/// behind the per-category redesign (plan `squishy-wandering-truffle.md`).
/// All 4 categories share the same order today; the per-category rollout
/// adds real `switch (categoryName)` cases here one category at a time,
/// reusing the same section widgets rather than duplicating screens.
///
/// Note: `creatorCard`/`elements`/`hazards`/`comments` were independently
/// orderable blocks before the 7-component rebuild; they're now bundled
/// inside `moreInfo`'s tabs. If a future category needs to reorder those
/// independently again, give `MoreInfoBox` its own nested tab-order list
/// rather than re-splitting them out of this enum.
List<_SpotSection> _sectionsFor(String categoryName) {
  const defaultOrder = [
    _SpotSection.separator,
    _SpotSection.spotName,
    _SpotSection.sportButtons,
    _SpotSection.infoRating,
    _SpotSection.moreInfo,
  ];
  return defaultOrder;
}

/// Vertical gap after each section — kept as a lookup instead of baked
/// into each widget so it stays easy to retune per category later.
double _sectionGapAfter(_SpotSection section) => switch (section) {
  _SpotSection.separator => 16,
  _SpotSection.spotName => 16,
  _SpotSection.sportButtons => 18,
  _SpotSection.infoRating => 22,
  _SpotSection.moreInfo => 16,
};
