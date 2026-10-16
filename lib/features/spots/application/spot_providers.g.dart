// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Real spots near the user, fetched from `GET /spots`.

@ProviderFor(nearbySpots)
final nearbySpotsProvider = NearbySpotsProvider._();

/// Real spots near the user, fetched from `GET /spots`.

final class NearbySpotsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Spot>>,
          List<Spot>,
          FutureOr<List<Spot>>
        >
    with $FutureModifier<List<Spot>>, $FutureProvider<List<Spot>> {
  /// Real spots near the user, fetched from `GET /spots`.
  NearbySpotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbySpotsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbySpotsHash();

  @$internal
  @override
  $FutureProviderElement<List<Spot>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Spot>> create(Ref ref) {
    return nearbySpots(ref);
  }
}

String _$nearbySpotsHash() => r'4b54ada159cfd154fda1571f8b6714e8e3196afd';

/// Search results for the Search screen's Spots tab, re-fetched from the
/// backend on every filter change (live filtering, no separate "apply"
/// step). See [SearchQuery].

@ProviderFor(searchSpots)
final searchSpotsProvider = SearchSpotsFamily._();

/// Search results for the Search screen's Spots tab, re-fetched from the
/// backend on every filter change (live filtering, no separate "apply"
/// step). See [SearchQuery].

final class SearchSpotsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Spot>>,
          List<Spot>,
          FutureOr<List<Spot>>
        >
    with $FutureModifier<List<Spot>>, $FutureProvider<List<Spot>> {
  /// Search results for the Search screen's Spots tab, re-fetched from the
  /// backend on every filter change (live filtering, no separate "apply"
  /// step). See [SearchQuery].
  SearchSpotsProvider._({
    required SearchSpotsFamily super.from,
    required SearchQuery super.argument,
  }) : super(
         retry: null,
         name: r'searchSpotsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchSpotsHash();

  @override
  String toString() {
    return r'searchSpotsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Spot>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Spot>> create(Ref ref) {
    final argument = this.argument as SearchQuery;
    return searchSpots(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchSpotsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchSpotsHash() => r'089db487d2419f1f13b4f9728f6dcd02ce180aee';

/// Search results for the Search screen's Spots tab, re-fetched from the
/// backend on every filter change (live filtering, no separate "apply"
/// step). See [SearchQuery].

final class SearchSpotsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Spot>>, SearchQuery> {
  SearchSpotsFamily._()
    : super(
        retry: null,
        name: r'searchSpotsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Search results for the Search screen's Spots tab, re-fetched from the
  /// backend on every filter change (live filtering, no separate "apply"
  /// step). See [SearchQuery].

  SearchSpotsProvider call(SearchQuery query) =>
      SearchSpotsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchSpotsProvider';
}

/// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
/// spotId so Home's list and the Spot detail screen share one fetch.
///
/// keepAlive: without it, this (and the other small per-spot providers
/// below) gets disposed the instant nothing is watching it even for a
/// single frame — which happened during scroll on the Spot screen's media
/// gallery (a nested widget watching it independently of the parent's
/// `spotDetailProvider` watch), making it silently refetch and show fewer
/// items right after the fetch, then the full list again once it resolved.

@ProviderFor(spotSports)
final spotSportsProvider = SpotSportsFamily._();

/// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
/// spotId so Home's list and the Spot detail screen share one fetch.
///
/// keepAlive: without it, this (and the other small per-spot providers
/// below) gets disposed the instant nothing is watching it even for a
/// single frame — which happened during scroll on the Spot screen's media
/// gallery (a nested widget watching it independently of the parent's
/// `spotDetailProvider` watch), making it silently refetch and show fewer
/// items right after the fetch, then the full list again once it resolved.

final class SpotSportsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Sport>>,
          List<Sport>,
          FutureOr<List<Sport>>
        >
    with $FutureModifier<List<Sport>>, $FutureProvider<List<Sport>> {
  /// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
  /// spotId so Home's list and the Spot detail screen share one fetch.
  ///
  /// keepAlive: without it, this (and the other small per-spot providers
  /// below) gets disposed the instant nothing is watching it even for a
  /// single frame — which happened during scroll on the Spot screen's media
  /// gallery (a nested widget watching it independently of the parent's
  /// `spotDetailProvider` watch), making it silently refetch and show fewer
  /// items right after the fetch, then the full list again once it resolved.
  SpotSportsProvider._({
    required SpotSportsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'spotSportsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotSportsHash();

  @override
  String toString() {
    return r'spotSportsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Sport>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Sport>> create(Ref ref) {
    final argument = this.argument as int;
    return spotSports(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotSportsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotSportsHash() => r'8a02aed8eef6e797f666ffe65808df6ba51b3e8a';

/// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
/// spotId so Home's list and the Spot detail screen share one fetch.
///
/// keepAlive: without it, this (and the other small per-spot providers
/// below) gets disposed the instant nothing is watching it even for a
/// single frame — which happened during scroll on the Spot screen's media
/// gallery (a nested widget watching it independently of the parent's
/// `spotDetailProvider` watch), making it silently refetch and show fewer
/// items right after the fetch, then the full list again once it resolved.

final class SpotSportsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Sport>>, int> {
  SpotSportsFamily._()
    : super(
        retry: null,
        name: r'spotSportsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
  /// spotId so Home's list and the Spot detail screen share one fetch.
  ///
  /// keepAlive: without it, this (and the other small per-spot providers
  /// below) gets disposed the instant nothing is watching it even for a
  /// single frame — which happened during scroll on the Spot screen's media
  /// gallery (a nested widget watching it independently of the parent's
  /// `spotDetailProvider` watch), making it silently refetch and show fewer
  /// items right after the fetch, then the full list again once it resolved.

  SpotSportsProvider call(int spotId) =>
      SpotSportsProvider._(argument: spotId, from: this);

  @override
  String toString() => r'spotSportsProvider';
}
