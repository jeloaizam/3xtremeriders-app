// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rideApi)
final rideApiProvider = RideApiProvider._();

final class RideApiProvider
    extends $FunctionalProvider<RideApi, RideApi, RideApi>
    with $Provider<RideApi> {
  RideApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideApiHash();

  @$internal
  @override
  $ProviderElement<RideApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RideApi create(Ref ref) {
    return rideApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RideApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RideApi>(value),
    );
  }
}

String _$rideApiHash() => r'42ad5faf4532123b52a5ed25f0b22fd8c1e72ba9';
