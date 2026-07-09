// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_search_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Search results for the Search screen's Riders tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.

@ProviderFor(searchRiders)
final searchRidersProvider = SearchRidersFamily._();

/// Search results for the Search screen's Riders tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.

final class SearchRidersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Rider>>,
          List<Rider>,
          FutureOr<List<Rider>>
        >
    with $FutureModifier<List<Rider>>, $FutureProvider<List<Rider>> {
  /// Search results for the Search screen's Riders tab. Only `q` and the
  /// sport filter apply here — the rest of [SearchQuery] (difficulty,
  /// season, hazard, distance) is spot-specific and ignored.
  SearchRidersProvider._({
    required SearchRidersFamily super.from,
    required SearchQuery super.argument,
  }) : super(
         retry: null,
         name: r'searchRidersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchRidersHash();

  @override
  String toString() {
    return r'searchRidersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Rider>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Rider>> create(Ref ref) {
    final argument = this.argument as SearchQuery;
    return searchRiders(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchRidersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchRidersHash() => r'1271d23037773a94b6e4fdc9eac651f7ef65e6de';

/// Search results for the Search screen's Riders tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.

final class SearchRidersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Rider>>, SearchQuery> {
  SearchRidersFamily._()
    : super(
        retry: null,
        name: r'searchRidersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Search results for the Search screen's Riders tab. Only `q` and the
  /// sport filter apply here — the rest of [SearchQuery] (difficulty,
  /// season, hazard, distance) is spot-specific and ignored.

  SearchRidersProvider call(SearchQuery query) =>
      SearchRidersProvider._(argument: query, from: this);

  @override
  String toString() => r'searchRidersProvider';
}
