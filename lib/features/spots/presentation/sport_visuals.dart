import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/theme/app_colors.dart';

/// Icon + color per sport name, purely a client-side presentation detail —
/// the backend's `Sport` model only stores name/description.
class SportVisual {
  const SportVisual(this.icon, this.color);

  final IconData icon;
  final Color color;

  static SportVisual of(String sportName, AppColors colors) {
    return switch (sportName.toLowerCase()) {
      'skateboard' => SportVisual(Symbols.skateboarding, colors.colorBrand),
      'bmx' => SportVisual(Symbols.pedal_bike, colors.blue500),
      'rollerblade' => SportVisual(Symbols.roller_skating, colors.colorRating),
      'surf' => SportVisual(Symbols.surfing, colors.blue500),
      'mtb' => SportVisual(Symbols.pedal_bike, colors.colorRating),
      _ => SportVisual(Symbols.sports, colors.textMuted),
    };
  }
}

/// Icon per spot-element type — also client-only, `SpotElement` has no icon
/// field server-side.
IconData elementIcon(String? type) {
  return switch (type?.toLowerCase()) {
    'bowl' => Symbols.pool,
    'ramps' => Symbols.trending_up,
    'grinds' => Symbols.horizontal_rule,
    'rail' => Symbols.horizontal_rule,
    'stairs' => Symbols.stairs,
    _ => Symbols.landscape,
  };
}
