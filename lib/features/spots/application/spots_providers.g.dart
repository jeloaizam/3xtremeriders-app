// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spots_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Mock spots for now — swap the body for a real `/spot` API call when that
/// endpoint is wired up.

@ProviderFor(nearbySpots)
final nearbySpotsProvider = NearbySpotsProvider._();

/// Mock spots for now — swap the body for a real `/spot` API call when that
/// endpoint is wired up.

final class NearbySpotsProvider
    extends $FunctionalProvider<List<Spot>, List<Spot>, List<Spot>>
    with $Provider<List<Spot>> {
  /// Mock spots for now — swap the body for a real `/spot` API call when that
  /// endpoint is wired up.
  NearbySpotsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nearbySpotsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nearbySpotsHash();

  @$internal
  @override
  $ProviderElement<List<Spot>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Spot> create(Ref ref) {
    return nearbySpots(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Spot> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Spot>>(value),
    );
  }
}

String _$nearbySpotsHash() => r'3612bee801e92ad837d2180830eeba4599051228';
