import 'package:flutter/material.dart';

/// Shadow & motion tokens ported from `tokens/effects.css`.
/// Access via `Theme.of(context).extension<AppEffects>()`.
@immutable
class AppEffects extends ThemeExtension<AppEffects> {
  const AppEffects({
    required this.shadowCard,
    required this.shadowFloat,
    required this.shadowSheet,
    required this.shadowAction,
    required this.easeOut,
    required this.durFast,
    required this.durBase,
    required this.durScreen,
  });

  final List<BoxShadow> shadowCard;
  final List<BoxShadow> shadowFloat;
  final List<BoxShadow> shadowSheet;
  final List<BoxShadow> shadowAction;

  final Curve easeOut;
  final Duration durFast;
  final Duration durBase;
  final Duration durScreen;

  static const standard = AppEffects(
    shadowCard: [
      BoxShadow(color: Color(0x40000000), offset: Offset(0, 2), blurRadius: 8),
    ],
    shadowFloat: [
      BoxShadow(
        color: Color(0x99000000),
        offset: Offset(0, 20),
        blurRadius: 40,
        spreadRadius: -12,
      ),
    ],
    shadowSheet: [
      BoxShadow(
        color: Color(0xB3000000),
        offset: Offset(0, -18),
        blurRadius: 40,
        spreadRadius: -12,
      ),
    ],
    shadowAction: [
      BoxShadow(
        color: Color(0x80F6FF99),
        offset: Offset(0, 10),
        blurRadius: 22,
        spreadRadius: -4,
      ),
    ],
    easeOut: Cubic(0.22, 1, 0.36, 1),
    durFast: Duration(milliseconds: 200),
    durBase: Duration(milliseconds: 280),
    durScreen: Duration(milliseconds: 300),
  );

  @override
  AppEffects copyWith() => this;

  @override
  AppEffects lerp(ThemeExtension<AppEffects>? other, double t) {
    if (other is! AppEffects) return this;
    return t < 0.5 ? this : other;
  }
}
