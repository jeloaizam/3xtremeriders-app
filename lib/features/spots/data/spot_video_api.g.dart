// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_video_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(spotVideoApi)
final spotVideoApiProvider = SpotVideoApiProvider._();

final class SpotVideoApiProvider
    extends $FunctionalProvider<SpotVideoApi, SpotVideoApi, SpotVideoApi>
    with $Provider<SpotVideoApi> {
  SpotVideoApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotVideoApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotVideoApiHash();

  @$internal
  @override
  $ProviderElement<SpotVideoApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SpotVideoApi create(Ref ref) {
    return spotVideoApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotVideoApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotVideoApi>(value),
    );
  }
}

String _$spotVideoApiHash() => r'b7fedd32d49003b7b7418224991e4884afdfc508';
