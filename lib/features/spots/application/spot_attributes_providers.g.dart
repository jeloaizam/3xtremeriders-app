// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_attributes_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A spot's hazards — cached per spotId so Home's map quick-view sheet and
/// the Spot detail screen share one fetch.

@ProviderFor(spotHazzards)
final spotHazzardsProvider = SpotHazzardsFamily._();

/// A spot's hazards — cached per spotId so Home's map quick-view sheet and
/// the Spot detail screen share one fetch.

final class SpotHazzardsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Hazzard>>,
          List<Hazzard>,
          FutureOr<List<Hazzard>>
        >
    with $FutureModifier<List<Hazzard>>, $FutureProvider<List<Hazzard>> {
  /// A spot's hazards — cached per spotId so Home's map quick-view sheet and
  /// the Spot detail screen share one fetch.
  SpotHazzardsProvider._({
    required SpotHazzardsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'spotHazzardsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotHazzardsHash();

  @override
  String toString() {
    return r'spotHazzardsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Hazzard>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Hazzard>> create(Ref ref) {
    final argument = this.argument as int;
    return spotHazzards(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotHazzardsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotHazzardsHash() => r'c964c7fa6a436f10ddcf86b83d95a59a8c1c002c';

/// A spot's hazards — cached per spotId so Home's map quick-view sheet and
/// the Spot detail screen share one fetch.

final class SpotHazzardsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Hazzard>>, int> {
  SpotHazzardsFamily._()
    : super(
        retry: null,
        name: r'spotHazzardsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A spot's hazards — cached per spotId so Home's map quick-view sheet and
  /// the Spot detail screen share one fetch.

  SpotHazzardsProvider call(int spotId) =>
      SpotHazzardsProvider._(argument: spotId, from: this);

  @override
  String toString() => r'spotHazzardsProvider';
}

/// A spot's physical elements — cached per spotId so Home's map quick-view
/// sheet (just needs the count) and the Spot detail screen share one fetch.

@ProviderFor(spotElements)
final spotElementsProvider = SpotElementsFamily._();

/// A spot's physical elements — cached per spotId so Home's map quick-view
/// sheet (just needs the count) and the Spot detail screen share one fetch.

final class SpotElementsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpotElement>>,
          List<SpotElement>,
          FutureOr<List<SpotElement>>
        >
    with
        $FutureModifier<List<SpotElement>>,
        $FutureProvider<List<SpotElement>> {
  /// A spot's physical elements — cached per spotId so Home's map quick-view
  /// sheet (just needs the count) and the Spot detail screen share one fetch.
  SpotElementsProvider._({
    required SpotElementsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'spotElementsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotElementsHash();

  @override
  String toString() {
    return r'spotElementsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SpotElement>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpotElement>> create(Ref ref) {
    final argument = this.argument as int;
    return spotElements(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotElementsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotElementsHash() => r'a51fcfeab091d0500d4c3a56749a25605a6044fd';

/// A spot's physical elements — cached per spotId so Home's map quick-view
/// sheet (just needs the count) and the Spot detail screen share one fetch.

final class SpotElementsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SpotElement>>, int> {
  SpotElementsFamily._()
    : super(
        retry: null,
        name: r'spotElementsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A spot's physical elements — cached per spotId so Home's map quick-view
  /// sheet (just needs the count) and the Spot detail screen share one fetch.

  SpotElementsProvider call(int spotId) =>
      SpotElementsProvider._(argument: spotId, from: this);

  @override
  String toString() => r'spotElementsProvider';
}
