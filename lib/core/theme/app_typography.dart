import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Typography tokens ported from `tokens/typography.css`.
/// Display: Oswald (condensed, editorial impact).
/// Body/UI: Archivo (neutral grotesque, high legibility).
/// Access via `Theme.of(context).extension<AppTypography>()`.
@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.displayXl,
    required this.displayLg,
    required this.displayMd,
    required this.displaySm,
    required this.title,
    required this.numeral,
    required this.body,
    required this.bodySm,
    required this.meta,
    required this.micro,
    required this.label,
    required this.eyebrow,
    required this.tag,
  });

  final TextStyle displayXl;
  final TextStyle displayLg;
  final TextStyle displayMd;
  final TextStyle displaySm;
  final TextStyle title;
  final TextStyle numeral;
  final TextStyle body;
  final TextStyle bodySm;
  final TextStyle meta;
  final TextStyle micro;
  final TextStyle label;
  final TextStyle eyebrow;
  final TextStyle tag;

  static const _lsTight = -0.02;
  static const _lsNormal = 0.01;
  static const _lsLabel = 0.06;
  static const _lsEyebrow = 0.16;

  static const _lhTight = 1.0;
  static const _lhSnug = 1.2;
  static const _lhBody = 1.5;

  static AppTypography build(AppColors colors) {
    TextStyle display(double size, FontWeight weight, double ls) =>
        GoogleFonts.oswald(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: size * ls,
          height: _lhTight,
          color: colors.textHeading,
        );

    TextStyle label(double size, FontWeight weight, double ls) =>
        GoogleFonts.oswald(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: size * ls,
          height: _lhSnug,
          color: colors.textHeading,
        );

    TextStyle body(double size, FontWeight weight, Color color) =>
        GoogleFonts.archivo(
          fontSize: size,
          fontWeight: weight,
          letterSpacing: size * _lsNormal,
          height: _lhBody,
          color: color,
        );

    return AppTypography(
      displayXl: display(68, FontWeight.w600, _lsTight),
      displayLg: display(34, FontWeight.w600, _lsTight),
      displayMd: display(30, FontWeight.w500, _lsTight),
      displaySm: display(24, FontWeight.w500, _lsTight),
      title: label(18, FontWeight.w500, _lsNormal),
      numeral: display(22, FontWeight.w600, _lsTight),
      body: body(14, FontWeight.w400, colors.textBody),
      bodySm: body(13, FontWeight.w400, colors.textBody),
      meta: body(12, FontWeight.w400, colors.textMuted),
      micro: body(11, FontWeight.w400, colors.textMuted),
      label: label(13, FontWeight.w500, _lsLabel),
      eyebrow: label(12, FontWeight.w500, _lsEyebrow),
      tag: label(11, FontWeight.w600, _lsLabel),
    );
  }

  @override
  AppTypography copyWith({
    TextStyle? displayXl,
    TextStyle? displayLg,
    TextStyle? displayMd,
    TextStyle? displaySm,
    TextStyle? title,
    TextStyle? numeral,
    TextStyle? body,
    TextStyle? bodySm,
    TextStyle? meta,
    TextStyle? micro,
    TextStyle? label,
    TextStyle? eyebrow,
    TextStyle? tag,
  }) {
    return AppTypography(
      displayXl: displayXl ?? this.displayXl,
      displayLg: displayLg ?? this.displayLg,
      displayMd: displayMd ?? this.displayMd,
      displaySm: displaySm ?? this.displaySm,
      title: title ?? this.title,
      numeral: numeral ?? this.numeral,
      body: body ?? this.body,
      bodySm: bodySm ?? this.bodySm,
      meta: meta ?? this.meta,
      micro: micro ?? this.micro,
      label: label ?? this.label,
      eyebrow: eyebrow ?? this.eyebrow,
      tag: tag ?? this.tag,
    );
  }

  @override
  AppTypography lerp(ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    return AppTypography(
      displayXl: TextStyle.lerp(displayXl, other.displayXl, t)!,
      displayLg: TextStyle.lerp(displayLg, other.displayLg, t)!,
      displayMd: TextStyle.lerp(displayMd, other.displayMd, t)!,
      displaySm: TextStyle.lerp(displaySm, other.displaySm, t)!,
      title: TextStyle.lerp(title, other.title, t)!,
      numeral: TextStyle.lerp(numeral, other.numeral, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      bodySm: TextStyle.lerp(bodySm, other.bodySm, t)!,
      meta: TextStyle.lerp(meta, other.meta, t)!,
      micro: TextStyle.lerp(micro, other.micro, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
      eyebrow: TextStyle.lerp(eyebrow, other.eyebrow, t)!,
      tag: TextStyle.lerp(tag, other.tag, t)!,
    );
  }
}
