import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

enum StatTileTone { neutral, rating, warn, danger }

/// Compact stat tile (rating / difficulty / danger). `tone` tints the whole
/// tile. Mirrors `components/spots/StatTile.jsx` from the design system.
class StatTile extends StatelessWidget {
  const StatTile({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.tone = StatTileTone.neutral,
  });

  final IconData icon;
  final String value;
  final String label;
  final StatTileTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (Color iconColor, Color valueColor, Color background, Color border) = switch (tone) {
      StatTileTone.neutral => (
        colors.colorInfo,
        colors.text100,
        colors.surfaceCard,
        colors.hairline,
      ),
      StatTileTone.rating => (
        colors.colorRating,
        colors.text100,
        colors.surfaceCard,
        colors.hairline,
      ),
      StatTileTone.warn => (
        colors.colorWarn,
        colors.colorWarn,
        colors.tintWarn,
        colors.colorWarn.withValues(alpha: .25),
      ),
      StatTileTone.danger => (
        colors.colorDanger,
        colors.colorDanger,
        colors.tintDanger,
        colors.colorDanger.withValues(alpha: .3),
      ),
    };

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: background,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(context.spacing.radiusLg),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: iconColor),
            const SizedBox(height: 5),
            Text(
              value,
              style: context.typography.title.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                height: 1,
                color: valueColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.typography.micro,
            ),
          ],
        ),
      ),
    );
  }
}
