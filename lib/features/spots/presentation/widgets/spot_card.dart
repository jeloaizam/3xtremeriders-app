import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/spot.dart';

/// Horizontal spot list row: hatch thumbnail w/ sport badge, name, meta, rating.
/// Mirrors `components/spots/SpotCard.jsx` from the design system.
class SpotCard extends StatelessWidget {
  const SpotCard({super.key, required this.spot, this.onTap});

  final Spot spot;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

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
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: colors.surfaceMedia,
                    borderRadius: BorderRadius.circular(spacing.radiusSm),
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
                    child: Icon(
                      spot.sportIcon,
                      size: 14,
                      color: colors.colorBrand,
                    ),
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
                  Text(spot.meta, style: context.typography.meta),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Symbols.star, size: 13, color: colors.colorRating),
                      const SizedBox(width: 3),
                      Text(
                        spot.rating.toStringAsFixed(1),
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
