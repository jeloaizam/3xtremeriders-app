import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Select field styled like [AppTextField] — no direct design source
/// component for this, built to match the same container/typography.
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.items,
    required this.value,
    this.onChanged,
    this.placeholder,
    this.icon,
    this.extraVerticalPadding = 0,
  });

  final List<DropdownMenuItem<T>> items;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final String? placeholder;
  final IconData? icon;

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
        vertical: extraVerticalPadding / 2,
      ),
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
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<T>(
                initialValue: value,
                items: items,
                onChanged: onChanged,
                isExpanded: true,
                icon: Icon(
                  Icons.expand_more,
                  color: colors.textMuted,
                  size: 20,
                ),
                dropdownColor: colors.surfaceCard,
                style: context.typography.body.copyWith(color: colors.text100),
                hint: placeholder == null
                    ? null
                    : Text(
                        placeholder!,
                        style: context.typography.body.copyWith(
                          color: colors.textMuted,
                        ),
                      ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
