// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_sports_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A rider's favorite sports, ordered by `order` ascending (1 = highest
/// favorite) — backend already returns them ordered
/// (`crud_rider_sport.get_all`). The lowest-`order` entry drives the Home
/// bottom nav's personalized sport chip.

@ProviderFor(riderSports)
final riderSportsProvider = RiderSportsFamily._();

/// A rider's favorite sports, ordered by `order` ascending (1 = highest
/// favorite) — backend already returns them ordered
/// (`crud_rider_sport.get_all`). The lowest-`order` entry drives the Home
/// bottom nav's personalized sport chip.

final class RiderSportsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RiderSport>>,
          List<RiderSport>,
          FutureOr<List<RiderSport>>
        >
    with $FutureModifier<List<RiderSport>>, $FutureProvider<List<RiderSport>> {
  /// A rider's favorite sports, ordered by `order` ascending (1 = highest
  /// favorite) — backend already returns them ordered
  /// (`crud_rider_sport.get_all`). The lowest-`order` entry drives the Home
  /// bottom nav's personalized sport chip.
  RiderSportsProvider._({
    required RiderSportsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'riderSportsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$riderSportsHash();

  @override
  String toString() {
    return r'riderSportsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<RiderSport>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RiderSport>> create(Ref ref) {
    final argument = this.argument as int;
    return riderSports(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RiderSportsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$riderSportsHash() => r'5d3b9bd5f51ac4815e3557d67c379d7be8604682';

/// A rider's favorite sports, ordered by `order` ascending (1 = highest
/// favorite) — backend already returns them ordered
/// (`crud_rider_sport.get_all`). The lowest-`order` entry drives the Home
/// bottom nav's personalized sport chip.

final class RiderSportsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<RiderSport>>, int> {
  RiderSportsFamily._()
    : super(
        retry: null,
        name: r'riderSportsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A rider's favorite sports, ordered by `order` ascending (1 = highest
  /// favorite) — backend already returns them ordered
  /// (`crud_rider_sport.get_all`). The lowest-`order` entry drives the Home
  /// bottom nav's personalized sport chip.

  RiderSportsProvider call(int riderId) =>
      RiderSportsProvider._(argument: riderId, from: this);

  @override
  String toString() => r'riderSportsProvider';
}
