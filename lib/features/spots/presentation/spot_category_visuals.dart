import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';

/// Icon + color per spot category name ('xtremespot' | 'publico' | 'privado'
/// | 'iconico'), purely client-side presentation — mirrors `SportVisual`.
/// Drives both the map pin border/color and the badge on the Spot screen.
class SpotCategoryVisual {
  const SpotCategoryVisual(this.icon, this.color);

  final IconData icon;
  final Color color;

  static SpotCategoryVisual of(String categoryName, AppColors colors) {
    return switch (categoryName.toLowerCase()) {
      'publico' => SpotCategoryVisual(Symbols.location_city, colors.blue500),
      'privado' => SpotCategoryVisual(Symbols.lock, colors.colorDanger),
      'iconico' => SpotCategoryVisual(
        Symbols.military_tech,
        colors.colorRating,
      ),
      // 'xtremespot' (default, rider-created) and any unrecognized value.
      _ => SpotCategoryVisual(Symbols.bolt, colors.colorBrand),
    };
  }
}

/// Human-readable label for a category name — used by the admin-only
/// picker and the Spot screen badge.
String spotCategoryLabel(AppLocalizations l10n, String categoryName) {
  return switch (categoryName.toLowerCase()) {
    'publico' => l10n.spotCategoryPublico,
    'privado' => l10n.spotCategoryPrivado,
    'iconico' => l10n.spotCategoryIconico,
    _ => l10n.spotCategoryXtremespot,
  };
}
