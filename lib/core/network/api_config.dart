import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

/// Backend base URL.
///
/// Defaults to local-dev addressing (see below), but a build can point
/// anywhere else — e.g. the production API — by passing `API_BASE_URL` via
/// `--dart-define`/`--dart-define-from-file` (same mechanism already used
/// for `MAPBOX_TOKEN`, see `dart_define.example.json`). No trailing slash.
///
/// Local-dev default: a physical Android device can't reach the host
/// machine via `127.0.0.1` (that's the phone's own loopback) — it needs the
/// host's actual LAN IP, with both devices on the same network. `10.0.2.2`
/// only works for the Android *emulator* (its alias for the host loopback
/// interface); swap back to that if you switch from a physical device to an
/// emulator. Web and iOS simulator share the host network, so `127.0.0.1`
/// works there.
class ApiConfig {
  ApiConfig._();

  static const _hostLanIp = '192.168.2.11';
  static const _override = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl {
    if (_override.isNotEmpty) return _override;
    if (kIsWeb) return 'http://127.0.0.1:8000';
    if (Platform.isAndroid) return 'http://$_hostLanIp:8000';
    return 'http://127.0.0.1:8000';
  }
}
