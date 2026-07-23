import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/storage/storage_api.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_avatar.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/spot_detail.dart';
import '../../application/spots_providers.dart';
import '../../data/spot_comment_api.dart';
import '../../data/spot_hazard_rating_api.dart';
import '../../data/spot_photo_api.dart';
import '../../data/spot_rating_api.dart';
import '../../data/spot_video_api.dart';
import '../../data/vote_api.dart';
import '../../domain/hazzard.dart';
import '../../domain/spot_element.dart';
import '../../domain/sport.dart';
import '../sport_visuals.dart';
import '../widgets/stat_tile.dart';
import '../widgets/video_player_screen.dart';
import 'spot_media_library_screen.dart';

/// Mirrors the `isSpot` state of `Deportes Extremos App v2.dc.html` (the
/// full prototype) — backed entirely by real data (`GET /spots/{id}` and
/// friends), no mocks.
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

    return Scaffold(
      body: SafeArea(
        child: detailAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
          data: (detail) => _SpotScreenBody(
            spotId: widget.spotId,
            detail: detail,
            busy: _busy,
            onBack: () => context.pop(),
            onToggleLike: () => _toggleLike(detail.iLiked),
            onRate: _rate,
            onRateHazard: _rateHazard,
            onComingSoon: _showComingSoon,
          ),
        ),
      ),
    );
  }
}

class _SpotScreenBody extends StatelessWidget {
  const _SpotScreenBody({
    required this.spotId,
    required this.detail,
    required this.busy,
    required this.onBack,
    required this.onToggleLike,
    required this.onRate,
    required this.onRateHazard,
    required this.onComingSoon,
  });

