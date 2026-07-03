import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Backend base URL for local development.
///
/// The Android emulator can't reach the host machine via `127.0.0.1` —
/// `10.0.2.2` is the emulator's alias for the host loopback interface.
/// Web and iOS simulator share the host network, so `127.0.0.1` works there.
/// This will need a real production URL once the backend is deployed.
class ApiConfig {
  ApiConfig._();

  static String get baseUrl {
    if (kIsWeb) return 'http://127.0.0.1:8000';
    if (Platform.isAndroid) return 'http://10.0.2.2:8000';
    return 'http://127.0.0.1:8000';
  }
}
