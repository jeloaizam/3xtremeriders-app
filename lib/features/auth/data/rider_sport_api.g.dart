// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_sport_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(riderSportApi)
final riderSportApiProvider = RiderSportApiProvider._();

final class RiderSportApiProvider
    extends $FunctionalProvider<RiderSportApi, RiderSportApi, RiderSportApi>
    with $Provider<RiderSportApi> {
  RiderSportApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'riderSportApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riderSportApiHash();

  @$internal
  @override
  $ProviderElement<RiderSportApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RiderSportApi create(Ref ref) {
    return riderSportApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RiderSportApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RiderSportApi>(value),
    );
  }
}

String _$riderSportApiHash() => r'90ff3107fa91e63bd3aeb3d4306b23d9e4540ce6';
