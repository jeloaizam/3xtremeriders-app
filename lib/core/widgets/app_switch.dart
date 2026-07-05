import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// iOS-style toggle. On = yellow track, dark knob (right).
/// Mirrors `components/core/Switch.jsx` from the design system.
class AppSwitch extends StatelessWidget {
  const AppSwitch({super.key, required this.checked, this.onChanged});

  final bool checked;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: onChanged == null ? null : () => onChanged!(!checked),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 26,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: checked ? colors.colorAction : const Color(0xFF2A2F3A),
          borderRadius: BorderRadius.circular(context.spacing.radiusPill),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: checked ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: checked ? colors.bg850 : const Color(0xFF6B7280),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
