import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/storage/media_size_guard.dart';
import '../../../../../core/storage/storage_api.dart';
import '../../../../../core/storage/video_thumbnail_helper.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/app_icon_button.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../../../auth/application/auth_providers.dart';
import '../../../../moderation/presentation/widgets/report_dialog.dart';
import '../../../application/spot_media_providers.dart';
import '../../../data/spot_media_ranking_api.dart';
import '../../../data/spot_photo_api.dart';
import '../../../data/spot_video_api.dart';
import '../../../domain/sport.dart';
import '../../screens/spot_media_library_screen.dart';
import '../../sport_visuals.dart';
import 'media_tile.dart';
import 'rank_category.dart';
import 'rank_tv_button_box.dart';

/// Hero media block: top-3 for the active [RankCategory] (picked by
/// `RankTvButtonBox`, rendered just below), #1 big + #2/#3 stacked, the
/// Video/Foto parallelogram toggle with a contextual "+" add button, and
/// the floating chrome row (back, like, edit, save, share). Replaces both
/// the old `_MediaGallery` (general hero) and `_GenderRankingSection`
/// (gender carousels) — one hero, switchable by category, instead of a
/// hero plus 3 always-visible carousels further down the screen.
class RankTvBox extends ConsumerStatefulWidget {
  const RankTvBox({
    super.key,
    required this.spotId,
    required this.sports,
    required this.hasGeneralLibrary,
    required this.hasGenderRankings,
    required this.canUploadMedia,
    required this.canEdit,
    required this.spotVoteCount,
    required this.iLiked,
    required this.busy,
    required this.onBack,
    required this.onEdit,
    required this.onToggleLike,
    required this.onComingSoon,
  });

  final int spotId;
  final List<Sport> sports;

  // 'xtremespot' spots never had a browsable general library — "Ver más"
  // on the General category's #3 tile stays hidden for them, same as the
  // old `_MediaGallery`'s "MÁS" button. Gender categories were always
  // fully browsable, so they're unaffected by this flag.
  final bool hasGeneralLibrary;

  // 'iconico' spots are curated reference spots: only a General gallery,
  // no Hombres/Mujeres/Alien ranking — RankTvButtonBox isn't shown at all
  // when this is false, since there'd be nothing to pick between.
  final bool hasGenderRankings;

  // 'iconico' spots only accept uploads from admin/moderator (backend
  // enforces this too, see crud_spot.can_upload_media — this just hides
  // the "+" button for riders who'd get a 403 anyway).
  final bool canUploadMedia;
  final bool canEdit;
  final int spotVoteCount;
  final bool iLiked;
  final bool busy;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final VoidCallback onToggleLike;
  final VoidCallback onComingSoon;

  @override
  ConsumerState<RankTvBox> createState() => _RankTvBoxState();
}

