// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_detail_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Everything the Sport detail screen needs, fetched in parallel: the sport
/// itself, its top riders/spots/photos/videos, and its events — mirrors
/// `eventDetailProvider`'s parallel-fetch pattern (`events_providers.dart`).

@ProviderFor(sportDetail)
final sportDetailProvider = SportDetailFamily._();

/// Everything the Sport detail screen needs, fetched in parallel: the sport
/// itself, its top riders/spots/photos/videos, and its events — mirrors
/// `eventDetailProvider`'s parallel-fetch pattern (`events_providers.dart`).

final class SportDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<SportDetailData>,
          SportDetailData,
          FutureOr<SportDetailData>
        >
    with $FutureModifier<SportDetailData>, $FutureProvider<SportDetailData> {
  /// Everything the Sport detail screen needs, fetched in parallel: the sport
  /// itself, its top riders/spots/photos/videos, and its events — mirrors
  /// `eventDetailProvider`'s parallel-fetch pattern (`events_providers.dart`).
  SportDetailProvider._({
    required SportDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'sportDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sportDetailHash();

  @override
  String toString() {
    return r'sportDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SportDetailData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SportDetailData> create(Ref ref) {
    final argument = this.argument as int;
    return sportDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SportDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sportDetailHash() => r'87ecbf96e50a0aee16a4cc22d27af37f31f30cc0';

/// Everything the Sport detail screen needs, fetched in parallel: the sport
/// itself, its top riders/spots/photos/videos, and its events — mirrors
/// `eventDetailProvider`'s parallel-fetch pattern (`events_providers.dart`).

final class SportDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SportDetailData>, int> {
  SportDetailFamily._()
    : super(
        retry: null,
        name: r'sportDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Everything the Sport detail screen needs, fetched in parallel: the sport
  /// itself, its top riders/spots/photos/videos, and its events — mirrors
  /// `eventDetailProvider`'s parallel-fetch pattern (`events_providers.dart`).

  SportDetailProvider call(int sportId) =>
      SportDetailProvider._(argument: sportId, from: this);

  @override
  String toString() => r'sportDetailProvider';
}
