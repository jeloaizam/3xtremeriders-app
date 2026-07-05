import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Backend base URL for local development.
///
/// A physical Android device can't reach the host machine via `127.0.0.1`
/// (that's the phone's own loopback) — it needs the host's actual LAN IP,
/// with both devices on the same network. `10.0.2.2` only works for the
/// Android *emulator* (its alias for the host loopback interface); swap
/// back to that if you switch from a physical device to an emulator.
/// Web and iOS simulator share the host network, so `127.0.0.1` works there.
/// This will need a real production URL once the backend is deployed.
class ApiConfig {
  ApiConfig._();

  static const _hostLanIp = '192.168.2.11';

  static String get baseUrl {
    if (kIsWeb) return 'http://127.0.0.1:8000';
    if (Platform.isAndroid) return 'http://$_hostLanIp:8000';
    return 'http://127.0.0.1:8000';
  }
}
