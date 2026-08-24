import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../auth/application/auth_providers.dart';
import '../../application/spots_providers.dart';
import '../../data/spot_media_ranking_api.dart';
import '../../data/vote_api.dart';
import 'comment_section.dart';

/// Full-screen playback for a spot's uploaded/linked video, opened by
/// tapping a video tile — shared with a Ride's own videos and a Sport's
/// top media, same as [PhotoViewerScreen]. [videoId]/[spotId] are
/// optional for the same reason (a Ride's `RiderVideo` isn't a spot
/// `Video` row) — likes + a comment thread only render when both are set.
class VideoPlayerScreen extends ConsumerStatefulWidget {
  const VideoPlayerScreen({
    super.key,
    required this.url,
    this.videoId,
    this.spotId,
    this.initialVoteCount,
  });

  final String url;
  final int? videoId;
  final int? spotId;
  final int? initialVoteCount;

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen> {
  late final VideoPlayerController _videoController;
  ChewieController? _chewieController;
  String? _error;

  late int _voteCount = widget.initialVoteCount ?? 0;
  bool _voted = false;
  bool _busy = false;

  bool get _hasEngagement => widget.videoId != null && widget.spotId != null;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(Uri.parse(widget.url));
    _videoController
        .initialize()
        .then((_) {
          if (!mounted) return;
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoController,
              autoPlay: true,
              looping: false,
            );
          });
        })
        .catchError((_) {
          if (mounted) setState(() => _error = 'error');
        });
    if (_hasEngagement) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkInitialVote());
    }
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  Future<void> _checkInitialVote() async {
    final videoId = widget.videoId;
    if (videoId == null) return;
    final idToken = await ref
        .read(firebaseAuthProvider)
        .currentUser
        ?.getIdToken();
    if (idToken == null) return;
    final voted = await ref
        .read(voteApiProvider)
        .check(targetType: 'video', targetId: videoId, idToken: idToken)
        .catchError((_) => false);
    if (mounted) setState(() => _voted = voted);
  }

  Future<void> _toggleVote() async {
    final videoId = widget.videoId;
    final spotId = widget.spotId;
    if (videoId == null || spotId == null || _busy) return;
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
          targetType: 'video',
          targetId: videoId,
          idToken: idToken,
        );
      } else {
        await voteApi.unvote(
          targetType: 'video',
          targetId: videoId,
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
    final player = _error != null
        ? const Icon(Icons.broken_image, color: Colors.white54, size: 48)
        : _chewieController != null
        ? Chewie(controller: _chewieController!)
        : const CircularProgressIndicator(color: Colors.white);

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
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Center(child: player),
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
                    targetType: 'video',
                    targetId: widget.videoId!,
                  ),
                ],
              )
            : Center(child: player),
      ),
    );
  }
}
