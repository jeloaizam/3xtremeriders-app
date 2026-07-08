// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(storageApi)
final storageApiProvider = StorageApiProvider._();

final class StorageApiProvider
    extends $FunctionalProvider<StorageApi, StorageApi, StorageApi>
    with $Provider<StorageApi> {
  StorageApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'storageApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$storageApiHash();

  @$internal
  @override
  $ProviderElement<StorageApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  StorageApi create(Ref ref) {
    return storageApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StorageApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StorageApi>(value),
    );
  }
}

String _$storageApiHash() => r'23282e5e9aea0f2ff54cb19bbd90c0a25e6f3ace';
