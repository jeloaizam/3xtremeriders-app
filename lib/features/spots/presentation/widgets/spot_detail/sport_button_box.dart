import 'package:flutter/material.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../domain/sport.dart';
import '../../sport_visuals.dart';

/// Horizontal, scrollable, icon-only row of the spot's sports — purely
/// informational (no `onTap`, no selection state): the approved mockup
/// shows these as decoration, not a filter.
class SportButtonBox extends StatelessWidget {
  const SportButtonBox({super.key, required this.sports});

  final List<Sport> sports;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    if (sports.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 86,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sports.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final sport = sports[index];
          final visual = SportVisual.of(sport.name, colors);
          return Semantics(
            label: sport.name,
            child: SizedBox(
              width: 68,
              child: Column(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: colors.surfaceCard,
                      border: Border.all(color: colors.hairline),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: Icon(visual.icon, size: 22, color: visual.color),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sport.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: context.typography.micro.copyWith(height: 1.15),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
