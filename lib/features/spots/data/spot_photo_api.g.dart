// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_photo_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(spotPhotoApi)
final spotPhotoApiProvider = SpotPhotoApiProvider._();

final class SpotPhotoApiProvider
    extends $FunctionalProvider<SpotPhotoApi, SpotPhotoApi, SpotPhotoApi>
    with $Provider<SpotPhotoApi> {
  SpotPhotoApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotPhotoApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotPhotoApiHash();

  @$internal
  @override
  $ProviderElement<SpotPhotoApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SpotPhotoApi create(Ref ref) {
    return spotPhotoApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotPhotoApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotPhotoApi>(value),
    );
  }
}

String _$spotPhotoApiHash() => r'b90746b6682e612ac5afff08b316dc6c37c5c203';
