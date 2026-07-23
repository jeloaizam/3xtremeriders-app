import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../l10n/gen/app_localizations.dart';

/// The empty "insert cartridge" slot at the end of the favorites row —
/// tapping it opens the arcade sport picker. Dashed outline so it reads as
/// an empty slot rather than another filled/glowing sport button.
class AddSportButton extends StatefulWidget {
  const AddSportButton({super.key, required this.onTap, this.size = 76});

  final VoidCallback onTap;
  final double size;

  @override
  State<AddSportButton> createState() => _AddSportButtonState();
}

class _AddSportButtonState extends State<AddSportButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      width: widget.size + 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: widget.size + 16,
            height: widget.size + 16,
            child: Center(
              child: GestureDetector(
                onTap: widget.onTap,
                onTapDown: (_) => setState(() => _pressed = true),
                onTapUp: (_) => setState(() => _pressed = false),
                onTapCancel: () => setState(() => _pressed = false),
                child: AnimatedScale(
                  scale: _pressed ? 0.9 : 1,
                  duration: const Duration(milliseconds: 110),
                  curve: Curves.easeOut,
                  child: CustomPaint(
                    painter: _DashedBorderPainter(
                      color: _pressed ? colors.colorAction : colors.text500,
                      radius: context.spacing.radiusLg,
                    ),
                    child: SizedBox(
                      width: widget.size,
                      height: widget.size,
                      child: Icon(
                        Symbols.add,
                        size: widget.size * 0.4,
                        color: _pressed ? colors.colorAction : colors.text500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.settingsFavoriteSportsAdd.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.typography.tag.copyWith(color: colors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    final path = Path()..addRRect(rrect);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    const dashWidth = 6.0;
    const gapWidth = 5.0;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + gapWidth;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.radius != radius;
}
