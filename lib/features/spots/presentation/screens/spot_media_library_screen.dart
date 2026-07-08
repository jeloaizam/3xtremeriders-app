import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_icon_button.dart';
import '../../../../l10n/gen/app_localizations.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/spots_providers.dart';
import '../../data/vote_api.dart';
import '../widgets/photo_viewer_screen.dart';
import '../widgets/video_player_screen.dart';
import 'spot_screen.dart' show MediaTile;

/// Browses **all** of a spot's photos or videos (not just the top-4 cover
/// preview shown on [SpotScreen]'s media gallery), each ranked by vote count
/// and votable in place — opened from the gallery's "MÁS" button.
class SpotMediaLibraryScreen extends ConsumerStatefulWidget {
  const SpotMediaLibraryScreen({
    super.key,
    required this.spotId,
    required this.initialIsVideo,
  });

  final int spotId;
  final bool initialIsVideo;

  @override
  ConsumerState<SpotMediaLibraryScreen> createState() =>
      _SpotMediaLibraryScreenState();
}

class _SpotMediaLibraryScreenState
    extends ConsumerState<SpotMediaLibraryScreen> {
  late bool _isVideo = widget.initialIsVideo;
  final Set<int> _votingIds = {};

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
        ref.invalidate(spotVideosProvider(widget.spotId));
        ref.invalidate(spotVideoVotesProvider(widget.spotId));
      } else {
        ref.invalidate(spotPhotosProvider(widget.spotId));
        ref.invalidate(spotPhotoVotesProvider(widget.spotId));
      }
      if (mounted) setState(() => _votingIds.remove(targetId));
    }
  }

  void _openItem(String url) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _isVideo
            ? VideoPlayerScreen(url: url)
            : PhotoViewerScreen(url: url),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final photos =
        ref.watch(spotPhotosProvider(widget.spotId)).value ?? const [];
    final videos =
        ref.watch(spotVideosProvider(widget.spotId)).value ?? const [];
    final votes = _isVideo
        ? ref.watch(spotVideoVotesProvider(widget.spotId)).value ?? const {}
        : ref.watch(spotPhotoVotesProvider(widget.spotId)).value ?? const {};
    final items = _isVideo
        ? [
            for (final v in videos)
              (id: v.id, url: v.url, voteCount: v.voteCount),
          ]
        : [
            for (final p in photos)
              (id: p.id, url: p.url, voteCount: p.voteCount),
          ];

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
                          badge: '#${index + 1}',
                          big: false,
                          onTap: () => _openItem(item.url),
                          voteCount: item.voteCount,
                          voted: votes[item.id] ?? false,
                          busy: _votingIds.contains(item.id),
                          onToggleVote: () => _toggleVote(
                            targetId: item.id,
                            currentlyVoted: votes[item.id] ?? false,
                          ),
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
