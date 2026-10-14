import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../l10n/gen/app_localizations.dart';
import '../../../../domain/hazzard.dart';

/// `MoreInfoBox`'s "Peligros" tab: the spot's named hazard reports — the
/// community "muletas" hazard rating now lives in `InfoRatingBox` instead,
/// so this tab is purely the named list.
class HazardsTab extends StatelessWidget {
  const HazardsTab({super.key, required this.hazzards});

  final List<Hazzard> hazzards;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.spotHazardsTitle(hazzards.length),
            style: context.typography.tag.copyWith(color: colors.text300),
          ),
          const SizedBox(height: 12),
          if (hazzards.isEmpty)
            Text(l10n.spotNoHazards, style: context.typography.bodySm)
          else
            for (final hazzard in hazzards) _HazzardRow(hazzard: hazzard),
        ],
      ),
    );
  }
}

class _HazzardRow extends StatelessWidget {
  const _HazzardRow({required this.hazzard});

  final Hazzard hazzard;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final severity = hazzard.severity ?? 1;
    final (Color color, Color background, Color border) = severity <= 2
        ? (
            colors.colorRating,
            colors.tintRating,
            colors.colorRating.withValues(alpha: .28),
          )
        : severity == 3
        ? (
            colors.colorWarn,
            colors.tintWarn,
            colors.colorWarn.withValues(alpha: .28),
          )
        : (
            colors.colorDanger,
            colors.tintDanger,
            colors.colorDanger.withValues(alpha: .28),
          );

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: background,
          border: Border.all(color: border),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Symbols.warning, size: 22, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hazzard.name,
                    style: context.typography.title.copyWith(height: 1),
                  ),
                  if (hazzard.description != null) ...[
                    const SizedBox(height: 4),
                    Text(hazzard.description!, style: context.typography.micro),
                  ],
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .25),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                'SEV $severity',
                style: context.typography.tag.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
