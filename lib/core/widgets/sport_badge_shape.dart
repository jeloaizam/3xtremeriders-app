import 'package:flutter/material.dart';

/// The angular hexagon badge silhouette used for sport icons — mirroring
/// the Persona-5-style "insignia" reference the user shared (bold outline,
/// sticker-style badge popped off the background). Deliberately irregular
/// (no two opposite vertices mirror each other exactly) so it reads as a
/// hand-cut sticker rather than a perfectly symmetric hexagon.
Path sportBadgeHexagonPath(Size size) {
  final w = size.width;
  final h = size.height;
  return Path()
    ..moveTo(w * 0.24, h * 0.02)
    ..lineTo(w * 0.70, 0)
    ..lineTo(w * 0.98, h * 0.42)
    ..lineTo(w * 0.76, h)
    ..lineTo(w * 0.22, h * 0.97)
    ..lineTo(w * 0.02, h * 0.55)
    ..close();
}

/// Paints the badge: a hard-edged (unblurred) offset shadow for that
/// "sticker popped off the page" look, a diagonal gradient fill, and a
/// thick outline — all following [sportBadgeHexagonPath] rather than the
/// widget's rectangular bounds.
class SportBadgePainter extends CustomPainter {
  const SportBadgePainter({
    required this.gradientColors,
    required this.borderColor,
    this.shadowColor = const Color(0x73000000),
    this.shadowOffset = const Offset(3, 4),
  });

  final List<Color> gradientColors;
  final Color borderColor;
  final Color shadowColor;
  final Offset shadowOffset;

  @override
  void paint(Canvas canvas, Size size) {
    final path = sportBadgeHexagonPath(size);

    canvas.save();
    canvas.translate(shadowOffset.dx, shadowOffset.dy);
    canvas.drawPath(path, Paint()..color = shadowColor);
    canvas.restore();

    final rect = Offset.zero & size;
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ).createShader(rect),
    );

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round
        ..strokeWidth = size.width * 0.07
        ..color = borderColor,
    );
  }

  @override
  bool shouldRepaint(covariant SportBadgePainter oldDelegate) =>
      oldDelegate.gradientColors != gradientColors ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.shadowColor != shadowColor ||
      oldDelegate.shadowOffset != shadowOffset;
}

/// Dashes the same hexagon outline — used by the "add a sport" empty slot
/// so it reads as an unfilled badge instead of a filled one.
class DashedSportBadgePainter extends CustomPainter {
  const DashedSportBadgePainter({
    required this.color,
    this.dashWidth = 6,
    this.gapWidth = 5,
  });

  final Color color;
  final double dashWidth;
  final double gapWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final path = sportBadgeHexagonPath(size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.045;

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
  bool shouldRepaint(covariant DashedSportBadgePainter oldDelegate) =>
      oldDelegate.color != color;
}
