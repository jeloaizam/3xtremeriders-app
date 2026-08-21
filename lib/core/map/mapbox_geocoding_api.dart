import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'mapbox_config.dart';

part 'mapbox_geocoding_api.g.dart';

/// A place resolved from Mapbox's Geocoding API — either by reverse
/// geocoding a lat/lng (Create/Edit Spot) or by text search (the Rider
/// profile's city field). `countryIsoCode` is what the backend actually
/// keys off of (`Country.iso_code`) — see `crud_city.resolve_or_create` on
/// the backend, which creates the City row on demand if this exact name
/// hasn't been seen yet for that country.
class GeocodedPlace {
  const GeocodedPlace({
    required this.cityName,
    required this.countryName,
    required this.countryIsoCode,
  });

  final String cityName;
  final String countryName;
  final String countryIsoCode;
}

/// Talks to Mapbox's Geocoding API v5 (`mapbox.places`) — same public token
/// already used for the map itself (`mapboxAccessToken`), no extra secret.
class MapboxGeocodingApi {
  static const _base = 'https://api.mapbox.com/geocoding/v5/mapbox.places';

  /// Resolves lat/lng to the city/country it falls in — used right after a
  /// spot's location is set (GPS fix or pin drag) so city/country are
  /// captured automatically instead of asking the rider to type them.
  Future<GeocodedPlace?> reverse(double latitude, double longitude) async {
    final uri = Uri.parse(
      '$_base/$longitude,$latitude.json'
      '?types=place&access_token=$mapboxAccessToken',
    );
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) return null;
    final features = _features(response.body);
    if (features.isEmpty) return null;
    return _parseFeature(features.first as Map<String, dynamic>);
  }

  /// Autocomplete search-as-you-type, optionally scoped to a country (the
  /// Rider profile's city field, once a country is already chosen) —
  /// returns Mapbox's own suggestions rather than free text, so whatever
  /// gets picked is always a canonical, consistently-spelled name.
  Future<List<GeocodedPlace>> search(
    String query, {
    String? countryIsoCode,
  }) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return [];

    final uri = Uri.parse('$_base/${Uri.encodeComponent(trimmed)}.json')
        .replace(
          queryParameters: {
            'types': 'place',
            'autocomplete': 'true',
            'access_token': mapboxAccessToken,
            if (countryIsoCode != null) 'country': countryIsoCode.toLowerCase(),
          },
        );
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) return [];

    return _features(response.body)
        .map((f) => _parseFeature(f as Map<String, dynamic>))
        .whereType<GeocodedPlace>()
        .toList();
  }

  List<dynamic> _features(String body) {
    final data = jsonDecode(body) as Map<String, dynamic>;
    return data['features'] as List<dynamic>? ?? const [];
  }

  /// A `place` feature's own `context` array carries its parent
  /// region/country entries — the country one is whichever id starts with
  /// `country.`. A feature with no such entry (e.g. reverse-geocoding a
  /// point out at sea) is discarded rather than guessed at.
  GeocodedPlace? _parseFeature(Map<String, dynamic> feature) {
    final cityName = feature['text'] as String?;
    final context = feature['context'] as List<dynamic>? ?? const [];

    Map<String, dynamic>? countryEntry;
    for (final entry in context) {
      final map = entry as Map<String, dynamic>;
      if ((map['id'] as String? ?? '').startsWith('country.')) {
        countryEntry = map;
        break;
      }
    }
    if (cityName == null || countryEntry == null) return null;

    final isoCode = countryEntry['short_code'] as String?;
    final countryName = countryEntry['text'] as String?;
    if (isoCode == null || countryName == null) return null;

    return GeocodedPlace(
      cityName: cityName,
      countryName: countryName,
      countryIsoCode: isoCode,
    );
  }
}

@riverpod
MapboxGeocodingApi mapboxGeocodingApi(Ref ref) => MapboxGeocodingApi();
