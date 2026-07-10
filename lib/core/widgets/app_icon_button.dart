import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// 42px square icon button. Use [chrome] when floating over media/maps.
/// Mirrors `components/core/IconButton.jsx` from the design system.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.chrome = false,
    this.active = false,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool chrome;
  final bool active;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final background = active
        ? colors.colorAction
        : chrome
        ? colors.scrimSoft
        : colors.surfaceCard;
    final borderColor = chrome ? colors.hairlineStrong : colors.hairline;
    final iconColor = active ? colors.colorOnAction : (color ?? colors.text100);

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: context.spacing.iconBtn,
          height: context.spacing.iconBtn,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 21, color: iconColor),
        ),
      ),
    );
  }
}