class _RankTvBoxState extends ConsumerState<RankTvBox>
    with AutomaticKeepAliveClientMixin<RankTvBox> {
  late RankCategory _category;
  bool _isVideo = true;
  bool _uploading = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 'iconico' spots only have General — nothing else to land on.
    // 'xtremespot' spots have no General category to land on (see
    // RankTvButtonBox's showGeneral) — default to Hombres instead.
    _category = !widget.hasGenderRankings || widget.hasGeneralLibrary
        ? RankCategory.general
        : RankCategory.men;
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
  Future<int?> _pickMediaSport() {
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
            for (final sport in widget.sports)
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

  Future<void> _addMedia() async {
    if (_uploading) return;
    final isVideo = _isVideo;

    int? sportId;
    if (widget.sports.length > 1) {
      sportId = await _pickMediaSport();
      if (sportId == null) return;
    } else if (widget.sports.length == 1) {
      sportId = widget.sports.first.id;
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

    // Caught here (before upload) instead of letting Firebase Storage's
    // security rule reject the write — that failure surfaces as a
    // confusing `storage/unauthorized`, not anything mentioning size.
    if (isVideo && await exceedsSpotMediaSizeLimit(file.path)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).spotVideoTooLarge),
          ),
        );
      }
      return;
    }

    setState(() => _uploading = true);
    try {
      final user = ref.read(firebaseAuthProvider).currentUser;
      final idToken = await user?.getIdToken();
      if (idToken == null) return;

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final url = await ref
          .read(storageApiProvider)
          .uploadFile(
            path:
                'spots/${widget.spotId}/${isVideo ? 'videos' : 'photos'}/'
                '${timestamp}_${file.name}',
            file: File(file.path),
          );

      if (isVideo) {
        final thumbnailPath = await generateVideoThumbnail(file.path);
        final thumbnailUrl = thumbnailPath == null
            ? null
            : await ref
                  .read(storageApiProvider)
                  .uploadFile(
                    path:
                        'spots/${widget.spotId}/videos/${timestamp}_thumb.jpg',
                    file: File(thumbnailPath),
                  );
        await ref
            .read(spotVideoApiProvider)
            .create(
              spotId: widget.spotId,
              url: url,
              sportId: sportId,
              thumbnailUrl: thumbnailUrl,
              idToken: idToken,
            );
        ref.invalidate(spotVideosProvider(widget.spotId, null));
      } else {
        await ref
            .read(spotPhotoApiProvider)
            .create(
              spotId: widget.spotId,
              url: url,
              sportId: sportId,
              idToken: idToken,
            );
        ref.invalidate(spotPhotosProvider(widget.spotId, null));
      }
      ref.invalidate(spotMediaRankingProvider(widget.spotId));
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

  void _openLibrary(String? gender) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => SpotMediaLibraryScreen(
          spotId: widget.spotId,
          initialIsVideo: _isVideo,
          gender: gender,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    final items = switch (_category) {
      RankCategory.general => _generalItems(),
      RankCategory.men => _genderItems('male'),
      RankCategory.women => _genderItems('female'),
      RankCategory.alien => _genderItems('alien'),
    };
    final canSeeMore = _category == RankCategory.general
        ? widget.hasGeneralLibrary
        : true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 0),
          child: Stack(
            children: [
              SizedBox(
                height: 222,
                child: items.isEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          color: colors.surfaceMedia,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isVideo
                                  ? Symbols.videocam_off
                                  : Symbols.photo_camera,
                              size: 40,
                              color: colors.text700,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _isVideo ? l10n.spotNoVideos : l10n.spotNoMedia,
                              style: context.typography.meta,
                            ),
                          ],
                        ),
                      )
                    : Row(
                        children: [
                          Expanded(
                            flex: 62,
                            child: MediaTile(
                              url: items[0].url,
                              isVideo: _isVideo,
                              thumbnailUrl: items[0].thumbnailUrl,
                              big: true,
                              rankLabel: '#1',
                              caption: items[0].caption,
                              voterNickname: items[0].uploaderNickname,
                              voterIconImage: items[0].uploaderIconImage,
                              onTapVoter: () => context.push(
                                '/riders/${items[0].uploadedBy}',
                              ),
                              onTap: () => openMedia(
                                context,
                                spotId: widget.spotId,
                                item: items[0],
                                isVideo: _isVideo,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 38,
                            child: Column(
                              children: [
                                for (var i = 1; i <= 2; i++)
                                  if (items.length > i) ...[
                                    if (i > 1) const SizedBox(height: 10),
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Positioned.fill(
                                            child: MediaTile(
                                              url: items[i].url,
                                              isVideo: _isVideo,
                                              thumbnailUrl:
                                                  items[i].thumbnailUrl,
                                              big: false,
                                              rankLabel: '#${i + 1}',
                                              voterNickname:
                                                  items[i].uploaderNickname,
                                              voterIconImage:
                                                  items[i].uploaderIconImage,
                                              onTapVoter: () => context.push(
                                                '/riders/${items[i].uploadedBy}',
                                              ),
                                              onTap: () => openMedia(
                                                context,
                                                spotId: widget.spotId,
                                                item: items[i],
                                                isVideo: _isVideo,
                                              ),
                                            ),
                                          ),
                                          if (i == 2 && canSeeMore)
                                            Positioned(
                                              left: 7,
                                              bottom: 7,
                                              child: GestureDetector(
                                                onTap: () => _openLibrary(
                                                  _genderNameOf(_category),
                                                ),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 7,
                                                        vertical: 3,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withValues(alpha: .75),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          99,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    l10n.spotMediaMore,
                                                    style: context
                                                        .typography
                                                        .tag
                                                        .copyWith(
                                                          color: colors
                                                              .colorAction,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
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
                    GestureDetector(
                      onTap: widget.busy ? null : widget.onToggleLike,
                      child: Opacity(
                        opacity: widget.busy ? .5 : 1,
                        child: Semantics(
                          label: l10n.spotLikeLabel,
                          button: true,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 9,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colors.scrimSoft,
                              border: Border.all(color: colors.hairlineStrong),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Symbols.favorite,
                                  fill: widget.iLiked ? 1 : 0,
                                  size: 18,
                                  color: colors.colorAction,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.spotVoteCount}',
                                  style: context.typography.title.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (widget.canEdit) ...[
                      AppIconButton(
                        icon: Symbols.edit,
                        chrome: true,
                        onPressed: widget.onEdit,
                      ),
                      const SizedBox(width: 8),
                    ],
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
                    const SizedBox(width: 8),
                    AppIconButton(
                      icon: Symbols.flag,
                      chrome: true,
                      onPressed: () => ReportDialog.show(
                        context,
                        targetType: 'spot',
                        targetId: widget.spotId,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
          child: _MediaToggle(
            isVideo: _isVideo,
            uploading: _uploading,
            canAdd: widget.canUploadMedia,
            onPickVideo: () => setState(() => _isVideo = true),
            onPickFoto: () => setState(() => _isVideo = false),
            onAdd: _addMedia,
          ),
        ),
        if (widget.hasGenderRankings) ...[
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: RankTvButtonBox(
              active: _category,
              showGeneral: widget.hasGeneralLibrary,
              onPick: (category) => setState(() => _category = category),
            ),
          ),
        ],
      ],
    );
  }

  String? _genderNameOf(RankCategory category) => switch (category) {
    RankCategory.men => 'male',
    RankCategory.women => 'female',
    RankCategory.alien => 'alien',
    RankCategory.general => null,
  };

  List<MediaItem> _generalItems() {
    final photos =
        ref.watch(spotPhotosProvider(widget.spotId, null)).value ?? const [];
    final videos =
        ref.watch(spotVideosProvider(widget.spotId, null)).value ?? const [];
    return _isVideo
        ? [
            for (final v in videos.take(3))
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
            for (final p in photos.take(3))
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

  List<MediaItem> _genderItems(String gender) {
    final ranking = ref.watch(spotMediaRankingProvider(widget.spotId)).value;
    if (ranking == null) return const [];
    final bucket = switch (gender) {
      'male' => ranking.male,
      'female' => ranking.female,
      _ => ranking.alien,
    };
    final source = _isVideo ? bucket.videos : bucket.photos;
    return [
      for (final item in source.take(3))
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
}

/// Video/Foto parallelogram toggle (`skewX(-14deg)`, matching the approved
/// mockup) with a contextual "+" add-media button — to the left of "Video"
/// when it's active, to the right of "Foto" when that's active. All
/// segments share one skewed parent so the diagonal seams stay aligned
/// without per-segment skew/alignment math.
class _MediaToggle extends StatelessWidget {
  const _MediaToggle({
    required this.isVideo,
    required this.uploading,
    required this.canAdd,
    required this.onPickVideo,
    required this.onPickFoto,
    required this.onAdd,
  });

  final bool isVideo;
  final bool uploading;
  final bool canAdd;
  final VoidCallback onPickVideo;
  final VoidCallback onPickFoto;
  final VoidCallback onAdd;

  static const _skew = -0.2443; // CSS skewX(-14deg) in radians

  Widget _unskew(Widget child) => Transform(
    alignment: Alignment.center,
    transform: Matrix4.skewX(-_skew),
    child: child,
  );

  Widget _seam(Color color) => Container(width: 1.5, color: color);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.skewX(_skew),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.surfaceCard,
              border: Border.all(color: colors.hairline),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isVideo && canAdd) ...[
                  _addButton(context, label: l10n.spotAddVideo),
                  _seam(colors.surfaceApp),
                ],
                _toggleButton(
                  context,
                  label: l10n.spotMediaVideoTab,
                  active: isVideo,
                  onTap: onPickVideo,
                ),
                _seam(colors.surfaceApp),
                _toggleButton(
                  context,
                  label: l10n.spotMediaPhotoTab,
                  active: !isVideo,
                  onTap: onPickFoto,
                ),
                if (!isVideo && canAdd) ...[
                  _seam(colors.surfaceApp),
                  _addButton(context, label: l10n.spotAddPhoto),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _toggleButton(
    BuildContext context, {
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: active ? colors.colorAction : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        child: _unskew(
          Text(
            label,
            style: context.typography.tag.copyWith(
              color: active ? colors.colorOnAction : colors.textMuted,
            ),
          ),
        ),
      ),
    );
  }

  Widget _addButton(BuildContext context, {required String label}) {
    final colors = context.colors;
    return GestureDetector(
      onTap: uploading ? null : onAdd,
      child: Opacity(
        opacity: uploading ? .5 : 1,
        child: Container(
          color: colors.colorAction,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
          child: _unskew(
            Semantics(
              label: label,
              button: true,
              child: Icon(Symbols.add, size: 14, color: colors.colorOnAction),
            ),
          ),
        ),
      ),
    );
  }
}
