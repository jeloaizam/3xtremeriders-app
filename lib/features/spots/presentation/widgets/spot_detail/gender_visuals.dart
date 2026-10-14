import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/theme/app_colors.dart';

/// Icon + color per rider gender ('male'|'female'|'alien') — purely
/// client-side presentation, mirrors `SportVisual`/`SpotCategoryVisual`.
/// Reuses the icon/color convention already established on the rider
/// profile and complete-profile screens: `Symbols.rocket_launch` stands in
/// for "alien" since Material Symbols has no dedicated glyph for it.
class GenderVisual {
  const GenderVisual(this.icon, this.color);

  final IconData icon;
  final Color color;

  static GenderVisual of(String gender, AppColors colors) {
    return switch (gender) {
      'male' => GenderVisual(Symbols.male, colors.blue500),
      'alien' => GenderVisual(Symbols.rocket_launch, colors.colorRating),
      _ => GenderVisual(Symbols.female, colors.colorDanger),
    };
  }
}
