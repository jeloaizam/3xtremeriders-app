import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../theme/app_theme.dart';

/// Square checkbox for one-time agreements (legal consent) — distinct from
/// [AppSwitch], which is an iOS-style toggle meant for persistent settings,
/// not for a single yes/no acceptance.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({super.key, required this.checked, this.onChanged});

  final bool checked;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onChanged == null ? null : () => onChanged!(!checked),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          color: checked ? colors.colorAction : Colors.transparent,
          border: Border.all(
            color: checked ? colors.colorAction : colors.hairlineStrong,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(context.spacing.radiusXs),
        ),
        child: checked
            ? Icon(Symbols.check, size: 16, color: colors.bg850)
            : null,
      ),
    );
  }
}
