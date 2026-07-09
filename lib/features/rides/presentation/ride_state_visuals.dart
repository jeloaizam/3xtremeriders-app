import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';

/// Color + localized label per ride state name ('active'/'onSale'/
/// 'wasted'/'toGift') — purely client-side presentation, mirrors
/// `sport_visuals.dart`'s pattern for [SportVisual].
class RideStateVisual {
  const RideStateVisual(this.label, this.color);

  final String label;
  final Color color;

  static RideStateVisual? of(
    String? stateName,
    AppColors colors,
    AppLocalizations l10n,
  ) {
    return switch (stateName) {
      'active' => RideStateVisual(l10n.rideStateActive, colors.colorRating),
      'onSale' => RideStateVisual(l10n.rideStateOnSale, colors.colorAction),
      'wasted' => RideStateVisual(l10n.rideStateWasted, colors.colorDanger),
      'toGift' => RideStateVisual(l10n.rideStateToGift, colors.blue500),
      _ => null,
    };
  }
}
