/// Mapbox public access token (client-side, safe to embed by Mapbox's own
/// design — but GitHub's push protection flags any Mapbox token pattern
/// regardless of prefix, so it's passed at build time instead of committed:
/// `flutter run --dart-define-from-file=dart_define.local.json`
/// (see dart_define.example.json for the expected shape; the local file
/// is gitignored).
const mapboxAccessToken = String.fromEnvironment('MAPBOX_TOKEN');
