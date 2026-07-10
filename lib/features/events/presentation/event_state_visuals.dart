import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/gen/app_localizations.dart';

/// Color + localized label per event state id (1=active, 2=cancelled,
/// 3=hidden — seeded rows, no picker/endpoint needed since CreateEventScreen
/// doesn't expose a state choice, mirrors `RideStateVisual`'s pattern).
class EventStateVisual {
  const EventStateVisual(this.label, this.color);

  final String label;
  final Color color;

  static EventStateVisual? of(
    int? stateId,
    AppColors colors,
    AppLocalizations l10n,
  ) {
    return switch (stateId) {
      1 => EventStateVisual(l10n.eventStateActive, colors.colorRating),
      2 => EventStateVisual(l10n.eventStateCancelled, colors.colorDanger),
      3 => EventStateVisual(l10n.eventStateHidden, colors.text300),
      _ => null,
    };
  }
}
