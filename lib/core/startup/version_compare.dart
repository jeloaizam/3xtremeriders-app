/// True when [current] (e.g. `pubspec.yaml`'s `version:`, read via
/// `package_info_plus`) is strictly below [minimum] (`min_app_version` from
/// `GET /version`). Compares major.minor.patch only — the `+build` suffix
/// (if any) is ignored, same convention as the rest of the app's versioning.
bool isVersionOlderThan(String current, String minimum) {
  final c = _parse(current);
  final m = _parse(minimum);
  for (var i = 0; i < 3; i++) {
    final cv = i < c.length ? c[i] : 0;
    final mv = i < m.length ? m[i] : 0;
    if (cv != mv) return cv < mv;
  }
  return false;
}

List<int> _parse(String version) =>
    version.split('+').first.split('.').map(int.parse).toList();
