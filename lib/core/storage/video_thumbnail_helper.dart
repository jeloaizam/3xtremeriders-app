import 'package:fc_native_video_thumbnail/fc_native_video_thumbnail.dart';
import 'package:path_provider/path_provider.dart';

/// Grabs a JPEG still from a local video file's first frame, for use as a
/// gallery thumbnail — spot videos otherwise have nothing to show but a
/// flat placeholder with a play icon. Returns the generated file's local
/// path, or null if generation fails (e.g. an unsupported codec); callers
/// should just skip attaching a thumbnail in that case rather than block
/// the video upload itself on it.
Future<String?> generateVideoThumbnail(String videoPath) async {
  try {
    final tempDir = await getTemporaryDirectory();
    final destFile =
        '${tempDir.path}/thumb_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ok = await FcNativeVideoThumbnail().saveThumbnailToFile(
      srcFile: videoPath,
      destFile: destFile,
      width: 480,
      height: 480,
      quality: 75,
    );
    return ok ? destFile : null;
  } catch (_) {
    return null;
  }
}
