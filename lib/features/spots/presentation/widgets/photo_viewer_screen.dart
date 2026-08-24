import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/spots_providers.dart';
import '../../data/spot_media_ranking_api.dart';
import '../../data/vote_api.dart';
import 'comment_section.dart';

/// Full-screen view of a single photo, opened from the media gallery, the
/// media library grid, a Sport's top media, or a Ride's own gallery.
///
/// [photoId]/[spotId] are optional because this widget is shared with
/// contexts that aren't a spot's own `Photo` row (a Ride's `RiderPhoto`,
/// for instance, lives in a different table with its own id space) — likes
/// and a comment thread only render when both are provided, since those
/// features are keyed off a real spot-Photo id via the backend's
/// polymorphic `/votes` and `/comments` endpoints.
class PhotoViewerScreen extends ConsumerStatefulWidget {
  const PhotoViewerScreen({
    super.key,
    required this.url,
    this.photoId,
    this.spotId,
    this.initialVoteCount,
  });

  final String url;
  final int? photoId;
  final int? spotId;
  final int? initialVoteCount;

  @override
  ConsumerState<PhotoViewerScreen> createState() => _PhotoViewerScreenState();
}

class _PhotoViewerScreenState extends ConsumerState<PhotoViewerScreen> {
  late int _voteCount = widget.initialVoteCount ?? 0;
  bool _voted = false;
  bool _busy = false;
  bool _checkedInitialVote = false;

  bool get _hasEngagement => widget.photoId != null && widget.spotId != null;

  Future<void> _checkInitialVote() async {
    final photoId = widget.photoId;
    if (photoId == null) return;
    final idToken = await ref
        .read(firebaseAuthProvider)
        .currentUser
        ?.getIdToken();
    if (idToken == null) return;
    final voted = await ref
        .read(voteApiProvider)
        .check(targetType: 'photo', targetId: photoId, idToken: idToken)
        .catchError((_) => false);
    if (mounted) setState(() => _voted = voted);
  }

  Future<void> _toggleVote() async {
    final photoId = widget.photoId;
    final spotId = widget.spotId;
    if (photoId == null || spotId == null || _busy) return;
    final idToken = await ref
        .read(firebaseAuthProvider)
        .currentUser
        ?.getIdToken();
    if (idToken == null) return;

    setState(() {
      _busy = true;
      _voted = !_voted;
      _voteCount += _voted ? 1 : -1;
    });
    try {
      final voteApi = ref.read(voteApiProvider);
      if (_voted) {
        await voteApi.vote(
          targetType: 'photo',
          targetId: photoId,
          idToken: idToken,
        );
      } else {
        await voteApi.unvote(
          targetType: 'photo',
          targetId: photoId,
          idToken: idToken,
        );
      }
      ref.invalidate(spotDetailProvider(spotId));
      ref.invalidate(spotMediaRankingProvider(spotId));
    } catch (_) {
      if (mounted) {
        setState(() {
          _voted = !_voted;
          _voteCount += _voted ? 1 : -1;
        });
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasEngagement && !_checkedInitialVote) {
      _checkedInitialVote = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkInitialVote());
    }

    final image = Image.network(
      widget.url,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Symbols.broken_image, color: Colors.white54, size: 48),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: _hasEngagement
            ? ListView(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox(
                      height: 340,
                      child: InteractiveViewer(maxScale: 4, child: image),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _toggleVote,
                    child: Row(
                      children: [
                        Icon(
                          Symbols.favorite,
                          fill: _voted ? 1 : 0,
                          color: context.colors.colorAction,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '$_voteCount',
                          style: context.typography.title.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CommentSection(
                    targetType: 'photo',
                    targetId: widget.photoId!,
                  ),
                ],
              )
            : Center(child: InteractiveViewer(maxScale: 4, child: image)),
      ),
    );
  }
}
