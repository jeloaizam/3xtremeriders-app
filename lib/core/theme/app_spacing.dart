import 'package:flutter/material.dart';

/// Spacing, radii & control-size tokens ported from `tokens/spacing.css`.
/// Base unit 4px. Access via `Theme.of(context).extension<AppSpacing>()`.
@immutable
class AppSpacing extends ThemeExtension<AppSpacing> {
  const AppSpacing({
    required this.space1,
    required this.space2,
    required this.space3,
    required this.space4,
    required this.space5,
    required this.space6,
    required this.space8,
    required this.space10,
    required this.gutter,
    required this.gutterLg,
    required this.statusBar,
    required this.navHeight,
    required this.radiusXs,
    required this.radiusSm,
    required this.radiusMd,
    required this.radiusLg,
    required this.radiusXl,
    required this.radius2xl,
    required this.radiusPhone,
    required this.radiusPill,
    required this.controlH,
    required this.controlHSm,
    required this.tapMin,
    required this.iconBtn,
    required this.avatarSm,
    required this.avatarMd,
    required this.avatarLg,
    required this.avatarXl,
  });

  final double space1;
  final double space2;
  final double space3;
  final double space4;
  final double space5;
  final double space6;
  final double space8;
  final double space10;

  final double gutter;
  final double gutterLg;
  final double statusBar;
  final double navHeight;

  final double radiusXs;
  final double radiusSm;
  final double radiusMd;
  final double radiusLg;
  final double radiusXl;
  final double radius2xl;
  final double radiusPhone;
  final double radiusPill;

  final double controlH;
  final double controlHSm;
  final double tapMin;
  final double iconBtn;
  final double avatarSm;
  final double avatarMd;
  final double avatarLg;
  final double avatarXl;

  static const standard = AppSpacing(
    space1: 4,
    space2: 8,
    space3: 12,
    space4: 16,
    space5: 20,
    space6: 24,
    space8: 32,
    space10: 40,
    gutter: 18,
    gutterLg: 20,
    statusBar: 52,
    navHeight: 84,
    radiusXs: 7,
    radiusSm: 11,
    radiusMd: 13,
    radiusLg: 14,
    radiusXl: 16,
    radius2xl: 24,
    radiusPhone: 38,
    radiusPill: 99,
    controlH: 52,
    controlHSm: 46,
    tapMin: 44,
    iconBtn: 42,
    avatarSm: 34,
    avatarMd: 42,
    avatarLg: 52,
    avatarXl: 88,
  );

  @override
  AppSpacing copyWith() => this;

  @override
  AppSpacing lerp(ThemeExtension<AppSpacing>? other, double t) {
    if (other is! AppSpacing) return this;
    return AppSpacing(
      space1: _l(space1, other.space1, t),
      space2: _l(space2, other.space2, t),
      space3: _l(space3, other.space3, t),
      space4: _l(space4, other.space4, t),
      space5: _l(space5, other.space5, t),
      space6: _l(space6, other.space6, t),
      space8: _l(space8, other.space8, t),
      space10: _l(space10, other.space10, t),
      gutter: _l(gutter, other.gutter, t),
      gutterLg: _l(gutterLg, other.gutterLg, t),
      statusBar: _l(statusBar, other.statusBar, t),
      navHeight: _l(navHeight, other.navHeight, t),
      radiusXs: _l(radiusXs, other.radiusXs, t),
      radiusSm: _l(radiusSm, other.radiusSm, t),
      radiusMd: _l(radiusMd, other.radiusMd, t),
      radiusLg: _l(radiusLg, other.radiusLg, t),
      radiusXl: _l(radiusXl, other.radiusXl, t),
      radius2xl: _l(radius2xl, other.radius2xl, t),
      radiusPhone: _l(radiusPhone, other.radiusPhone, t),
      radiusPill: _l(radiusPill, other.radiusPill, t),
      controlH: _l(controlH, other.controlH, t),
      controlHSm: _l(controlHSm, other.controlHSm, t),
      tapMin: _l(tapMin, other.tapMin, t),
      iconBtn: _l(iconBtn, other.iconBtn, t),
      avatarSm: _l(avatarSm, other.avatarSm, t),
      avatarMd: _l(avatarMd, other.avatarMd, t),
      avatarLg: _l(avatarLg, other.avatarLg, t),
      avatarXl: _l(avatarXl, other.avatarXl, t),
    );
  }

  static double _l(double a, double b, double t) => a + (b - a) * t;
}
