import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/alien_icon.dart';

/// Icon + color per rider gender ('male'|'female'|'alien') — purely
/// client-side presentation, mirrors `SportVisual`/`SpotCategoryVisual`.
/// 'alien' has no Material Symbol to reuse, so [icon] stays null for it
/// and [build] falls back to the custom [AlienIcon] glyph.
class GenderVisual {
  const GenderVisual({this.icon, required this.color});

  final IconData? icon;
  final Color color;

  static GenderVisual of(String gender, AppColors colors) {
    return switch (gender) {
      'male' => GenderVisual(icon: Symbols.male, color: colors.blue500),
      'alien' => GenderVisual(color: colors.colorRating),
      _ => GenderVisual(icon: Symbols.female, color: colors.colorDanger),
    };
  }

  Widget build({double size = 24, bool fill = false}) {
    final glyph = icon;
    if (glyph == null) return AlienIcon(size: size, color: color);
    return Icon(glyph, size: size, color: color, fill: fill ? 1 : 0);
  }
}
