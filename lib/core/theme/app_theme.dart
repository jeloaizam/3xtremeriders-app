import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_effects.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Builds the app's single dark theme from the 3xtreme Riders design tokens.
/// Screens read tokens via `Theme.of(context).extension<AppColors>()` etc.
/// rather than hardcoding values.
class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    const colors = AppColors.dark;
    const spacing = AppSpacing.standard;
    const effects = AppEffects.standard;
    final typography = AppTypography.build(colors);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: colors.surfaceApp,
      colorScheme: ColorScheme.dark(
        primary: colors.colorAction,
        onPrimary: colors.colorOnAction,
        secondary: colors.colorBrand,
        onSecondary: colors.text100,
        error: colors.colorDanger,
        onError: colors.bg850,
        surface: colors.surfaceCard,
        onSurface: colors.textHeading,
      ),
      textTheme: TextTheme(
        displayLarge: typography.displayXl,
        displayMedium: typography.displayLg,
        displaySmall: typography.displayMd,
        headlineSmall: typography.displaySm,
        titleMedium: typography.title,
        bodyLarge: typography.body,
        bodyMedium: typography.bodySm,
        bodySmall: typography.meta,
        labelLarge: typography.label,
        labelMedium: typography.eyebrow,
        labelSmall: typography.tag,
      ),
      dividerColor: colors.hairline,
      extensions: [colors, spacing, effects, typography],
    );
  }
}

/// Convenience accessors so screens can write `context.colors`,
/// `context.spacing`, `context.effects`, `context.typography`.
extension AppThemeContext on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  AppSpacing get spacing => Theme.of(this).extension<AppSpacing>()!;
  AppEffects get effects => Theme.of(this).extension<AppEffects>()!;
  AppTypography get typography => Theme.of(this).extension<AppTypography>()!;
}
