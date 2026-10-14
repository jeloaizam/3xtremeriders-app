import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import '../../../domain/spot.dart';
import '../../spot_category_visuals.dart';

/// Barrio/ciudad/país, whichever of the three actually resolved (see
/// `create_spot_screen.dart`'s reverse geocoding) — joined so a spot
/// missing one piece (older spots have no city/country; not every city
/// has a tracked neighborhood) doesn't show a stray ", " gap.
String? _spotLocationLabel(Spot spot) {
  final parts = [
    spot.neighborhood,
    spot.cityName,
    spot.countryName,
  ].where((part) => part != null && part.trim().isNotEmpty);
  return parts.isEmpty ? null : parts.join(', ');
}

/// Category badge, spot name, and location — `SpotNameBox` from the
/// approved mockup, plus the category badge (kept per product decision,
/// not in the original mockup but with nowhere else to live).
class SpotNameBox extends StatelessWidget {
  const SpotNameBox({super.key, required this.spot});

  final Spot spot;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final location = _spotLocationLabel(spot);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CategoryBadge(categoryName: spot.categoryName),
        const SizedBox(height: 8),
        Text(spot.name.toUpperCase(), style: context.typography.displayMd),
        if (location != null) ...[
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Symbols.location_on, size: 16, color: colors.textMuted),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  location,
                  style: context.typography.bodySm.copyWith(
                    color: colors.textMuted,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visual = SpotCategoryVisual.of(categoryName, colors);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: visual.color.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(visual.icon, size: 14, color: visual.color),
          const SizedBox(width: 5),
          Text(
            spotCategoryLabel(AppLocalizations.of(context), categoryName)
                .toUpperCase(),
            style: context.typography.tag.copyWith(color: visual.color),
          ),
        ],
      ),
    );
  }
}
