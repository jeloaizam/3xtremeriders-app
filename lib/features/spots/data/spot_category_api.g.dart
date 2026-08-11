// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_category_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(spotCategoryApi)
final spotCategoryApiProvider = SpotCategoryApiProvider._();

final class SpotCategoryApiProvider
    extends
        $FunctionalProvider<SpotCategoryApi, SpotCategoryApi, SpotCategoryApi>
    with $Provider<SpotCategoryApi> {
  SpotCategoryApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotCategoryApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotCategoryApiHash();

  @$internal
  @override
  $ProviderElement<SpotCategoryApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SpotCategoryApi create(Ref ref) {
    return spotCategoryApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotCategoryApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotCategoryApi>(value),
    );
  }
}

String _$spotCategoryApiHash() => r'80dbc75e8296c488a5a7f938e74a865f6e4a8304';
