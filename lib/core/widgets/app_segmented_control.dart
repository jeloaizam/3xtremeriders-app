import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppSegment<T> {
  const AppSegment({required this.value, required this.label});

  final T value;
  final String label;
}

/// Segmented control: 2–4 short options, one active (yellow).
/// Mirrors `components/core/SegmentedControl.jsx` from the design system.
class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.segments,
    required this.value,
    this.onChanged,
  });

  final List<AppSegment<T>> segments;
  final T value;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.bg850,
        borderRadius: BorderRadius.circular(context.spacing.radiusMd),
        border: Border.all(color: colors.hairline),
      ),
      child: Row(
        children: [
          for (final segment in segments)
            Expanded(
              child: GestureDetector(
                onTap: onChanged == null
                    ? null
                    : () => onChanged!(segment.value),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 11,
                  ),
                  decoration: BoxDecoration(
                    color: segment.value == value
                        ? colors.colorAction
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    segment.label,
                    style: context.typography.label.copyWith(
                      fontSize: 12,
                      letterSpacing: 12 * 0.02,
                      color: segment.value == value
                          ? colors.colorOnAction
                          : colors.textMuted,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
