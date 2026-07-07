// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(spotApi)
final spotApiProvider = SpotApiProvider._();

final class SpotApiProvider
    extends $FunctionalProvider<SpotApi, SpotApi, SpotApi>
    with $Provider<SpotApi> {
  SpotApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotApiHash();

  @$internal
  @override
  $ProviderElement<SpotApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SpotApi create(Ref ref) {
    return spotApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotApi>(value),
    );
  }
}

String _$spotApiHash() => r'503e7d26593abb051c456c745774c4f06c43c6c7';
