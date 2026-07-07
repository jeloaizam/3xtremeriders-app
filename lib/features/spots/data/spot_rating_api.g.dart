// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_rating_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(spotRatingApi)
final spotRatingApiProvider = SpotRatingApiProvider._();

final class SpotRatingApiProvider
    extends $FunctionalProvider<SpotRatingApi, SpotRatingApi, SpotRatingApi>
    with $Provider<SpotRatingApi> {
  SpotRatingApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotRatingApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotRatingApiHash();

  @$internal
  @override
  $ProviderElement<SpotRatingApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SpotRatingApi create(Ref ref) {
    return spotRatingApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotRatingApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotRatingApi>(value),
    );
  }
}

String _$spotRatingApiHash() => r'25559796e1235c7c322020b23d8c097bbc4fd5f4';
