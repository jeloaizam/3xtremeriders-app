import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum AppBadgeTone { rating, info, warn, danger, blue }

/// Small data pill: rating, danger level, tags. Tone drives color.
/// Mirrors `components/core/Badge.jsx` from the design system.
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    required this.label,
    this.icon,
    this.tone = AppBadgeTone.info,
  });

  final String label;
  final IconData? icon;
  final AppBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (Color background, Color foreground) = switch (tone) {
      AppBadgeTone.rating => (colors.tintRating, colors.colorRating),
      AppBadgeTone.info => (colors.tintInfo, colors.colorInfo),
      AppBadgeTone.warn => (colors.tintWarn, colors.colorWarn),
      AppBadgeTone.danger => (colors.tintDanger, colors.colorDanger),
      AppBadgeTone.blue => (colors.tintBlue, colors.blue500),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(context.spacing.radiusXs),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: foreground),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: context.typography.tag.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}
