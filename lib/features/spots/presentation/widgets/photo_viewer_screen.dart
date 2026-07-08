import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Full-screen view of a single spot photo, opened from the media gallery
/// or the media library grid — mirrors [VideoPlayerScreen]'s full-screen
/// dialog pattern but for a static image.
class PhotoViewerScreen extends StatelessWidget {
  const PhotoViewerScreen({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            url,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Symbols.broken_image,
              color: Colors.white54,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }
}
