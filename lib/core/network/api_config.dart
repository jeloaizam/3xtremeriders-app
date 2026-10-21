/// Backend base URL.
///
/// Defaults to the deployed production API — no local dev server to keep
/// running, no LAN IP to keep in sync with DHCP (that mismatch caused the
/// "no se ven los spots" bug three separate times before this). To point a
/// build at a local backend instead, pass `API_BASE_URL` via
/// `--dart-define`/`--dart-define-from-file` (same mechanism already used
/// for `MAPBOX_TOKEN`, see `dart_define.example.json`), e.g.
/// `http://<host-lan-ip>:8000` for a physical Android device (it can't
/// reach the host via `127.0.0.1`, that's the phone's own loopback) or
/// `http://10.0.2.2:8000` for the Android emulator. No trailing slash.
class ApiConfig {
  ApiConfig._();

  static const _prodUrl = 'https://api.3xtremeriders.com';
  static const _override = String.fromEnvironment('API_BASE_URL');

  static String get baseUrl => _override.isNotEmpty ? _override : _prodUrl;
}
