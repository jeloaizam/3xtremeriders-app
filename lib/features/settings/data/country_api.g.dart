// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(countryApi)
final countryApiProvider = CountryApiProvider._();

final class CountryApiProvider
    extends $FunctionalProvider<CountryApi, CountryApi, CountryApi>
    with $Provider<CountryApi> {
  CountryApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countryApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countryApiHash();

  @$internal
  @override
  $ProviderElement<CountryApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CountryApi create(Ref ref) {
    return countryApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CountryApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CountryApi>(value),
    );
  }
}

String _$countryApiHash() => r'66303da67b6ec3a09699d8851625e92155cd7f3d';

/// The full country catalog, fetched once. Static reference data — kept
/// alive for the app's lifetime rather than refetched on every visit to
/// Settings.

@ProviderFor(countries)
final countriesProvider = CountriesProvider._();

/// The full country catalog, fetched once. Static reference data — kept
/// alive for the app's lifetime rather than refetched on every visit to
/// Settings.

final class CountriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Country>>,
          List<Country>,
          FutureOr<List<Country>>
        >
    with $FutureModifier<List<Country>>, $FutureProvider<List<Country>> {
  /// The full country catalog, fetched once. Static reference data — kept
  /// alive for the app's lifetime rather than refetched on every visit to
  /// Settings.
  CountriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'countriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$countriesHash();

  @$internal
  @override
  $FutureProviderElement<List<Country>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Country>> create(Ref ref) {
    return countries(ref);
  }
}

String _$countriesHash() => r'81b78697fe3bddda7d7c1ce55aee720ec59112fe';
