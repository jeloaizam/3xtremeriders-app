import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_theme.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

enum AppButtonSize { lg, md }

/// Primary call-to-action button. Oswald, uppercase, radius-lg.
/// Mirrors `components/core/Button.jsx` from the design system.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.lg,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;
    final disabled = onPressed == null;

    final Color background;
    final Color foreground;
    final Color borderColor;
    switch (variant) {
      case AppButtonVariant.primary:
        background = colors.colorAction;
        foreground = colors.colorOnAction;
        borderColor = Colors.transparent;
      case AppButtonVariant.secondary:
        background = colors.surfaceCard;
        foreground = colors.text100;
        borderColor = colors.hairline;
      case AppButtonVariant.ghost:
        background = Colors.transparent;
        foreground = colors.text300;
        borderColor = colors.hairlineStrong;
      case AppButtonVariant.danger:
        background = colors.tintDanger;
        foreground = colors.colorDanger;
        borderColor = colors.colorDanger.withValues(alpha: .35);
    }

    final height = size == AppButtonSize.lg
        ? spacing.controlH
        : spacing.controlHSm;
    final fontSize = size == AppButtonSize.lg ? 16.0 : 15.0;

    return Opacity(
      opacity: disabled ? 0.45 : 1,
      child: SizedBox(
        width: fullWidth ? double.infinity : null,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: background,
            foregroundColor: foreground,
            disabledBackgroundColor: background,
            disabledForegroundColor: foreground,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(spacing.radiusLg),
              side: BorderSide(color: borderColor),
            ),
          ),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.oswald(
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
              letterSpacing: fontSize * 0.06,
            ),
          ),
        ),
      ),
    );
  }
}
