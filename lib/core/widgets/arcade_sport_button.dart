import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../features/spots/domain/sport.dart';
import '../../features/spots/presentation/sport_visuals.dart';
import '../theme/app_theme.dart';
import 'sport_badge_shape.dart';

/// A single "arcade cabinet button" for a sport — big glowing icon tile with
/// its name printed below, like a character-select screen. Shared across
/// the favorite-sports picker (Settings) and the active-sport picker
/// (Home) — rank/remove badges for the former, `selected` for the latter.
///
/// The icon tile itself (not the label) does the pressing — `AnimatedScale`
/// shrinks it on tap-down for a physical "push the button" feel, released
/// on tap-up/cancel.
class ArcadeSportButton extends StatefulWidget {
  const ArcadeSportButton({
    super.key,
    required this.sport,
    this.onTap,
    this.rank,
    this.locked = false,
    this.onRemove,
    this.selected = false,
    this.busy = false,
    this.size = 76,
  });

  final Sport sport;
  final VoidCallback? onTap;

  /// 1-based favorite position, shown as a small numeral badge — null in
  /// the picker grid, where sports aren't ranked yet.
  final int? rank;

  /// True if this favorite can't be removed (rider has spots published
  /// with it) — swaps the remove badge for a lock icon that only explains
  /// why, instead of removing.
  final bool locked;

  /// Null hides the remove badge entirely (picker grid mode).
  final VoidCallback? onRemove;

  /// True marks this as the rider's current pick in a single-select
  /// picker (e.g. the active-sport picker) — shows a check badge instead
  /// of the rank/remove ones.
  final bool selected;

  /// Shows a spinner over the icon instead of the icon itself (e.g. while
  /// an add/remove request is in flight).
  final bool busy;

  final double size;

  @override
  State<ArcadeSportButton> createState() => _ArcadeSportButtonState();
}

class _ArcadeSportButtonState extends State<ArcadeSportButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visual = SportVisual.of(widget.sport.name, colors);
    final showRankOrRemove = widget.rank != null || widget.onRemove != null;

    return SizedBox(
      width: widget.size + 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            // Extra room around the tile so rank/remove badges can sit
            // half-outside its corners without being clipped.
            width: widget.size + 16,
            height: widget.size + 16,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onTap: widget.onTap,
                  onTapDown: (_) => _setPressed(true),
                  onTapUp: (_) => _setPressed(false),
                  onTapCancel: () => _setPressed(false),
                  child: AnimatedScale(
                    scale: _pressed ? 0.9 : 1,
                    duration: const Duration(milliseconds: 110),
                    curve: Curves.easeOut,
                    child: SizedBox(
                      width: widget.size,
                      height: widget.size,
                      child: CustomPaint(
                        painter: SportBadgePainter(
                          gradientColors: [
                            visual.color,
                            Color.lerp(visual.color, Colors.black, .4)!,
                          ],
                          borderColor: widget.selected
                              ? colors.colorAction
                              : colors.text100,
                        ),
                        child: Center(
                          child: widget.busy
                              ? SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.4,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  visual.icon,
                                  size: widget.size * 0.4,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (showRankOrRemove && widget.rank != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _Badge(
                      color: colors.colorAction,
                      child: Text(
                        '${widget.rank}',
                        style: context.typography.numeral.copyWith(
                          fontSize: 12,
                          color: colors.colorOnAction,
                        ),
                      ),
                    ),
                  ),
                if (showRankOrRemove && widget.onRemove != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: _Badge(
                      color: widget.locked
                          ? colors.surface600
                          : colors.colorDanger,
                      onTap: widget.onRemove,
                      child: Icon(
                        widget.locked ? Symbols.lock : Symbols.close,
                        size: 13,
                        color: widget.locked ? colors.textMuted : colors.bg850,
                      ),
                    ),
                  ),
                if (!showRankOrRemove && widget.selected)
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: _Badge(
                      color: colors.colorAction,
                      child: Icon(
                        Symbols.check,
                        size: 13,
                        color: colors.colorOnAction,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            widget.sport.name.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.typography.tag.copyWith(color: colors.text100),
          ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.color, required this.child, this.onTap});

  final Color color;
  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final badge = Container(
      width: 22,
      height: 22,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: context.colors.bg850, width: 2),
      ),
      child: child,
    );
    if (onTap == null) return badge;
    return GestureDetector(onTap: onTap, child: badge);
  }
}
