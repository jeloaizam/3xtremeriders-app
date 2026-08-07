import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../application/spots_providers.dart';
import '../../domain/spot.dart';
import '../sport_visuals.dart';

/// Horizontal spot list row: hatch thumbnail w/ sport badge, name, sports,
/// rating. Mirrors `components/spots/SpotCard.jsx` from the design system,
/// backed by real `Spot`/`Sport` data.
class SpotCard extends ConsumerWidget {
  const SpotCard({super.key, required this.spot, this.onTap});

  final Spot spot;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final spacing = context.spacing;
    final sports = ref.watch(spotSportsProvider(spot.id)).value ?? const [];
    final badgeIcon = sports.isEmpty
        ? Symbols.location_on
        : SportVisual.of(sports.first.name, colors).icon;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(spacing.radiusLg),
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairline),
          borderRadius: BorderRadius.circular(spacing.radiusLg),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(spacing.radiusSm),
                  child: SizedBox(
                    width: 58,
                    height: 58,
                    child: _Thumbnail(spot: spot, colors: colors),
                  ),
                ),
                Positioned(
                  bottom: -6,
                  right: -6,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: colors.bg850,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.hairlineStrong),
                    ),
                    child: Icon(badgeIcon, size: 14, color: colors.colorBrand),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    spot.name,
                    style: context.typography.title.copyWith(height: 1),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    sports.map((s) => s.name).join(' · '),
                    style: context.typography.meta,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Symbols.star, size: 13, color: colors.colorRating),
                      const SizedBox(width: 3),
                      Text(
                        spot.ratingAvg?.toStringAsFixed(1) ?? '—',
                        style: context.typography.tag.copyWith(
                          color: colors.colorRating,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The card's 58x58 thumbnail — shows the actual cover photo/video-thumbnail
/// image for whichever media type has more likes (`spot.topMediaType`),
/// falling back to a plain icon when there's no image to show yet (a video
/// with no thumbnail, or a spot with no media at all).
class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.spot, required this.colors});

  final Spot spot;
  final AppColors colors;

  Widget _placeholder(IconData icon) => Container(
    color: colors.surfaceMedia,
    alignment: Alignment.center,
    child: Icon(icon, fill: 1, size: 22, color: colors.text700),
  );

  @override
  Widget build(BuildContext context) {
    if (spot.topMediaType == 'photo' && spot.coverPhotoUrl != null) {
      return Image.network(
        spot.coverPhotoUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _placeholder(Symbols.photo_camera),
      );
    }
    if (spot.topMediaType == 'video') {
      if (spot.coverVideoThumbnailUrl == null) {
        return _placeholder(Symbols.videocam);
      }
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            spot.coverVideoThumbnailUrl!,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                _placeholder(Symbols.videocam),
          ),
          Center(
            child: Icon(
              Symbols.play_circle,
              fill: 1,
              size: 20,
              color: colors.colorAction,
            ),
          ),
        ],
      );
    }
    return _placeholder(Symbols.location_on);
  }
}
