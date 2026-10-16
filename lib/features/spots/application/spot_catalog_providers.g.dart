// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_catalog_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The full sport catalog (not scoped to a spot) — used by the "create
/// spot" screen's sport picker.

@ProviderFor(allSports)
final allSportsProvider = AllSportsProvider._();

/// The full sport catalog (not scoped to a spot) — used by the "create
/// spot" screen's sport picker.

final class AllSportsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Sport>>,
          List<Sport>,
          FutureOr<List<Sport>>
        >
    with $FutureModifier<List<Sport>>, $FutureProvider<List<Sport>> {
  /// The full sport catalog (not scoped to a spot) — used by the "create
  /// spot" screen's sport picker.
  AllSportsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allSportsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allSportsHash();

  @$internal
  @override
  $FutureProviderElement<List<Sport>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Sport>> create(Ref ref) {
    return allSports(ref);
  }
}

String _$allSportsHash() => r'082e57463780b421add94881b9e0a3f280fd82e3';

/// The fixed 4-row spot category catalog — used by the admin-only category
/// picker on Create/Edit Spot.

@ProviderFor(allSpotCategories)
final allSpotCategoriesProvider = AllSpotCategoriesProvider._();

/// The fixed 4-row spot category catalog — used by the admin-only category
/// picker on Create/Edit Spot.

final class AllSpotCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpotCategory>>,
          List<SpotCategory>,
          FutureOr<List<SpotCategory>>
        >
    with
        $FutureModifier<List<SpotCategory>>,
        $FutureProvider<List<SpotCategory>> {
  /// The fixed 4-row spot category catalog — used by the admin-only category
  /// picker on Create/Edit Spot.
  AllSpotCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allSpotCategoriesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allSpotCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<SpotCategory>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpotCategory>> create(Ref ref) {
    return allSpotCategories(ref);
  }
}

String _$allSpotCategoriesHash() => r'c0c92ffc75e87c4988e04e4e408de2cbe9b387b5';
