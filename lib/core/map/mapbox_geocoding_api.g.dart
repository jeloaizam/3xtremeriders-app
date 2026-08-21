// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mapbox_geocoding_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mapboxGeocodingApi)
final mapboxGeocodingApiProvider = MapboxGeocodingApiProvider._();

final class MapboxGeocodingApiProvider
    extends
        $FunctionalProvider<
          MapboxGeocodingApi,
          MapboxGeocodingApi,
          MapboxGeocodingApi
        >
    with $Provider<MapboxGeocodingApi> {
  MapboxGeocodingApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapboxGeocodingApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapboxGeocodingApiHash();

  @$internal
  @override
  $ProviderElement<MapboxGeocodingApi> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MapboxGeocodingApi create(Ref ref) {
    return mapboxGeocodingApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapboxGeocodingApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapboxGeocodingApi>(value),
    );
  }
}

String _$mapboxGeocodingApiHash() =>
    r'ab6ee900f02b41ee2db15d5ec5318abec2d5929a';
