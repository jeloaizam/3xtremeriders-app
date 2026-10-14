import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_theme.dart';
import '../../../../../../l10n/gen/app_localizations.dart';
import '../../../../domain/spot_element.dart';
import '../../../sport_visuals.dart';

/// `MoreInfoBox`'s "Elementos" tab: the spot's physical elements (rampas,
/// half-pipes, rieles…) with a difficulty dot row each.
class ElementsTab extends StatelessWidget {
  const ElementsTab({super.key, required this.elements});

  final List<SpotElement> elements;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.spotElementsTitle(elements.length),
            style: context.typography.tag.copyWith(color: colors.text300),
          ),
          const SizedBox(height: 12),
          if (elements.isEmpty)
            Text(l10n.spotNoElements, style: context.typography.bodySm)
          else
            for (final element in elements) _ElementRow(element: element),
        ],
      ),
    );
  }
}

class _ElementRow extends StatelessWidget {
  const _ElementRow({required this.element});

  final SpotElement element;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final difficulty = element.difficulty ?? 0;

    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colors.surfaceCard,
          border: Border.all(color: colors.hairline),
          borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colors.tintInfo,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Icon(
                elementIcon(element.type),
                size: 20,
                color: colors.colorBrand,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    element.name,
                    style: context.typography.title.copyWith(height: 1),
                  ),
                  if (element.type != null) ...[
                    const SizedBox(height: 4),
                    Text(element.type!, style: context.typography.micro),
                  ],
                ],
              ),
            ),
            Row(
              children: [
                for (var i = 1; i <= 5; i++)
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(left: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i <= difficulty
                          ? colors.colorBrand
                          : colors.hairlineStrong,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
