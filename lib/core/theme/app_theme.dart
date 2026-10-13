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
      pageTransitionsTheme: pageTransitions,
    );
  }

  // Flutter's Material 3 default (ZoomPageTransitionsBuilder) reads as
  // generic scale+fade with no directional cue. FadeForwards is the
  // platform-recommended replacement (also what enables Android 14+
  // predictive back) and already composites via transform+opacity at the
  // engine's default 300ms — which happens to match `AppEffects.durScreen`.
  // Only android is listed: unlisted platforms fall back to their own
  // native builder (iOS keeps Cupertino's slide), not a shared default.
  static const pageTransitions = PageTransitionsTheme(
    builders: {TargetPlatform.android: FadeForwardsPageTransitionsBuilder()},
  );

  // `MediaQuery.disableAnimations` (the OS "remove animations"
  // accessibility setting) isn't checked by Flutter's built-in
  // PageTransitionsBuilders on its own — without this override, reduced
  // motion would still get the full slide+fade. Keeps the opacity cue
  // (comprehension: a new screen arrived) and drops all movement, per
  // reduced-motion guidance ("fewer and gentler", not zero animation).
  static const reducedMotionPageTransitions = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: _FadeOnlyPageTransitionsBuilder(),
      TargetPlatform.iOS: _FadeOnlyPageTransitionsBuilder(),
      TargetPlatform.macOS: _FadeOnlyPageTransitionsBuilder(),
      TargetPlatform.linux: _FadeOnlyPageTransitionsBuilder(),
      TargetPlatform.windows: _FadeOnlyPageTransitionsBuilder(),
      TargetPlatform.fuchsia: _FadeOnlyPageTransitionsBuilder(),
    },
  );
}

class _FadeOnlyPageTransitionsBuilder extends PageTransitionsBuilder {
  const _FadeOnlyPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
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
