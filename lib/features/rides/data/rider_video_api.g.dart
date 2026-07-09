// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_video_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(riderVideoApi)
final riderVideoApiProvider = RiderVideoApiProvider._();

final class RiderVideoApiProvider
    extends $FunctionalProvider<RiderVideoApi, RiderVideoApi, RiderVideoApi>
    with $Provider<RiderVideoApi> {
  RiderVideoApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'riderVideoApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riderVideoApiHash();

  @$internal
  @override
  $ProviderElement<RiderVideoApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RiderVideoApi create(Ref ref) {
    return riderVideoApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RiderVideoApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RiderVideoApi>(value),
    );
  }
}

String _$riderVideoApiHash() => r'f0d972d6d7a144b504c572f0cd6dfd4fceca21d6';