  final int spotId;
  final SpotDetailData detail;
  final bool busy;
  final VoidCallback onBack;
  final VoidCallback onToggleLike;
  final void Function(int stars) onRate;
  final void Function(int crutches) onRateHazard;
  final VoidCallback onComingSoon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;
    final spot = detail.spot;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _MediaGallery(
          spotId: spotId,
          onBack: onBack,
          onComingSoon: onComingSoon,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          spot.name.toUpperCase(),
                          style: context.typography.displayMd,
                        ),
                        if (detail.sports.isNotEmpty) ...[
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 7,
                            runSpacing: 7,
                            children: [
                              for (final sport in detail.sports)
                                _SportChip(id: sport.id, name: sport.name),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: busy ? null : onToggleLike,
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Opacity(
                        opacity: busy ? .5 : 1,
                        child: Column(
                          children: [
                            Icon(
                              Symbols.favorite,
                              fill: detail.iLiked ? 1 : 0,
                              size: 24,
                              color: colors.colorAction,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${spot.voteCount}',
                              style: context.typography.title.copyWith(
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => context.push('/riders/${detail.creator.id}'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: colors.surfaceCard,
                    border: Border.all(color: colors.hairline),
                    borderRadius: BorderRadius.circular(
                      context.spacing.radiusMd,
                    ),
                  ),
                  child: Row(
                    children: [
                      AppAvatar(
                        initial: detail.creator.nickname.isNotEmpty
                            ? detail.creator.nickname[0].toUpperCase()
                            : '?',
                        imageUrl: detail.creator.iconImage,
                        size: AppAvatarSize.sm,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.spotCreatedBy,
                              style: context.typography.micro,
                            ),
                            Text(
                              detail.creator.nickname,
                              style: context.typography.title.copyWith(
                                height: 1.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Symbols.chevron_right,
                        size: 20,
                        color: colors.text700,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _RatingCard(
                spotRatingAvg: spot.ratingAvg,
                spotRatingCount: spot.ratingCount,
                myStars: detail.myRating?.stars ?? 0,
                busy: busy,
                onRate: onRate,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  StatTile(
                    icon: Symbols.star,
                    value: spot.ratingAvg?.toStringAsFixed(1) ?? '—',
                    label: l10n.spotRatingsCount(spot.ratingCount),
                    tone: StatTileTone.rating,
                  ),
                  const SizedBox(width: 10),
                  StatTile(
                    icon: Symbols.signal_cellular_alt,
                    value: spot.difficulty != null
                        ? '${spot.difficulty}/5'
                        : '—',
                    label: l10n.spotDifficulty,
                  ),
                  const SizedBox(width: 10),
                  StatTile(
                    icon: Symbols.wb_sunny,
                    value: spot.bestSeason ?? '—',
                    label: l10n.spotSeason,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.surfaceCard,
                  border: Border.all(color: colors.hairline),
                  borderRadius: BorderRadius.circular(context.spacing.radiusXl),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (spot.openHour != null && spot.closeHour != null) ...[
                      Row(
                        children: [
                          Icon(
                            Symbols.schedule,
                            size: 18,
                            color: colors.colorBrand,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.spotSchedule,
                            style: context.typography.eyebrow,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${spot.openHour} – ${spot.closeHour}',
                        style: context.typography.bodySm,
                      ),
                      Divider(height: 28, color: colors.hairlineSoft),
                    ],
                    Row(
                      children: [
                        Icon(
                          Symbols.description,
                          size: 18,
                          color: colors.colorBrand,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.spotDescription,
                          style: context.typography.eyebrow,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(spot.description, style: context.typography.bodySm),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text(
                l10n.spotElementsTitle(detail.elements.length),
                style: context.typography.tag.copyWith(color: colors.text300),
              ),
              const SizedBox(height: 12),
              if (detail.elements.isEmpty)
                Text(l10n.spotNoElements, style: context.typography.bodySm)
              else
                for (final element in detail.elements)
                  _ElementRow(element: element),
              const SizedBox(height: 22),
              Text(
                l10n.spotHazardsTitle(detail.hazzards.length),
                style: context.typography.tag.copyWith(color: colors.text300),
              ),
              const SizedBox(height: 12),
              if (detail.hazzards.isEmpty)
                Text(l10n.spotNoHazards, style: context.typography.bodySm)
              else
                for (final hazzard in detail.hazzards)
                  _HazzardRow(hazzard: hazzard),
              const SizedBox(height: 14),
              _HazardRatingCard(
                spotHazardAvg: spot.hazardAvg,
                spotHazardCount: spot.hazardCount,
                myCrutches: detail.myHazardRating?.crutches ?? 0,
                busy: busy,
                onRate: onRateHazard,
              ),
              const SizedBox(height: 22),
              Text(
                l10n.spotCommentsTitle(detail.comments.length),
                style: context.typography.tag.copyWith(color: colors.text300),
              ),
              const SizedBox(height: 12),
              if (detail.comments.isEmpty)
                Text(l10n.spotNoComments, style: context.typography.bodySm)
              else
                for (final entry in detail.comments) _CommentRow(entry: entry),
              const SizedBox(height: 12),
              _CommentComposer(spotId: spotId),
              const SizedBox(height: 16),
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

void _openVideo(BuildContext context, String url) {
  Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => VideoPlayerScreen(url: url),
    ),
  );
}

enum _MediaTab { video, photo }

/// Cover gallery: video and photo have **independent** rankings by vote
/// count (the backend already ranks `/photos` and `/videos` this way) —
/// "VIDEO"/"IMAGEN" below switch which one is showing, each with its own
/// #1 big tile + #2-#4 stacked beside it. "MÁS" and "+" (browse-all /
/// upload) aren't built yet. Mirrors the reference sketch
/// (`references/spot.jpeg`).
class _MediaGallery extends ConsumerStatefulWidget {
  const _MediaGallery({
    required this.spotId,
    required this.onBack,
    required this.onComingSoon,
  });

  final int spotId;
  final VoidCallback onBack;
  final VoidCallback onComingSoon;

  @override
  ConsumerState<_MediaGallery> createState() => _MediaGalleryState();
}

class _MediaGalleryState extends ConsumerState<_MediaGallery>
    with AutomaticKeepAliveClientMixin<_MediaGallery> {
  _MediaTab _tab = _MediaTab.video;
  final Set<int> _votingIds = {};
  int? _sportFilter;
  bool _seededSportFilter = false;
  bool _uploading = false;

  // Keeps this widget (and its video/photo tab selection) alive once it
  // scrolls out of the enclosing ListView's viewport + cache extent —
  // without this, Flutter disposes and recreates its State (resetting
  // `_tab` back to the default) the moment it's scrolled far enough away,
  // since it's a plain stateful child of a scrollable, not a page itself.
  @override
  bool get wantKeepAlive => true;

  Future<void> _toggleVote({
    required bool isVideo,
    required int targetId,
    required bool currentlyVoted,
  }) async {
    if (_votingIds.contains(targetId)) return;
    setState(() => _votingIds.add(targetId));
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;

      final voteApi = ref.read(voteApiProvider);
      final targetType = isVideo ? 'video' : 'photo';
      if (currentlyVoted) {
        await voteApi.unvote(
          targetType: targetType,
          targetId: targetId,
          idToken: idToken,
        );
      } else {
        await voteApi.vote(
          targetType: targetType,
          targetId: targetId,
          idToken: idToken,
        );
      }
    } catch (_) {
      // e.g. already voted/unvoted from a prior tap — reconcile via refetch
      // below rather than surfacing an error for something already in sync.
    } finally {
      if (isVideo) {
        ref.invalidate(spotVideosProvider(widget.spotId, _sportFilter));
        ref.invalidate(spotVideoVotesProvider(widget.spotId, _sportFilter));
      } else {
        ref.invalidate(spotPhotosProvider(widget.spotId, _sportFilter));
        ref.invalidate(spotPhotoVotesProvider(widget.spotId, _sportFilter));
      }
      if (mounted) setState(() => _votingIds.remove(targetId));
    }
  }

  Future<ImageSource?> _pickImageSource() {
    final l10n = AppLocalizations.of(context);
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: context.colors.surfaceCard,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Symbols.photo_camera),
              title: Text(l10n.createSpotUseCamera),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Symbols.photo_library),
              title: Text(l10n.createSpotUseGallery),
              onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }

  /// Only shown when the spot has 2+ sports — a single-sport spot resolves
  /// this automatically server-side, no need to ask.
  Future<int?> _pickMediaSport(List<Sport> sports) {
    final colors = context.colors;
    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: colors.surfaceCard,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                AppLocalizations.of(context).spotMediaSportPickerTitle,
                style: context.typography.title,
              ),
            ),
            for (final sport in sports)
              ListTile(
                leading: Icon(
                  SportVisual.of(sport.name, colors).icon,
                  color: SportVisual.of(sport.name, colors).color,
                ),
                title: Text(sport.name),
                onTap: () => Navigator.of(sheetContext).pop(sport.id),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _addMedia(List<Sport> sports) async {
    if (_uploading) return;
    final isVideo = _tab == _MediaTab.video;

    int? sportId;
    if (sports.length > 1) {
      sportId = await _pickMediaSport(sports);
      if (sportId == null) return;
    } else if (sports.length == 1) {
      sportId = sports.first.id;
    }
    if (!mounted) return;

    final source = await _pickImageSource();
    if (source == null) return;

    final picker = ImagePicker();
    final file = isVideo
        ? await picker.pickVideo(
            source: source,
            maxDuration: const Duration(minutes: 2),
          )
        : await picker.pickImage(
            source: source,
            maxWidth: 1600,
            imageQuality: 85,
          );
    if (file == null) return;

    setState(() => _uploading = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;

      final url = await ref
          .read(storageApiProvider)
          .uploadFile(
            path:
                'spots/${widget.spotId}/${isVideo ? 'videos' : 'photos'}/'
                '${DateTime.now().millisecondsSinceEpoch}_${file.name}',
            file: File(file.path),
          );

      if (isVideo) {
        await ref
            .read(spotVideoApiProvider)
            .create(
              spotId: widget.spotId,
              url: url,
              sportId: sportId,
              idToken: idToken,
            );
        ref.invalidate(spotVideosProvider(widget.spotId, _sportFilter));
      } else {
        await ref
            .read(spotPhotoApiProvider)
            .create(
              spotId: widget.spotId,
              url: url,
              sportId: sportId,
              idToken: idToken,
            );
        ref.invalidate(spotPhotosProvider(widget.spotId, _sportFilter));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
    final sports =
        ref.watch(spotSportsProvider(widget.spotId)).value ?? const <Sport>[];

    // Seeds the sport filter once the spot's sports AND the rider's active
    // sport have both resolved — waiting on `hasValue` (not just checking
    // for null) avoids locking in the wrong default while it's still
    // loading. Only relevant for 2+ sport spots; otherwise every photo/
    // video already carries the spot's one sport, so no filter is needed.
    final activeSportIdAsync = ref.watch(effectiveActiveSportIdProvider);
    if (!_seededSportFilter &&
        sports.length > 1 &&
        activeSportIdAsync.hasValue) {
      final activeSportId = activeSportIdAsync.value;
      _sportFilter = sports.any((s) => s.id == activeSportId)
          ? activeSportId
          : sports.first.id;
      _seededSportFilter = true;
    }

    final photos =
        ref.watch(spotPhotosProvider(widget.spotId, _sportFilter)).value ??
        const [];
    final videos =
        ref.watch(spotVideosProvider(widget.spotId, _sportFilter)).value ??
        const [];
    final isVideo = _tab == _MediaTab.video;
    final votes = isVideo
        ? ref
                  .watch(spotVideoVotesProvider(widget.spotId, _sportFilter))
                  .value ??
              const {}
        : ref
                  .watch(spotPhotoVotesProvider(widget.spotId, _sportFilter))
                  .value ??
              const {};
    final items = isVideo
        ? [
            for (final v in videos)
              (id: v.id, url: v.url, voteCount: v.voteCount),
          ]
        : [
            for (final p in photos)
              (id: p.id, url: p.url, voteCount: p.voteCount),
          ];
    final urls = [for (final item in items) item.url];
    final badgeLabel = isVideo ? 'VIDEO' : 'FOTO';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 250,
              child: urls.isEmpty
                  ? Container(
                      color: colors.surfaceMedia,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isVideo
                                ? Symbols.videocam_off
                                : Symbols.photo_camera,
                            size: 40,
                            color: colors.text700,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isVideo ? l10n.spotNoVideos : l10n.spotNoMedia,
                            style: context.typography.meta,
                          ),
                        ],
                      ),
                    )
                  : Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: MediaTile(
                            url: items[0].url,
                            isVideo: isVideo,
                            badge: '$badgeLabel · #1',
                            big: true,
                            onTap: isVideo
                                ? () => _openVideo(context, items[0].url)
                                : null,
                            voteCount: items[0].voteCount,
                            voted: votes[items[0].id] ?? false,
                            busy: _votingIds.contains(items[0].id),
                            onToggleVote: () => _toggleVote(
                              isVideo: isVideo,
                              targetId: items[0].id,
                              currentlyVoted: votes[items[0].id] ?? false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              for (var i = 1; i <= 3; i++)
                                if (items.length > i) ...[
                                  if (i > 1) const SizedBox(height: 6),
                                  Expanded(
                                    child: MediaTile(
                                      url: items[i].url,
                                      isVideo: isVideo,
                                      badge: '$badgeLabel · #${i + 1}',
                                      big: false,
                                      onTap: isVideo
                                          ? () => _openVideo(
                                              context,
                                              items[i].url,
                                            )
                                          : null,
                                      voteCount: items[i].voteCount,
                                      voted: votes[items[i].id] ?? false,
                                      busy: _votingIds.contains(items[i].id),
                                      onToggleVote: () => _toggleVote(
                                        isVideo: isVideo,
                                        targetId: items[i].id,
                                        currentlyVoted:
                                            votes[items[i].id] ?? false,
                                      ),
                                    ),
                                  ),
                                ],
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: AppIconButton(
                icon: Symbols.arrow_back,
                chrome: true,
                onPressed: widget.onBack,
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Row(
                children: [
                  AppIconButton(
                    icon: Symbols.bookmark,
                    chrome: true,
                    onPressed: widget.onComingSoon,
                  ),
                  const SizedBox(width: 8),
                  AppIconButton(
                    icon: Symbols.ios_share,
                    chrome: true,
                    onPressed: widget.onComingSoon,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (sports.length > 1)
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: SizedBox(
              height: 32,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: sports.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final sport = sports[index];
                  final visual = SportVisual.of(sport.name, colors);
                  final selected = _sportFilter == sport.id;
                  return GestureDetector(
                    onTap: () => setState(() => _sportFilter = sport.id),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: selected ? colors.tintBlue : colors.surfaceCard,
                        border: Border.all(
                          color: selected ? visual.color : colors.hairline,
                        ),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            visual.icon,
                            size: 15,
                            color: selected ? visual.color : colors.text300,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            sport.name.toUpperCase(),
                            style: context.typography.tag.copyWith(
                              color: selected ? visual.color : colors.text300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
          child: Row(
            children: [
              Expanded(
                child: _MediaFilterButton(
                  label: l10n.spotMediaVideoTab,
                  active: _tab == _MediaTab.video,
                  onTap: () => setState(() => _tab = _MediaTab.video),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _MediaFilterButton(
                  label: l10n.spotMediaPhotoTab,
                  active: _tab == _MediaTab.photo,
                  onTap: () => setState(() => _tab = _MediaTab.photo),
                ),
              ),
              const SizedBox(width: 8),
              _MediaFilterButton(
                label: l10n.spotMediaMore,
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (_) => SpotMediaLibraryScreen(
                      spotId: widget.spotId,
                      initialIsVideo: isVideo,
                      sportId: _sportFilter,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              AppIconButton(
                icon: Symbols.add,
                onPressed: _uploading ? null : () => _addMedia(sports),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MediaFilterButton extends StatelessWidget {
  const _MediaFilterButton({
    required this.label,
    this.active = false,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? colors.colorAction : colors.surfaceCard,
          border: Border.all(
            color: active ? colors.colorAction : colors.hairline,
          ),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        ),
        child: Text(
          label,
          style: context.typography.tag.copyWith(
            color: active ? colors.colorOnAction : colors.text300,
          ),
        ),
      ),
    );
  }
}

class MediaTile extends StatelessWidget {
  const MediaTile({
    super.key,
    required this.url,
    required this.isVideo,
    required this.badge,
    required this.big,
    this.onTap,
    this.voteCount,
    this.voted = false,
    this.busy = false,
    this.onToggleVote,
  });

  final String url;
  final bool isVideo;
  final String badge;
  final bool big;
  final VoidCallback? onTap;
  final int? voteCount;
  final bool voted;
  final bool busy;
  final VoidCallback? onToggleVote;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(big ? 0 : 10),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (isVideo)
              Container(
                color: colors.surfaceMedia,
                alignment: Alignment.center,
                child: Icon(
                  Symbols.play_circle,
                  fill: 1,
                  size: big ? 52 : 22,
                  color: colors.colorAction,
                ),
              )
            else
              Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colors.surfaceMedia,
                  alignment: Alignment.center,
                  child: Icon(Symbols.broken_image, color: colors.text700),
                ),
              ),
            Positioned(
              left: 6,
              bottom: 6,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: big ? 9 : 5,
                  vertical: big ? 4 : 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .7),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  badge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.tag.copyWith(
                    fontSize: big ? 11 : 9,
                  ),
                ),
              ),
            ),
            if (onToggleVote != null)
              Positioned(
                right: 6,
                bottom: 6,
                child: GestureDetector(
                  onTap: busy ? null : onToggleVote,
                  behavior: HitTestBehavior.opaque,
                  child: Opacity(
                    opacity: busy ? .5 : 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: big ? 8 : 5,
                        vertical: big ? 4 : 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: .7),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Symbols.favorite,
                            fill: voted ? 1 : 0,
                            size: big ? 15 : 11,
                            color: colors.colorAction,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${voteCount ?? 0}',
                            style: context.typography.tag.copyWith(
                              fontSize: big ? 11 : 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SportChip extends StatelessWidget {
  const _SportChip({required this.id, required this.name});

  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visual = SportVisual.of(name, colors);

    return GestureDetector(
      onTap: () => context.push('/sports/$id'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
          color: visual.color.withValues(alpha: .14),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(visual.icon, size: 14, color: visual.color),
            const SizedBox(width: 5),
            Text(
              name.toUpperCase(),
              style: context.typography.tag.copyWith(color: visual.color),
            ),
          ],
        ),
      ),
    );
  }
}

/// Big rating summary: average, a 5-star row reflecting that average (half
/// stars included), the vote count, and a compact control to submit/update
/// the signed-in rider's own rating.
class _RatingCard extends StatelessWidget {
  const _RatingCard({
    required this.spotRatingAvg,
    required this.spotRatingCount,
    required this.myStars,
    required this.busy,
    required this.onRate,
  });

  final double? spotRatingAvg;
  final int spotRatingCount;
  final int myStars;
  final bool busy;
  final void Function(int stars) onRate;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
    final avg = spotRatingAvg ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairline),
        borderRadius: BorderRadius.circular(context.spacing.radiusXl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            spotRatingAvg?.toStringAsFixed(1) ?? '—',
            style: context.typography.displaySm.copyWith(height: .9),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (var i = 1; i <= 5; i++)
                      Icon(
                        avg >= i - 0.5 && avg < i
                            ? Symbols.star_half
                            : Symbols.star,
                        fill: avg >= i - 0.5 ? 1 : 0,
                        size: 20,
                        color: avg >= i - 0.5
                            ? colors.colorAction
                            : colors.hairlineStrong,
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  l10n.spotRatingsCount(spotRatingCount),
                  style: context.typography.meta,
                ),
              ],
            ),
          ),
          Opacity(
            opacity: busy ? .5 : 1,
            child: Column(
              children: [
                Text(l10n.spotVote, style: context.typography.tag),
                const SizedBox(height: 2),
                Row(
                  children: [
                    for (var star = 1; star <= 5; star++)
                      GestureDetector(
                        onTap: busy ? null : () => onRate(star),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Symbols.star,
                            fill: star <= myStars ? 1 : 0,
                            size: 18,
                            color: colors.colorAction,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Community hazard ("muletas") rating: average, a 5-crutch row reflecting
/// that average, the rating count, and a compact control to submit/update
/// the signed-in rider's own hazard rating. Distinct from the individual
/// named [Hazzard] reports listed further down the screen.
class _HazardRatingCard extends StatelessWidget {
  const _HazardRatingCard({
    required this.spotHazardAvg,
    required this.spotHazardCount,
    required this.myCrutches,
    required this.busy,
    required this.onRate,
  });

  final double? spotHazardAvg;
  final int spotHazardCount;
  final int myCrutches;
  final bool busy;
  final void Function(int crutches) onRate;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);
    final avg = spotHazardAvg ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairline),
        borderRadius: BorderRadius.circular(context.spacing.radiusXl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            spotHazardAvg?.toStringAsFixed(1) ?? '—',
            style: context.typography.displaySm.copyWith(height: .9),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (var i = 1; i <= 5; i++)
                      Icon(
                        Symbols.personal_injury,
                        fill: avg >= i ? 1 : 0,
                        size: 20,
                        color: avg >= i
                            ? colors.colorWarn
                            : colors.hairlineStrong,
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  l10n.spotHazardRatingsCount(spotHazardCount),
                  style: context.typography.meta,
                ),
              ],
            ),
          ),
          Opacity(
            opacity: busy ? .5 : 1,
            child: Column(
              children: [
                Text(l10n.spotVote, style: context.typography.tag),
                const SizedBox(height: 2),
                Row(
                  children: [
                    for (var crutch = 1; crutch <= 5; crutch++)
                      GestureDetector(
                        onTap: busy ? null : () => onRate(crutch),
                        behavior: HitTestBehavior.opaque,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Icon(
                            Symbols.personal_injury,
                            fill: crutch <= myCrutches ? 1 : 0,
                            size: 18,
                            color: colors.colorWarn,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ElementRow extends StatelessWidget {
  const _ElementRow({required this.element});

  final SpotElement element;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final difficulty = element.difficulty ?? 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairline),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.tintInfo,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Icon(
                elementIcon(element.type),
                size: 20,
                color: colors.colorBrand,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    element.name,
                    style: context.typography.title.copyWith(height: 1),
                  ),
                  if (element.type != null) ...[
                    const SizedBox(height: 4),
                    Text(element.type!, style: context.typography.micro),
                  ],
                ],
              ),
            ),
            Row(
              children: [
                for (var i = 1; i <= 5; i++)
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(left: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i <= difficulty
                          ? colors.colorBrand
                          : colors.hairlineStrong,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HazzardRow extends StatelessWidget {
  const _HazzardRow({required this.hazzard});

  final Hazzard hazzard;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final severity = hazzard.severity ?? 1;
    final (Color color, Color background, Color border) = severity <= 2
        ? (
            colors.colorRating,
            colors.tintRating,
            colors.colorRating.withValues(alpha: .28),
          )
        : severity == 3
        ? (
            colors.colorWarn,
            colors.tintWarn,
            colors.colorWarn.withValues(alpha: .28),
          )
        : (
            colors.colorDanger,
            colors.tintDanger,
            colors.colorDanger.withValues(alpha: .28),
          );

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: background,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Symbols.warning, size: 22, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hazzard.name,
                    style: context.typography.title.copyWith(height: 1),
                  ),
                  if (hazzard.description != null) ...[
                    const SizedBox(height: 4),
                    Text(hazzard.description!, style: context.typography.micro),
                  ],
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .25),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                'SEV $severity',
                style: context.typography.tag.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentRow extends StatelessWidget {
  const _CommentRow({required this.entry});

  final SpotCommentWithAuthor entry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final author = entry.author;
    final comment = entry.comment;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppAvatar(
            initial: author.nickname.isNotEmpty
                ? author.nickname[0].toUpperCase()
                : '?',
            imageUrl: author.iconImage,
            size: AppAvatarSize.sm,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      author.nickname,
                      style: context.typography.title.copyWith(fontSize: 14),
                    ),
                    const SizedBox(width: 7),
                    Text(
                      DateFormat.yMMMd(
                        Localizations.localeOf(context).toString(),
                      ).format(comment.createdDate),
                      style: context.typography.micro,
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(comment.body, style: context.typography.bodySm),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Symbols.favorite, size: 15, color: colors.textMuted),
                    const SizedBox(width: 5),
                    Text(
                      '${comment.voteCount}',
                      style: context.typography.meta,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentComposer extends ConsumerStatefulWidget {
  const _CommentComposer({required this.spotId});

  final int spotId;

  @override
  ConsumerState<_CommentComposer> createState() => _CommentComposerState();
}

class _CommentComposerState extends ConsumerState<_CommentComposer> {
  final _controller = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final body = _controller.text.trim();
    if (body.isEmpty || _sending) return;

    final user = ref.read(firebaseAuthProvider).currentUser;
    final idToken = await user?.getIdToken();
    if (idToken == null) return;

    setState(() => _sending = true);
    try {
      await ref
          .read(spotCommentApiProvider)
          .create(spotId: widget.spotId, body: body, idToken: idToken);
      _controller.clear();
      ref.invalidate(spotDetailProvider(widget.spotId));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairlineStrong),
        borderRadius: BorderRadius.circular(context.spacing.radiusMd),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: context.typography.bodySm,
              decoration: InputDecoration(
                hintText: l10n.spotCommentPlaceholder,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: _sending ? null : _send,
            icon: Icon(Symbols.send, color: colors.colorAction),
          ),
        ],
      ),
    );
  }
}
