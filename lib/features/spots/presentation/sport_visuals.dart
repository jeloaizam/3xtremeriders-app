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
      'mtb' ||
      'mountain bike' => SportVisual(Symbols.terrain, colors.colorRating),
      'gravity bike' => SportVisual(
        Symbols.directions_bike,
        colors.colorDanger,
      ),
      'pennyboard' => SportVisual(Symbols.skateboarding, colors.blue500),
      'longboard' => SportVisual(Symbols.skateboarding, colors.colorAction),
      'scooter' => SportVisual(Symbols.scooter, colors.colorBrand),
      'parkour' => SportVisual(Symbols.directions_run, colors.colorAction),
      'fixie bike' => SportVisual(Symbols.pedal_bike, colors.colorBrand),
      'downhill' => SportVisual(Symbols.speed, colors.colorDanger),
      'kite surf' => SportVisual(Symbols.kitesurfing, colors.colorBrand),
      'wind surf' => SportVisual(Symbols.sailing, colors.blue500),
      'bungee jumping' => SportVisual(Symbols.height, colors.colorDanger),
      'rafting' => SportVisual(Symbols.rowing, colors.colorBrand),
      'kayaking' => SportVisual(Symbols.kayaking, colors.blue500),
      'parapentismo' => SportVisual(Symbols.paragliding, colors.blue500),
      'wingsuit' => SportVisual(Symbols.flight, colors.colorDanger),
      'snowboard' => SportVisual(Symbols.snowboarding, colors.blue500),
      'esquí' => SportVisual(Symbols.downhill_skiing, colors.colorRating),
      'wakeboard' => SportVisual(Symbols.surfing, colors.colorRating),
      'wakesurf' => SportVisual(Symbols.surfing, colors.colorAction),
      'escalada' => SportVisual(Symbols.terrain, colors.colorDanger),
      'buceo' => SportVisual(Symbols.scuba_diving, colors.colorBrand),
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
