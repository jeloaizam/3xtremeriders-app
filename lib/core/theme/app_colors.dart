import 'package:flutter/material.dart';

/// Design tokens ported from `tokens/colors.css` in the 3xtreme Riders
/// Claude Design project. Dark, cool-tinted neutrals + a 4-color energy
/// palette. Access via `Theme.of(context).extension<AppColors>()`.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.blue500,
    required this.teal500,
    required this.green400,
    required this.yellow300,
    required this.coral400,
    required this.bg900,
    required this.bg850,
    required this.surface800,
    required this.surface700,
    required this.surface600,
    required this.surface500,
    required this.hairline,
    required this.hairlineSoft,
    required this.hairlineStrong,
    required this.text100,
    required this.text300,
    required this.text500,
    required this.text700,
    required this.scrimStrong,
    required this.scrimSoft,
    required this.glass,
    required this.tintRating,
    required this.tintInfo,
    required this.tintWarn,
    required this.tintDanger,
    required this.tintBlue,
  });

  // --- Brand palette ---
  final Color blue500;
  final Color teal500;
  final Color green400;
  final Color yellow300;
  final Color coral400;

  // --- Neutrals ---
  final Color bg900;
  final Color bg850;
  final Color surface800;
  final Color surface700;
  final Color surface600;
  final Color surface500;
  final Color hairline;
  final Color hairlineSoft;
  final Color hairlineStrong;

  // --- Text ---
  final Color text100;
  final Color text300;
  final Color text500;
  final Color text700;

  // --- Translucent scrims ---
  final Color scrimStrong;
  final Color scrimSoft;
  final Color glass;

  // --- Tinted chip backgrounds ---
  final Color tintRating;
  final Color tintInfo;
  final Color tintWarn;
  final Color tintDanger;
  final Color tintBlue;

  // --- Semantic aliases (mirroring the CSS custom properties) ---
  Color get colorAction => yellow300;
  Color get colorOnAction => bg850;
  Color get colorBrand => teal500;
  Color get colorInfo => teal500;
  Color get colorRating => green400;
  Color get colorWarn => yellow300;
  Color get colorDanger => coral400;

  Color get surfaceApp => bg850;
  Color get surfaceCard => surface700;
  Color get surfaceNav => surface800;
  Color get surfaceMedia => surface500;
  Color get borderCard => hairline;

  Color get textHeading => text100;
  Color get textBody => text300;
  Color get textMuted => text500;
  Color get textFaint => text700;

  static const brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF476EAE), Color(0xFF48B3AF)],
  );

  static const dark = AppColors(
    blue500: Color(0xFF476EAE),
    teal500: Color(0xFF48B3AF),
    green400: Color(0xFFA7E399),
    yellow300: Color(0xFFF6FF99),
    coral400: Color(0xFFFF8F6B),
    bg900: Color(0xFF0A0B0E),
    bg850: Color(0xFF0E1218),
    surface800: Color(0xFF12151B),
    surface700: Color(0xFF181C23),
    surface600: Color(0xFF1E222B),
    surface500: Color(0xFF22262F),
    hairline: Color(0x14FFFFFF),
    hairlineSoft: Color(0x0FFFFFFF),
    hairlineStrong: Color(0x1FFFFFFF),
    text100: Color(0xFFEEF1F5),
    text300: Color(0xFFC4CAD4),
    text500: Color(0xFF8A91A0),
    text700: Color(0xFF4A505C),
    scrimStrong: Color(0xD90E1218),
    scrimSoft: Color(0x8C0E1218),
    glass: Color(0xD1101318),
    tintRating: Color(0x24A7E399),
    tintInfo: Color(0x2448B3AF),
    tintWarn: Color(0x24F6FF99),
    tintDanger: Color(0x29FF8F6B),
    tintBlue: Color(0x2E476EAE),
  );

  @override
  AppColors copyWith({
    Color? blue500,
    Color? teal500,
    Color? green400,
    Color? yellow300,
    Color? coral400,
    Color? bg900,
    Color? bg850,
    Color? surface800,
    Color? surface700,
    Color? surface600,
    Color? surface500,
    Color? hairline,
    Color? hairlineSoft,
    Color? hairlineStrong,
    Color? text100,
    Color? text300,
    Color? text500,
    Color? text700,
    Color? scrimStrong,
    Color? scrimSoft,
    Color? glass,
    Color? tintRating,
    Color? tintInfo,
    Color? tintWarn,
    Color? tintDanger,
    Color? tintBlue,
  }) {
    return AppColors(
      blue500: blue500 ?? this.blue500,
      teal500: teal500 ?? this.teal500,
      green400: green400 ?? this.green400,
      yellow300: yellow300 ?? this.yellow300,
      coral400: coral400 ?? this.coral400,
      bg900: bg900 ?? this.bg900,
      bg850: bg850 ?? this.bg850,
      surface800: surface800 ?? this.surface800,
      surface700: surface700 ?? this.surface700,
      surface600: surface600 ?? this.surface600,
      surface500: surface500 ?? this.surface500,
      hairline: hairline ?? this.hairline,
      hairlineSoft: hairlineSoft ?? this.hairlineSoft,
      hairlineStrong: hairlineStrong ?? this.hairlineStrong,
      text100: text100 ?? this.text100,
      text300: text300 ?? this.text300,
      text500: text500 ?? this.text500,
      text700: text700 ?? this.text700,
      scrimStrong: scrimStrong ?? this.scrimStrong,
      scrimSoft: scrimSoft ?? this.scrimSoft,
      glass: glass ?? this.glass,
      tintRating: tintRating ?? this.tintRating,
      tintInfo: tintInfo ?? this.tintInfo,
      tintWarn: tintWarn ?? this.tintWarn,
      tintDanger: tintDanger ?? this.tintDanger,
      tintBlue: tintBlue ?? this.tintBlue,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      blue500: Color.lerp(blue500, other.blue500, t)!,
      teal500: Color.lerp(teal500, other.teal500, t)!,
      green400: Color.lerp(green400, other.green400, t)!,
      yellow300: Color.lerp(yellow300, other.yellow300, t)!,
      coral400: Color.lerp(coral400, other.coral400, t)!,
      bg900: Color.lerp(bg900, other.bg900, t)!,
      bg850: Color.lerp(bg850, other.bg850, t)!,
      surface800: Color.lerp(surface800, other.surface800, t)!,
      surface700: Color.lerp(surface700, other.surface700, t)!,
      surface600: Color.lerp(surface600, other.surface600, t)!,
      surface500: Color.lerp(surface500, other.surface500, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      hairlineSoft: Color.lerp(hairlineSoft, other.hairlineSoft, t)!,
      hairlineStrong: Color.lerp(hairlineStrong, other.hairlineStrong, t)!,
      text100: Color.lerp(text100, other.text100, t)!,
      text300: Color.lerp(text300, other.text300, t)!,
      text500: Color.lerp(text500, other.text500, t)!,
      text700: Color.lerp(text700, other.text700, t)!,
      scrimStrong: Color.lerp(scrimStrong, other.scrimStrong, t)!,
      scrimSoft: Color.lerp(scrimSoft, other.scrimSoft, t)!,
      glass: Color.lerp(glass, other.glass, t)!,
      tintRating: Color.lerp(tintRating, other.tintRating, t)!,
      tintInfo: Color.lerp(tintInfo, other.tintInfo, t)!,
      tintWarn: Color.lerp(tintWarn, other.tintWarn, t)!,
      tintDanger: Color.lerp(tintDanger, other.tintDanger, t)!,
      tintBlue: Color.lerp(tintBlue, other.tintBlue, t)!,
    );
  }
}
