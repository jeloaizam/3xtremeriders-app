// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Search results for the Search screen's Eventos tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.

@ProviderFor(searchEvents)
final searchEventsProvider = SearchEventsFamily._();

/// Search results for the Search screen's Eventos tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.

final class SearchEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Event>>,
          List<Event>,
          FutureOr<List<Event>>
        >
    with $FutureModifier<List<Event>>, $FutureProvider<List<Event>> {
  /// Search results for the Search screen's Eventos tab. Only `q` and the
  /// sport filter apply here — the rest of [SearchQuery] (difficulty,
  /// season, hazard, distance) is spot-specific and ignored.
  SearchEventsProvider._({
    required SearchEventsFamily super.from,
    required SearchQuery super.argument,
  }) : super(
         retry: null,
         name: r'searchEventsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchEventsHash();

  @override
  String toString() {
    return r'searchEventsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Event>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Event>> create(Ref ref) {
    final argument = this.argument as SearchQuery;
    return searchEvents(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchEventsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchEventsHash() => r'66aa88f9c015d5dae5f20524681958529d5b0d8b';

/// Search results for the Search screen's Eventos tab. Only `q` and the
/// sport filter apply here — the rest of [SearchQuery] (difficulty,
/// season, hazard, distance) is spot-specific and ignored.

final class SearchEventsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Event>>, SearchQuery> {
  SearchEventsFamily._()
    : super(
        retry: null,
        name: r'searchEventsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Search results for the Search screen's Eventos tab. Only `q` and the
  /// sport filter apply here — the rest of [SearchQuery] (difficulty,
  /// season, hazard, distance) is spot-specific and ignored.

  SearchEventsProvider call(SearchQuery query) =>
      SearchEventsProvider._(argument: query, from: this);

  @override
  String toString() => r'searchEventsProvider';
}
