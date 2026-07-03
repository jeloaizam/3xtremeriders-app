import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Text field with optional leading/trailing icons.
/// Mirrors `components/core/TextField.jsx` from the design system.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.placeholder,
    this.icon,
    this.trailingIcon,
    this.onTrailingTap,
    this.obscureText = false,
    this.keyboardType,
  });

  final TextEditingController? controller;
  final String? placeholder;
  final IconData? icon;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairlineStrong),
        borderRadius: BorderRadius.circular(spacing.radiusMd),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: colors.textMuted),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: context.typography.body.copyWith(color: colors.text100),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: context.typography.body.copyWith(
                  color: colors.textMuted,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (trailingIcon != null) ...[
            const SizedBox(width: 10),
            GestureDetector(
              onTap: onTrailingTap,
              child: Icon(trailingIcon, size: 19, color: colors.textMuted),
            ),
          ],
        ],
      ),
    );
  }
}
