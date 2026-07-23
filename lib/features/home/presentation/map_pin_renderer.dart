import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Rasterizes map pin icons into PNG bytes for Mapbox's
/// `PointAnnotationOptions.image` — there's no live widget tree to grab a
/// `RenderRepaintBoundary` from at annotation-creation time, so this paints
/// directly onto a `Canvas`/`PictureRecorder` instead, using the same
/// technique `Icon` itself uses internally (the glyph is just a character
/// in the icon font, painted via `TextPainter` with the `IconData`'s own
/// `fontFamily`/`fontPackage`).
///
/// Results are cached by a key describing their exact visual inputs, since
/// the same sport (or sport combo) repeats across many spots on the map.
class MapPinRenderer {
  MapPinRenderer._();

  static final Map<String, Uint8List> _cache = {};

  /// A single sport's pin — a colored circular badge with that sport's icon.
  static Future<Uint8List> singleSport({
    required IconData icon,
    required Color color,
    required Color bgColor,
    double size = 108,
  }) {
    final key =
        'single_${icon.codePoint}_${color.toARGB32()}_${bgColor.toARGB32()}_$size';
    return _cached(key, () => _renderSingle(icon, color, bgColor, size));
  }

  /// A "featured spot" badge for spots with 2+ sports — shows up to 3 mini
  /// icons in a cluster, with a "+N" overflow mark beyond that.
  static Future<Uint8List> multiSportBadge({
    required List<IconData> icons,
    required List<Color> iconColors,
    required Color badgeColor,
    required Color bgColor,
    int overflowCount = 0,
    double size = 124,
  }) {
    final key =
        'multi_${icons.map((i) => i.codePoint).join(',')}_'
        '${badgeColor.toARGB32()}_${overflowCount}_$size';
    return _cached(
      key,
      () => _renderMulti(
        icons,
        iconColors,
        badgeColor,
        bgColor,
        overflowCount,
        size,
      ),
    );
  }

  /// Fallback for spots with no sport tagged (only possible for spots
  /// published before sport selection became mandatory).
  static Future<Uint8List> genericPin({
    required Color color,
    required Color borderColor,
    double size = 76,
  }) {
    final key = 'generic_${color.toARGB32()}_${borderColor.toARGB32()}_$size';
    return _cached(key, () => _renderGeneric(color, borderColor, size));
  }

  static Future<Uint8List> _cached(
    String key,
    Future<Uint8List> Function() render,
  ) async {
    final cached = _cache[key];
    if (cached != null) return cached;
    final bytes = await render();
    _cache[key] = bytes;
    return bytes;
  }

  static Future<Uint8List> _toPngBytes(
    ui.PictureRecorder recorder,
    double size,
  ) async {
    final picture = recorder.endRecording();
    final image = await picture.toImage(size.round(), size.round());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  static void _paintGlyph(
    Canvas canvas,
    IconData icon,
    Offset center,
    double fontSize,
    Color color,
  ) {
    final painter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: color,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
  }

  static Future<Uint8List> _renderSingle(
    IconData icon,
    Color color,
    Color bgColor,
    double size,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final center = Offset(size / 2, size / 2);
    final radius = size / 2 - size * 0.045;

    canvas.drawCircle(center, radius, Paint()..color = bgColor);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = size * 0.045,
    );
    _paintGlyph(canvas, icon, center, size * 0.5, color);

    return _toPngBytes(recorder, size);
  }

  static Future<Uint8List> _renderGeneric(
    Color color,
    Color borderColor,
    double size,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final center = Offset(size / 2, size / 2);
    final radius = size / 2 - size * 0.05;

    canvas.drawCircle(center, radius, Paint()..color = color);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = size * 0.05,
    );

    return _toPngBytes(recorder, size);
  }

  static Future<Uint8List> _renderMulti(
    List<IconData> icons,
    List<Color> iconColors,
    Color badgeColor,
    Color bgColor,
    int overflowCount,
    double size,
  ) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final center = Offset(size / 2, size / 2);
    final radius = size / 2 - size * 0.04;

    canvas.drawCircle(center, radius, Paint()..color = bgColor);
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = badgeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = size * 0.045,
    );

    final miniSize = size * 0.26;
    final offset = size * 0.15;
    final positions = switch (icons.length) {
      1 => [center],
      2 => [center + Offset(-offset, 0), center + Offset(offset, 0)],
      _ => [
        center + Offset(0, -offset * 0.95),
        center + Offset(-offset, offset * 0.7),
        center + Offset(offset, offset * 0.7),
      ],
    };
    for (var i = 0; i < icons.length && i < positions.length; i++) {
      _paintGlyph(canvas, icons[i], positions[i], miniSize, iconColors[i]);
    }

    if (overflowCount > 0) {
      final painter = TextPainter(
        text: TextSpan(
          text: '+$overflowCount',
          style: TextStyle(
            fontSize: size * 0.15,
            fontWeight: FontWeight.w700,
            color: badgeColor,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(
        canvas,
        Offset(
          size - painter.width - size * 0.08,
          size - painter.height - size * 0.06,
        ),
      );
    }

    return _toPngBytes(recorder, size);
  }
}
