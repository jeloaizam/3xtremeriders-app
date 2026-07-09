// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rides_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A rider's rides (gear/vehicles), fetched from `GET /riders/{id}/rides`.

@ProviderFor(ridesByOwner)
final ridesByOwnerProvider = RidesByOwnerFamily._();

/// A rider's rides (gear/vehicles), fetched from `GET /riders/{id}/rides`.

final class RidesByOwnerProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Ride>>,
          List<Ride>,
          FutureOr<List<Ride>>
        >
    with $FutureModifier<List<Ride>>, $FutureProvider<List<Ride>> {
  /// A rider's rides (gear/vehicles), fetched from `GET /riders/{id}/rides`.
  RidesByOwnerProvider._({
    required RidesByOwnerFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'ridesByOwnerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ridesByOwnerHash();

  @override
  String toString() {
    return r'ridesByOwnerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Ride>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Ride>> create(Ref ref) {
    final argument = this.argument as int;
    return ridesByOwner(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RidesByOwnerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ridesByOwnerHash() => r'97b77aaa81619560fdaf240eea14d8ec07aafe18';

/// A rider's rides (gear/vehicles), fetched from `GET /riders/{id}/rides`.

final class RidesByOwnerFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Ride>>, int> {
  RidesByOwnerFamily._()
    : super(
        retry: null,
        name: r'ridesByOwnerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A rider's rides (gear/vehicles), fetched from `GET /riders/{id}/rides`.

  RidesByOwnerProvider call(int riderId) =>
      RidesByOwnerProvider._(argument: riderId, from: this);

  @override
  String toString() => r'ridesByOwnerProvider';
}

/// The fixed catalog of ride states (active/onSale/wasted/toGift) — used by
/// CreateRideScreen's state picker and RideScreen's status badge.

@ProviderFor(rideStates)
final rideStatesProvider = RideStatesProvider._();

/// The fixed catalog of ride states (active/onSale/wasted/toGift) — used by
/// CreateRideScreen's state picker and RideScreen's status badge.

final class RideStatesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RideState>>,
          List<RideState>,
          FutureOr<List<RideState>>
        >
    with $FutureModifier<List<RideState>>, $FutureProvider<List<RideState>> {
  /// The fixed catalog of ride states (active/onSale/wasted/toGift) — used by
  /// CreateRideScreen's state picker and RideScreen's status badge.
  RideStatesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rideStatesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rideStatesHash();

  @$internal
  @override
  $FutureProviderElement<List<RideState>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RideState>> create(Ref ref) {
    return rideStates(ref);
  }
}

String _$rideStatesHash() => r'12481d2f94a2dbc7517a53337a3076a67f665069';

/// Everything the Ride detail screen needs for one ride, fetched in
/// parallel: the ride itself, its elements, and the owner's photos/videos
/// tagged with this ride specifically.

@ProviderFor(rideDetail)
final rideDetailProvider = RideDetailFamily._();

/// Everything the Ride detail screen needs for one ride, fetched in
/// parallel: the ride itself, its elements, and the owner's photos/videos
/// tagged with this ride specifically.

final class RideDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<RideDetailData>,
          RideDetailData,
          FutureOr<RideDetailData>
        >
    with $FutureModifier<RideDetailData>, $FutureProvider<RideDetailData> {
  /// Everything the Ride detail screen needs for one ride, fetched in
  /// parallel: the ride itself, its elements, and the owner's photos/videos
  /// tagged with this ride specifically.
  RideDetailProvider._({
    required RideDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'rideDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$rideDetailHash();

  @override
  String toString() {
    return r'rideDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<RideDetailData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RideDetailData> create(Ref ref) {
    final argument = this.argument as int;
    return rideDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RideDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$rideDetailHash() => r'297597f6b926eefbfc09e3db5dcdb09614434b35';

/// Everything the Ride detail screen needs for one ride, fetched in
/// parallel: the ride itself, its elements, and the owner's photos/videos
/// tagged with this ride specifically.

final class RideDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RideDetailData>, int> {
  RideDetailFamily._()
    : super(
        retry: null,
        name: r'rideDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Everything the Ride detail screen needs for one ride, fetched in
  /// parallel: the ride itself, its elements, and the owner's photos/videos
  /// tagged with this ride specifically.

  RideDetailProvider call(int rideId) =>
      RideDetailProvider._(argument: rideId, from: this);

  @override
  String toString() => r'rideDetailProvider';
}
