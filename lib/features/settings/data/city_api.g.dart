// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cityApi)
final cityApiProvider = CityApiProvider._();

final class CityApiProvider
    extends $FunctionalProvider<CityApi, CityApi, CityApi>
    with $Provider<CityApi> {
  CityApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cityApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cityApiHash();

  @$internal
  @override
  $ProviderElement<CityApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CityApi create(Ref ref) {
    return cityApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CityApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CityApi>(value),
    );
  }
}

String _$cityApiHash() => r'bc97b9fef355f3e209889ad4f5269748f6bd7f90';

/// A country's city catalog, keyed by country id — only the countries
/// seeded in the `city` migration have any rows; the rest return an empty
/// list, which the city dropdown just renders as no options.

@ProviderFor(cities)
final citiesProvider = CitiesFamily._();

/// A country's city catalog, keyed by country id — only the countries
/// seeded in the `city` migration have any rows; the rest return an empty
/// list, which the city dropdown just renders as no options.

final class CitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<City>>,
          List<City>,
          FutureOr<List<City>>
        >
    with $FutureModifier<List<City>>, $FutureProvider<List<City>> {
  /// A country's city catalog, keyed by country id — only the countries
  /// seeded in the `city` migration have any rows; the rest return an empty
  /// list, which the city dropdown just renders as no options.
  CitiesProvider._({
    required CitiesFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'citiesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$citiesHash();

  @override
  String toString() {
    return r'citiesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<City>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<City>> create(Ref ref) {
    final argument = this.argument as int;
    return cities(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CitiesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$citiesHash() => r'8653b64966422bcaf6211bd1629849fad4192175';

/// A country's city catalog, keyed by country id — only the countries
/// seeded in the `city` migration have any rows; the rest return an empty
/// list, which the city dropdown just renders as no options.

final class CitiesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<City>>, int> {
  CitiesFamily._()
    : super(
        retry: null,
        name: r'citiesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A country's city catalog, keyed by country id — only the countries
  /// seeded in the `city` migration have any rows; the rest return an empty
  /// list, which the city dropdown just renders as no options.

  CitiesProvider call(int countryId) =>
      CitiesProvider._(argument: countryId, from: this);

  @override
  String toString() => r'citiesProvider';
}
