// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sportApi)
final sportApiProvider = SportApiProvider._();

final class SportApiProvider
    extends $FunctionalProvider<SportApi, SportApi, SportApi>
    with $Provider<SportApi> {
  SportApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sportApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sportApiHash();

  @$internal
  @override
  $ProviderElement<SportApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SportApi create(Ref ref) {
    return sportApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SportApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SportApi>(value),
    );
  }
}

String _$sportApiHash() => r'4e073544704ae401d23352b5a472cd7303209f27';
