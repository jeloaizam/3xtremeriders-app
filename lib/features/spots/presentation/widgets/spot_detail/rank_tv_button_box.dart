import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../../core/widgets/app_icon_button.dart';
import '../../../../../l10n/gen/app_localizations.dart';
import 'rank_category.dart';

/// 4 icon-only buttons (General/Hombres/Mujeres/Alien) selecting which
/// ranking category feeds `RankTvBox` above `SeparatorBox` — the mockup's
/// `RankTvButtonBox`. Icon-only per product decision (no text labels).
class RankTvButtonBox extends StatelessWidget {
  const RankTvButtonBox({
    super.key,
    required this.active,
    required this.onPick,
  });

  final RankCategory active;
  final void Function(RankCategory category) onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: _Button(
            icon: Symbols.grid_view,
            label: l10n.spotMediaRankingGeneral,
            active: active == RankCategory.general,
            onTap: () => onPick(RankCategory.general),
          ),
        ),
        const SizedBox(width: 8),
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
            icon: Symbols.rocket_launch,
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
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      button: true,
      child: AppIconButton(icon: icon, active: active, onPressed: onTap),
    );
  }
}
