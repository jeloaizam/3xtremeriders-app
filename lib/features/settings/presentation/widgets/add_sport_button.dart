import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/sport_badge_shape.dart';
import '../../../../l10n/gen/app_localizations.dart';

/// The empty "insert cartridge" slot at the end of the favorites row —
/// tapping it opens the arcade sport picker. Dashed hexagon outline (same
/// silhouette as [SportBadgePainter]) so it reads as an empty badge slot
/// rather than another filled/glowing sport button.
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
                    painter: DashedSportBadgePainter(
                      color: _pressed ? colors.colorAction : colors.text500,
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
