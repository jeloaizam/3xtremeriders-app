import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/spot_media_providers.dart';
import '../../data/spot_media_ranking_api.dart';
import '../../data/vote_api.dart';
import '../widgets/spot_detail/media_tile.dart';

/// Browses **all** of a spot's photos or videos (not just the top-3 hero
/// preview shown on [SpotScreen]'s `RankTvBox`), ranked by vote count —
/// opened from the hero's "Ver más" link. Votable in place only for the
/// general (ungendered) library, where that's always worked; a gender
/// bucket opens straight into the full viewer to vote, same as the hero.
class SpotMediaLibraryScreen extends ConsumerStatefulWidget {
  const SpotMediaLibraryScreen({
    super.key,
    required this.spotId,
    required this.initialIsVideo,
    this.sportId,
    this.gender,
  });

  final int spotId;
  final bool initialIsVideo;

  /// Whichever sport's ranking was showing when "Ver más" was tapped — null
  /// means "every sport" (single-sport/untagged spots, or a gender bucket,
  /// which isn't sport-scoped — see `GET /spots/{id}/media-ranking`).
  final int? sportId;

  /// 'male' | 'female' | 'alien' — when set, browses that gender's ranking
  /// bucket instead of the general sport-filtered library, and [sportId]
  /// is ignored.
  final String? gender;

  @override
  ConsumerState<SpotMediaLibraryScreen> createState() =>
      _SpotMediaLibraryScreenState();
}

class _SpotMediaLibraryScreenState
    extends ConsumerState<SpotMediaLibraryScreen> {
  late bool _isVideo = widget.initialIsVideo;
  final Set<int> _votingIds = {};

  bool get _isGeneral => widget.gender == null;

  Future<void> _toggleVote({
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
      final targetType = _isVideo ? 'video' : 'photo';
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
      if (_isVideo) {
        ref.invalidate(spotVideosProvider(widget.spotId, widget.sportId));
        ref.invalidate(spotVideoVotesProvider(widget.spotId, widget.sportId));
      } else {
        ref.invalidate(spotPhotosProvider(widget.spotId, widget.sportId));
        ref.invalidate(spotPhotoVotesProvider(widget.spotId, widget.sportId));
      }
      if (mounted) setState(() => _votingIds.remove(targetId));
    }
  }

  List<MediaItem> _generalItems() {
    final photos =
        ref.watch(spotPhotosProvider(widget.spotId, widget.sportId)).value ??
        const [];
    final videos =
        ref.watch(spotVideosProvider(widget.spotId, widget.sportId)).value ??
        const [];
    return _isVideo
        ? [
            for (final v in videos)
              (
                id: v.id,
                url: v.url,
                voteCount: v.voteCount,
                thumbnailUrl: v.thumbnailUrl,
                caption: v.caption,
                uploadedBy: v.uploadedBy,
                uploaderNickname: v.uploaderNickname,
                uploaderIconImage: v.uploaderIconImage,
              ),
          ]
        : [
            for (final p in photos)
              (
                id: p.id,
                url: p.url,
                voteCount: p.voteCount,
                thumbnailUrl: null,
                caption: p.caption,
                uploadedBy: p.uploadedBy,
                uploaderNickname: p.uploaderNickname,
                uploaderIconImage: p.uploaderIconImage,
              ),
          ];
  }

  List<MediaItem> _genderItems() {
    final ranking = ref.watch(spotMediaRankingProvider(widget.spotId)).value;
    if (ranking == null) return const [];
    final bucket = switch (widget.gender) {
      'male' => ranking.male,
      'female' => ranking.female,
      _ => ranking.alien,
    };
    final source = _isVideo ? bucket.videos : bucket.photos;
    return [
      for (final item in source)
        (
          id: item.id,
          url: item.url,
          voteCount: item.voteCount,
          thumbnailUrl: item.thumbnailUrl,
          caption: item.caption,
          uploadedBy: item.uploadedBy,
          uploaderNickname: item.uploaderNickname,
          uploaderIconImage: item.uploaderIconImage,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = _isGeneral ? _generalItems() : _genderItems();
    final votes = _isGeneral
        ? (_isVideo
              ? ref
                        .watch(
                          spotVideoVotesProvider(
                            widget.spotId,
                            widget.sportId,
                          ),
                        )
                        .value ??
                    const {}
              : ref
                        .watch(
                          spotPhotoVotesProvider(
                            widget.spotId,
                            widget.sportId,
                          ),
                        )
                        .value ??
                    const {})
        : const <int, bool>{};

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 6, 18, 12),
              child: Row(
                children: [
                  AppIconButton(
                    icon: Symbols.arrow_back,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l10n.spotMediaLibraryTitle,
                      style: context.typography.displaySm,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      label: l10n.spotMediaVideoTab,
                      active: _isVideo,
                      onTap: () => setState(() => _isVideo = true),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _TabButton(
                      label: l10n.spotMediaPhotoTab,
                      active: !_isVideo,
                      onTap: () => setState(() => _isVideo = false),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Text(
                        _isVideo ? l10n.spotNoVideos : l10n.spotNoMedia,
                        style: context.typography.meta,
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1,
                          ),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return MediaTile(
                          url: item.url,
                          isVideo: _isVideo,
                          thumbnailUrl: item.thumbnailUrl,
                          badge: '#${index + 1}',
                          big: false,
                          onTap: () => openMedia(
                            context,
                            spotId: widget.spotId,
                            item: item,
                            isVideo: _isVideo,
                          ),
                          voteCount: _isGeneral ? item.voteCount : null,
                          voted: votes[item.id] ?? false,
                          busy: _votingIds.contains(item.id),
                          onToggleVote: _isGeneral
                              ? () => _toggleVote(
                                  targetId: item.id,
                                  currentlyVoted: votes[item.id] ?? false,
                                )
                              : null,
                          voterNickname: _isGeneral
                              ? null
                              : item.uploaderNickname,
                          voterIconImage: _isGeneral
                              ? null
                              : item.uploaderIconImage,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.active,
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
