// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_hazard_rating_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(spotHazardRatingApi)
final spotHazardRatingApiProvider = SpotHazardRatingApiProvider._();

final class SpotHazardRatingApiProvider
    extends
        $FunctionalProvider<
          SpotHazardRatingApi,
          SpotHazardRatingApi,
          SpotHazardRatingApi
        >
    with $Provider<SpotHazardRatingApi> {
  SpotHazardRatingApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotHazardRatingApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotHazardRatingApiHash();

  @$internal
  @override
  $ProviderElement<SpotHazardRatingApi> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SpotHazardRatingApi create(Ref ref) {
    return spotHazardRatingApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotHazardRatingApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotHazardRatingApi>(value),
    );
  }
}

String _$spotHazardRatingApiHash() =>
    r'81e8edf04f858eea460a0d501725f009b7cba787';
