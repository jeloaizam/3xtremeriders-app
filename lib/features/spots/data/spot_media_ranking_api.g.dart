// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_media_ranking_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(spotMediaRankingApi)
final spotMediaRankingApiProvider = SpotMediaRankingApiProvider._();

final class SpotMediaRankingApiProvider
    extends
        $FunctionalProvider<
          SpotMediaRankingApi,
          SpotMediaRankingApi,
          SpotMediaRankingApi
        >
    with $Provider<SpotMediaRankingApi> {
  SpotMediaRankingApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotMediaRankingApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotMediaRankingApiHash();

  @$internal
  @override
  $ProviderElement<SpotMediaRankingApi> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SpotMediaRankingApi create(Ref ref) {
    return spotMediaRankingApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotMediaRankingApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotMediaRankingApi>(value),
    );
  }
}

String _$spotMediaRankingApiHash() =>
    r'a08a34a07cd7d2a0d84384d47f4175d773ab4d55';

/// A spot's media-by-gender ranking — not `keepAlive`: unlike
/// `spotDetailProvider`, this doesn't need to survive brief listener gaps,
/// and votes on individual photos/videos happen from *other* screens
/// (photo detail, video player) that invalidate this by spotId on change.

@ProviderFor(spotMediaRanking)
final spotMediaRankingProvider = SpotMediaRankingFamily._();

/// A spot's media-by-gender ranking — not `keepAlive`: unlike
/// `spotDetailProvider`, this doesn't need to survive brief listener gaps,
/// and votes on individual photos/videos happen from *other* screens
/// (photo detail, video player) that invalidate this by spotId on change.

final class SpotMediaRankingProvider
    extends
        $FunctionalProvider<
          AsyncValue<SpotMediaRanking>,
          SpotMediaRanking,
          FutureOr<SpotMediaRanking>
        >
    with $FutureModifier<SpotMediaRanking>, $FutureProvider<SpotMediaRanking> {
  /// A spot's media-by-gender ranking — not `keepAlive`: unlike
  /// `spotDetailProvider`, this doesn't need to survive brief listener gaps,
  /// and votes on individual photos/videos happen from *other* screens
  /// (photo detail, video player) that invalidate this by spotId on change.
  SpotMediaRankingProvider._({
    required SpotMediaRankingFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'spotMediaRankingProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotMediaRankingHash();

  @override
  String toString() {
    return r'spotMediaRankingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SpotMediaRanking> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SpotMediaRanking> create(Ref ref) {
    final argument = this.argument as int;
    return spotMediaRanking(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotMediaRankingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotMediaRankingHash() => r'a8b66c721be4bd5d2e7ce1b1be54eabd2d32e961';

/// A spot's media-by-gender ranking — not `keepAlive`: unlike
/// `spotDetailProvider`, this doesn't need to survive brief listener gaps,
/// and votes on individual photos/videos happen from *other* screens
/// (photo detail, video player) that invalidate this by spotId on change.

final class SpotMediaRankingFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SpotMediaRanking>, int> {
  SpotMediaRankingFamily._()
    : super(
        retry: null,
        name: r'spotMediaRankingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A spot's media-by-gender ranking — not `keepAlive`: unlike
  /// `spotDetailProvider`, this doesn't need to survive brief listener gaps,
  /// and votes on individual photos/videos happen from *other* screens
  /// (photo detail, video player) that invalidate this by spotId on change.

  SpotMediaRankingProvider call(int spotId) =>
      SpotMediaRankingProvider._(argument: spotId, from: this);

  @override
  String toString() => r'spotMediaRankingProvider';
}
