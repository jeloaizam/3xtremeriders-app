import 'package:flutter/material.dart';

/// A minimal "grey alien" head glyph — round cranium tapering to a chin,
/// two almond eyes cut out of the silhouette — standing in for the
/// 'alien' gender everywhere `Symbols.rocket_launch` used to (Material
/// Symbols has no actual alien icon). Sized/colored like a normal [Icon]
/// so it drops into the same slots.
class AlienIcon extends StatelessWidget {
  const AlienIcon({super.key, this.size = 24, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _AlienPainter(color));
  }
}

class _AlienPainter extends CustomPainter {
  _AlienPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 24);

    final head = Path()
      ..moveTo(12, 3)
      ..cubicTo(18.5, 3, 22, 8, 21, 13)
      ..cubicTo(20.3, 17.5, 16, 21, 12, 21)
      ..cubicTo(8, 21, 3.7, 17.5, 3, 13)
      ..cubicTo(2, 8, 5.5, 3, 12, 3)
      ..close();

    final eyes = Path()
      ..addOval(Rect.fromCenter(center: const Offset(8.4, 11.2), width: 4.2, height: 6.2))
      ..addOval(Rect.fromCenter(center: const Offset(15.6, 11.2), width: 4.2, height: 6.2));

    canvas.drawPath(
      Path.combine(PathOperation.difference, head, eyes),
      Paint()..color = color,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _AlienPainter oldDelegate) =>
      oldDelegate.color != color;
}
