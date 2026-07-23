import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppBottomNavItem {
  const AppBottomNavItem({
    required this.id,
    required this.icon,
    required this.label,
    this.enableDoubleTap = false,
  });

  final String id;
  final IconData icon;
  final String label;

  /// Wires `InkWell.onDoubleTap` for just this item — left off (the
  /// default) for every other item so they stay snappy single-tap, since
  /// InkWell's tap-vs-double-tap disambiguation adds a short delay only to
  /// items that actually listen for a double tap.
  final bool enableDoubleTap;
}

/// Fixed bottom tab bar. Active item glows yellow.
/// Mirrors `components/spots/BottomNav.jsx` from the design system.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    required this.active,
    this.onSelect,
    this.onDoubleTap,
  });

  final List<AppBottomNavItem> items;
  final String active;
  final ValueChanged<String>? onSelect;

  /// Only fires for items with `enableDoubleTap: true`.
  final ValueChanged<String>? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: context.spacing.navHeight,
      padding: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: colors.surfaceNav,
        border: Border(top: BorderSide(color: colors.hairlineSoft)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final item in items)
            _NavButton(
              item: item,
              isActive: item.id == active,
              onTap: () => onSelect?.call(item.id),
              onDoubleTap: item.enableDoubleTap
                  ? () => onDoubleTap?.call(item.id)
                  : null,
            ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
    this.onDoubleTap,
  });

  final AppBottomNavItem item;
  final bool isActive;
  final VoidCallback onTap;
  final VoidCallback? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = isActive ? colors.colorAction : colors.textMuted;

    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: context.typography.tag.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
