// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(riderApi)
final riderApiProvider = RiderApiProvider._();

final class RiderApiProvider
    extends $FunctionalProvider<RiderApi, RiderApi, RiderApi>
    with $Provider<RiderApi> {
  RiderApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'riderApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$riderApiHash();

  @$internal
  @override
  $ProviderElement<RiderApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RiderApi create(Ref ref) {
    return riderApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RiderApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RiderApi>(value),
    );
  }
}

String _$riderApiHash() => r'f2e2d69996ade078c34c049b3a8ea201480cdd5a';
