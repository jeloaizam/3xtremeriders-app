import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../core/widgets/alien_icon.dart';
import '../../../../../core/widgets/app_icon_button.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import 'rank_category.dart';

/// Icon-only buttons selecting which ranking category feeds `RankTvBox`
/// above `SeparatorBox` — the mockup's `RankTvButtonBox`. Hombres/Mujeres/
/// Alien always show; General only shows when [showGeneral] is true —
/// 'xtremespot' spots never had a browsable general library (same flag as
/// `RankTvBox.hasGeneralLibrary`), so that category isn't pickable there.
class RankTvButtonBox extends StatelessWidget {
  const RankTvButtonBox({
    super.key,
    required this.active,
    required this.showGeneral,
    required this.onPick,
  });

  final RankCategory active;
  final bool showGeneral;
  final void Function(RankCategory category) onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        if (showGeneral) ...[
          Expanded(
            child: _Button(
              icon: Symbols.grid_view,
              label: l10n.spotMediaRankingGeneral,
              active: active == RankCategory.general,
              onTap: () => onPick(RankCategory.general),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: _Button(
            icon: Symbols.male,
            label: l10n.spotMediaRankingMale,
            active: active == RankCategory.men,
            onTap: () => onPick(RankCategory.men),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _Button(
            icon: Symbols.female,
            label: l10n.spotMediaRankingFemale,
            active: active == RankCategory.women,
            onTap: () => onPick(RankCategory.women),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _Button(
            iconWidget: AlienIcon.new,
            label: l10n.spotMediaRankingAlien,
            active: active == RankCategory.alien,
            onTap: () => onPick(RankCategory.alien),
          ),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    this.icon,
    this.iconWidget,
    required this.label,
    required this.active,
    required this.onTap,
  }) : assert(icon != null || iconWidget != null);

  final IconData? icon;
  // Builds a glyph with no Material Symbol (just AlienIcon today), given
  // the same size/color AppIconButton would've used for a plain IconData.
  final Widget Function({required double size, required Color color})?
  iconWidget;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final builder = iconWidget;
    final resolvedIconWidget = builder == null
        ? null
        : builder(
            size: 21,
            color: active ? colors.colorOnAction : colors.text100,
          );

    return Semantics(
      label: label,
      button: true,
      child: AppIconButton(
        icon: icon,
        iconWidget: resolvedIconWidget,
        active: active,
        onPressed: onTap,
      ),
    );
  }
}
