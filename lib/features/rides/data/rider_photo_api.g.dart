// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_photo_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(riderPhotoApi)
final riderPhotoApiProvider = RiderPhotoApiProvider._();

final class RiderPhotoApiProvider
    extends $FunctionalProvider<RiderPhotoApi, RiderPhotoApi, RiderPhotoApi>
    with $Provider<RiderPhotoApi> {
  RiderPhotoApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'riderPhotoApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riderPhotoApiHash();

  @$internal
  @override
  $ProviderElement<RiderPhotoApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RiderPhotoApi create(Ref ref) {
    return riderPhotoApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RiderPhotoApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RiderPhotoApi>(value),
    );
  }
}

String _$riderPhotoApiHash() => r'e16cbb91c96a7c65490a1fff56a9db89855eed7f';
