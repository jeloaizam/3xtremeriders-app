// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hazzard_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hazzardApi)
final hazzardApiProvider = HazzardApiProvider._();

final class HazzardApiProvider
    extends $FunctionalProvider<HazzardApi, HazzardApi, HazzardApi>
    with $Provider<HazzardApi> {
  HazzardApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hazzardApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hazzardApiHash();

  @$internal
  @override
  $ProviderElement<HazzardApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  HazzardApi create(Ref ref) {
    return hazzardApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HazzardApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HazzardApi>(value),
    );
  }
}

String _$hazzardApiHash() => r'8f71eae432eca8236aa3cc2fa0210d34a45c2571';
