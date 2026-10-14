import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_theme.dart';
import '../photo_viewer_screen.dart';
import '../video_player_screen.dart';

/// Common shape for a photo or video tile, whatever its source (the
/// general sport-filtered library, or a gender-ranking bucket) — the
/// uploader fields are always populated (see `SpotPhoto`/`SpotVideo`/
/// `RankedMediaItem`, all of which carry them) so any tile can show the
/// "who uploaded this" badge without a second lookup.
typedef MediaItem = ({
  int id,
  String url,
  int voteCount,
  String? thumbnailUrl,
  String? caption,
  int uploadedBy,
  String uploaderNickname,
  String? uploaderIconImage,
});

void openMedia(
  BuildContext context, {
  required int spotId,
  required MediaItem item,
  required bool isVideo,
}) {
  Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => isVideo
          ? VideoPlayerScreen(
              url: item.url,
              videoId: item.id,
              spotId: spotId,
              initialVoteCount: item.voteCount,
            )
          : PhotoViewerScreen(
              url: item.url,
              photoId: item.id,
              spotId: spotId,
              initialVoteCount: item.voteCount,
            ),
    ),
  );
}

/// One photo/video tile — big (hero #1) or small (hero #2/#3, library grid).
/// Two independent, mutually-exclusive bottom-right slots: the vote corner
/// (library grid, where voting inline still makes sense) or the voter
/// badge (hero, where voting happens by opening the full viewer instead —
/// see `rank_tv_box.dart`). `rankLabel` is the hero's top-left "#1" pill;
/// `badge` is the library grid's existing bottom-left text badge.
class MediaTile extends StatelessWidget {
  const MediaTile({
    super.key,
    required this.url,
    required this.isVideo,
    required this.big,
    this.thumbnailUrl,
    this.badge,
    this.rankLabel,
    this.caption,
    this.onTap,
    this.voteCount,
    this.voted = false,
    this.busy = false,
    this.onToggleVote,
    this.voterNickname,
    this.voterIconImage,
    this.onTapVoter,
  });

  final String url;
  final bool isVideo;
  final bool big;

  /// A static JPEG grabbed from the video's first frame at upload time —
  /// null for externally-linked videos (no local file to grab a frame
  /// from) or ones uploaded before this existed, which fall back to a
  /// flat placeholder with just the play icon.
  final String? thumbnailUrl;

  /// Bottom-left text badge (e.g. "#1" in the library grid). Optional —
  /// the hero tiles don't use this slot, they use [rankLabel] instead.
  final String? badge;

  /// Top-left rank pill (e.g. "#1"/"#2"/"#3") — hero tiles only.
  final String? rankLabel;

  /// Shown bottom-left on the big hero tile only, when present.
  final String? caption;

  final VoidCallback? onTap;

  // Bottom-right vote corner — library grid only.
  final int? voteCount;
  final bool voted;
  final bool busy;
  final VoidCallback? onToggleVote;

  // Bottom-right voter badge — hero tiles only.
  final String? voterNickname;
  final String? voterIconImage;
  final VoidCallback? onTapVoter;

  Widget _placeholder(AppColors colors) => Container(
    color: colors.surfaceMedia,
    alignment: Alignment.center,
    child: Icon(
      Symbols.play_circle,
      fill: 1,
      size: big ? 52 : 22,
      color: colors.colorAction,
    ),
  );

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
              thumbnailUrl == null
                  ? _placeholder(colors)
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          thumbnailUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _placeholder(colors),
                        ),
                        Center(
                          child: Icon(
                            Symbols.play_circle,
                            fill: 1,
                            size: big ? 52 : 22,
                            color: colors.colorAction,
                          ),
                        ),
                      ],
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
            if (rankLabel != null)
              Positioned(
                top: big ? 10 : 7,
                left: big ? 10 : 7,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: big ? 9 : 7,
                    vertical: big ? 3 : 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .65),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    rankLabel!,
                    style: context.typography.tag.copyWith(
                      color: colors.colorAction,
                      fontSize: big ? 11 : 10,
                    ),
                  ),
                ),
              ),
            if (badge != null)
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
                    badge!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.typography.tag.copyWith(
                      fontSize: big ? 11 : 9,
                    ),
                  ),
                ),
              ),
            if (caption != null && caption!.isNotEmpty)
              Positioned(
                left: 10,
                bottom: 10,
                right: 40,
                child: Text(
                  caption!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.typography.bodySm.copyWith(
                    color: colors.text100,
                    fontWeight: FontWeight.w500,
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
              )
            else if (voterNickname != null)
              Positioned(
                right: big ? 8 : 6,
                bottom: big ? 8 : 6,
                child: GestureDetector(
                  onTap: onTapVoter,
                  behavior: HitTestBehavior.opaque,
                  child: Semantics(
                    button: true,
                    label: voterNickname,
                    child: Container(
                      width: big ? 26 : 20,
                      height: big ? 26 : 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.surfaceCard,
                        border: Border.all(color: colors.surfaceApp, width: 1.5),
                        image: voterIconImage != null
                            ? DecorationImage(
                                image: NetworkImage(voterIconImage!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: voterIconImage == null
                          ? Text(
                              voterNickname!.isNotEmpty
                                  ? voterNickname![0].toUpperCase()
                                  : '?',
                              style: context.typography.tag.copyWith(
                                color: colors.text100,
                                fontSize: big ? 10 : 8,
                              ),
                            )
                          : null,
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
