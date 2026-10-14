import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../l10n/gen/app_localizations.dart';

/// 4 compact columns: star rating (tap to rate), hazard "muletas" rating
/// (tap to rate), season, and difficulty — the mockup's `InfoRatingBox`
/// plus a 4th column for difficulty (no other home for it on this screen,
/// product decision). The star/crutch rows reflect the signed-in rider's
/// own rating (tap to change it); the number below each is the spot's
/// community average.
class InfoRatingBox extends StatelessWidget {
  const InfoRatingBox({
    super.key,
    required this.ratingAvg,
    required this.hazardAvg,
    required this.bestSeason,
    required this.difficulty,
    required this.myStars,
    required this.myCrutches,
    required this.busy,
    required this.onRate,
    required this.onRateHazard,
  });

  final double? ratingAvg;
  final double? hazardAvg;
  final String? bestSeason;
  final int? difficulty;
  final int myStars;
  final int myCrutches;
  final bool busy;
  final void Function(int stars) onRate;
  final void Function(int crutches) onRateHazard;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairline),
        borderRadius: BorderRadius.circular(context.spacing.radiusXl),
      ),
      child: Opacity(
        opacity: busy ? .5 : 1,
        child: Row(
          children: [
            Expanded(
              child: _Column(
                icons: [
                  for (var star = 1; star <= 5; star++)
                    _IconDot(
                      icon: Symbols.star,
                      filled: star <= myStars,
                      color: colors.colorAction,
                      onTap: busy ? null : () => onRate(star),
                    ),
                ],
                value: ratingAvg?.toStringAsFixed(1) ?? '—',
                label: l10n.spotRatingLabel,
              ),
            ),
            _Divider(color: colors.hairline),
            Expanded(
              child: _Column(
                icons: [
                  for (var crutch = 1; crutch <= 5; crutch++)
                    _IconDot(
                      icon: Symbols.personal_injury,
                      filled: crutch <= myCrutches,
                      color: colors.colorWarn,
                      onTap: busy ? null : () => onRateHazard(crutch),
                    ),
                ],
                value: hazardAvg?.toStringAsFixed(1) ?? '—',
                label: l10n.spotHazardLabel,
              ),
            ),
            _Divider(color: colors.hairline),
            Expanded(
              child: _Column(
                value: bestSeason ?? '—',
                label: l10n.spotSeason,
              ),
            ),
            _Divider(color: colors.hairline),
            Expanded(
              child: _Column(
                value: difficulty != null ? '$difficulty/5' : '—',
                label: l10n.spotDifficulty,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Column extends StatelessWidget {
  const _Column({this.icons, required this.value, required this.label});

  final List<Widget>? icons;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icons != null) ...[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: icons!),
          const SizedBox(height: 4),
        ],
        Text(
          value,
          style: context.typography.title.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: context.typography.micro,
        ),
      ],
    );
  }
}

class _IconDot extends StatelessWidget {
  const _IconDot({
    required this.icon,
    required this.filled,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final bool filled;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(1),
        child: Icon(
          icon,
          fill: filled ? 1 : 0,
          size: 13,
          color: filled ? color : context.colors.hairlineStrong,
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 44, color: color);
}
