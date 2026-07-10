// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A single rider's public profile, fetched from `GET /riders/{id}` —
/// backs [RiderProfileScreen] (viewing any rider, not just the signed-in
/// one — see [CurrentRider] for that).

@ProviderFor(riderProfile)
final riderProfileProvider = RiderProfileFamily._();

/// A single rider's public profile, fetched from `GET /riders/{id}` —
/// backs [RiderProfileScreen] (viewing any rider, not just the signed-in
/// one — see [CurrentRider] for that).

final class RiderProfileProvider
    extends $FunctionalProvider<AsyncValue<Rider>, Rider, FutureOr<Rider>>
    with $FutureModifier<Rider>, $FutureProvider<Rider> {
  /// A single rider's public profile, fetched from `GET /riders/{id}` —
  /// backs [RiderProfileScreen] (viewing any rider, not just the signed-in
  /// one — see [CurrentRider] for that).
  RiderProfileProvider._({
    required RiderProfileFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'riderProfileProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$riderProfileHash();

  @override
  String toString() {
    return r'riderProfileProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Rider> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Rider> create(Ref ref) {
    final argument = this.argument as int;
    return riderProfile(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RiderProfileProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$riderProfileHash() => r'af7c11445a2dced42f69e6555c9f7456647baae8';

/// A single rider's public profile, fetched from `GET /riders/{id}` —
/// backs [RiderProfileScreen] (viewing any rider, not just the signed-in
/// one — see [CurrentRider] for that).

final class RiderProfileFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Rider>, int> {
  RiderProfileFamily._()
    : super(
        retry: null,
        name: r'riderProfileProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A single rider's public profile, fetched from `GET /riders/{id}` —
  /// backs [RiderProfileScreen] (viewing any rider, not just the signed-in
  /// one — see [CurrentRider] for that).

  RiderProfileProvider call(int riderId) =>
      RiderProfileProvider._(argument: riderId, from: this);

  @override
  String toString() => r'riderProfileProvider';
}
