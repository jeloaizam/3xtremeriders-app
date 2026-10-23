import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import 'sanitized_text_formatter.dart';

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
    this.maxLength,
    this.extraVerticalPadding = 0,
    this.onChanged,
    this.enabled = true,
    this.inputFormatters,
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
  /// Hard cap enforced client-side (mirrors the backend schema's
  /// `max_length` for the same field) — the real limit is always the
  /// backend's; this just gives immediate feedback and matches it.
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  /// Extra formatters on top of the sanitizer every field always gets.
  final List<TextInputFormatter>? inputFormatters;

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
              maxLength: maxLength,
              // La sanitización no aplica a contraseñas: no son contenido
              // que vaya a la BD/pantalla de otro rider, y filtrar
              // caracteres cambiaría silenciosamente la contraseña real.
              inputFormatters: [
                if (!obscureText) SanitizedTextInputFormatter(),
                ...?inputFormatters,
              ],
              onChanged: onChanged,
              enabled: enabled,
              style: context.typography.body.copyWith(color: colors.text100),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: context.typography.body.copyWith(
                  color: colors.textMuted,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                counterText: '',
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
