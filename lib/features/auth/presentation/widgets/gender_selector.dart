import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/alien_icon.dart';
import '../../../../l10n/gen/app_localizations.dart';

/// Write-once gender picker shared by `SignupScreen` and
/// `CompleteProfileScreen` — three big buttons instead of a dropdown/segment,
/// since there's no way to correct a misclick later (the backend rejects any
/// PATCH that tries to change an already-set gender).
class GenderSelector extends StatelessWidget {
  const GenderSelector({
    super.key,
    required this.value,
    required this.locked,
    required this.onChanged,
    this.showError = false,
  });

  final String? value;
  final bool locked;
  final ValueChanged<String> onChanged;
  final bool showError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.completeProfileGenderLabel,
          style: context.typography.eyebrow.copyWith(color: colors.textMuted),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _GenderButton(
                icon: Symbols.male,
                label: l10n.genderMale,
                selected: value == 'male',
                locked: locked,
                onTap: () => onChanged('male'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _GenderButton(
                icon: Symbols.female,
                label: l10n.genderFemale,
                selected: value == 'female',
                locked: locked,
                onTap: () => onChanged('female'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _GenderButton(
                iconWidget: AlienIcon.new,
                label: l10n.genderAlien,
                selected: value == 'alien',
                locked: locked,
                onTap: () => onChanged('alien'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          l10n.completeProfileGenderWarning,
          style: context.typography.micro.copyWith(color: colors.textMuted),
        ),
        if (showError && value == null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              l10n.signupFieldRequired,
              style: context.typography.micro.copyWith(
                color: colors.colorDanger,
              ),
            ),
          ),
      ],
    );
  }
}

/// One of the three gender buttons — big enough to tap easily, since this is
/// a write-once choice with no dropdown/segmented affordance to correct a
/// misclick later. Dims and stops responding to taps once [locked] (a gender
/// was already saved before this screen loaded).
class _GenderButton extends StatelessWidget {
  const _GenderButton({
    this.icon,
    this.iconWidget,
    required this.label,
    required this.selected,
    required this.locked,
    required this.onTap,
  }) : assert(icon != null || iconWidget != null);

  final IconData? icon;
  // Builds a glyph with no Material Symbol (just AlienIcon today), given
  // this button's selection-tinted color — not GenderVisual's fixed
  // per-gender color, since this icon is recolored by selection state.
  final Widget Function({required double size, required Color color})?
  iconWidget;
  final String label;
  final bool selected;
  final bool locked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = selected ? colors.colorAction : colors.text300;
    final builder = iconWidget;

    return Opacity(
      opacity: locked && !selected ? .4 : 1,
      child: GestureDetector(
        onTap: locked ? null : onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: selected ? colors.tintBlue : colors.surfaceCard,
            border: Border.all(
              color: selected ? colors.colorAction : colors.hairline,
              width: selected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(context.spacing.radiusMd),
          ),
          child: Column(
            children: [
              builder == null
                  ? Icon(icon, size: 32, color: color)
                  : builder(size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                label,
                style: context.typography.title.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
