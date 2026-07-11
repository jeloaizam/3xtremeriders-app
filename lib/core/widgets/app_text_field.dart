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
    this.multiline = false,
    this.maxLines,
    this.extraVerticalPadding = 0,
  });

  final TextEditingController? controller;
  final String? placeholder;
  final IconData? icon;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool multiline;
  final int? maxLines;

  /// Added on top of the field's normal (intrinsic) height, split evenly
  /// top/bottom — e.g. 10 makes the field 10px taller overall.
  final double extraVerticalPadding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final spacing = context.spacing;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14 + extraVerticalPadding / 2,
      ),
      constraints: multiline ? const BoxConstraints(minHeight: 74) : null,
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        border: Border.all(color: colors.hairlineStrong),
        borderRadius: BorderRadius.circular(spacing.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: multiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: colors.textMuted),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: multiline ? TextInputType.multiline : keyboardType,
              minLines: multiline ? 3 : 1,
              maxLines: maxLines ?? (multiline ? 6 : 1),
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
