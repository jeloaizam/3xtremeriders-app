// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_media_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A spot's photos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery. `sportId` scopes the
/// ranking to one of the spot's sports (null = every photo on the spot,
/// only meaningful for spots with a single sport or legacy untagged media).

@ProviderFor(spotPhotos)
final spotPhotosProvider = SpotPhotosFamily._();

/// A spot's photos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery. `sportId` scopes the
/// ranking to one of the spot's sports (null = every photo on the spot,
/// only meaningful for spots with a single sport or legacy untagged media).

final class SpotPhotosProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpotPhoto>>,
          List<SpotPhoto>,
          FutureOr<List<SpotPhoto>>
        >
    with $FutureModifier<List<SpotPhoto>>, $FutureProvider<List<SpotPhoto>> {
  /// A spot's photos, ranked by vote count (backend already orders them) —
  /// used by the Spot detail screen's media gallery. `sportId` scopes the
  /// ranking to one of the spot's sports (null = every photo on the spot,
  /// only meaningful for spots with a single sport or legacy untagged media).
  SpotPhotosProvider._({
    required SpotPhotosFamily super.from,
    required (int, int?) super.argument,
  }) : super(
         retry: null,
         name: r'spotPhotosProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotPhotosHash();

  @override
  String toString() {
    return r'spotPhotosProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<SpotPhoto>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpotPhoto>> create(Ref ref) {
    final argument = this.argument as (int, int?);
    return spotPhotos(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotPhotosProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotPhotosHash() => r'296e12e37d8fabb749d54a71902d2e1994001930';

/// A spot's photos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery. `sportId` scopes the
/// ranking to one of the spot's sports (null = every photo on the spot,
/// only meaningful for spots with a single sport or legacy untagged media).

final class SpotPhotosFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SpotPhoto>>, (int, int?)> {
  SpotPhotosFamily._()
    : super(
        retry: null,
        name: r'spotPhotosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A spot's photos, ranked by vote count (backend already orders them) —
  /// used by the Spot detail screen's media gallery. `sportId` scopes the
  /// ranking to one of the spot's sports (null = every photo on the spot,
  /// only meaningful for spots with a single sport or legacy untagged media).

  SpotPhotosProvider call(int spotId, int? sportId) =>
      SpotPhotosProvider._(argument: (spotId, sportId), from: this);

  @override
  String toString() => r'spotPhotosProvider';
}

/// A spot's videos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery. See [spotPhotos] for
/// what `sportId` does.

@ProviderFor(spotVideos)
final spotVideosProvider = SpotVideosFamily._();

/// A spot's videos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery. See [spotPhotos] for
/// what `sportId` does.

final class SpotVideosProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpotVideo>>,
          List<SpotVideo>,
          FutureOr<List<SpotVideo>>
        >
    with $FutureModifier<List<SpotVideo>>, $FutureProvider<List<SpotVideo>> {
  /// A spot's videos, ranked by vote count (backend already orders them) —
  /// used by the Spot detail screen's media gallery. See [spotPhotos] for
  /// what `sportId` does.
  SpotVideosProvider._({
    required SpotVideosFamily super.from,
    required (int, int?) super.argument,
  }) : super(
         retry: null,
         name: r'spotVideosProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotVideosHash();

  @override
  String toString() {
    return r'spotVideosProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<SpotVideo>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpotVideo>> create(Ref ref) {
    final argument = this.argument as (int, int?);
    return spotVideos(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotVideosProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotVideosHash() => r'bfcacf9fa2d32c5f2d993a19adda7199be2b50fb';

/// A spot's videos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery. See [spotPhotos] for
/// what `sportId` does.

final class SpotVideosFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SpotVideo>>, (int, int?)> {
  SpotVideosFamily._()
    : super(
        retry: null,
        name: r'spotVideosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A spot's videos, ranked by vote count (backend already orders them) —
  /// used by the Spot detail screen's media gallery. See [spotPhotos] for
  /// what `sportId` does.

  SpotVideosProvider call(int spotId, int? sportId) =>
      SpotVideosProvider._(argument: (spotId, sportId), from: this);

  @override
  String toString() => r'spotVideosProvider';
}

/// Whether the signed-in rider has already voted each of a spot's photos,
/// keyed by photo id — drives the filled/outline heart on each media tile.
/// One `/votes/check` call per photo (N+1, acceptable given spots only have
/// a handful of photos).

@ProviderFor(spotPhotoVotes)
final spotPhotoVotesProvider = SpotPhotoVotesFamily._();

/// Whether the signed-in rider has already voted each of a spot's photos,
/// keyed by photo id — drives the filled/outline heart on each media tile.
/// One `/votes/check` call per photo (N+1, acceptable given spots only have
/// a handful of photos).

final class SpotPhotoVotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<int, bool>>,
          Map<int, bool>,
          FutureOr<Map<int, bool>>
        >
    with $FutureModifier<Map<int, bool>>, $FutureProvider<Map<int, bool>> {
  /// Whether the signed-in rider has already voted each of a spot's photos,
  /// keyed by photo id — drives the filled/outline heart on each media tile.
  /// One `/votes/check` call per photo (N+1, acceptable given spots only have
  /// a handful of photos).
  SpotPhotoVotesProvider._({
    required SpotPhotoVotesFamily super.from,
    required (int, int?) super.argument,
  }) : super(
         retry: null,
         name: r'spotPhotoVotesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotPhotoVotesHash();

  @override
  String toString() {
    return r'spotPhotoVotesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Map<int, bool>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<int, bool>> create(Ref ref) {
    final argument = this.argument as (int, int?);
    return spotPhotoVotes(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotPhotoVotesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotPhotoVotesHash() => r'8e4140498afca7e672e5f3a2d706d8ab7068ef0a';

/// Whether the signed-in rider has already voted each of a spot's photos,
/// keyed by photo id — drives the filled/outline heart on each media tile.
/// One `/votes/check` call per photo (N+1, acceptable given spots only have
/// a handful of photos).

final class SpotPhotoVotesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<int, bool>>, (int, int?)> {
  SpotPhotoVotesFamily._()
    : super(
        retry: null,
        name: r'spotPhotoVotesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Whether the signed-in rider has already voted each of a spot's photos,
  /// keyed by photo id — drives the filled/outline heart on each media tile.
  /// One `/votes/check` call per photo (N+1, acceptable given spots only have
  /// a handful of photos).

  SpotPhotoVotesProvider call(int spotId, int? sportId) =>
      SpotPhotoVotesProvider._(argument: (spotId, sportId), from: this);

  @override
  String toString() => r'spotPhotoVotesProvider';
}

/// Same as [spotPhotoVotes] but for videos.

@ProviderFor(spotVideoVotes)
final spotVideoVotesProvider = SpotVideoVotesFamily._();

/// Same as [spotPhotoVotes] but for videos.

final class SpotVideoVotesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<int, bool>>,
          Map<int, bool>,
          FutureOr<Map<int, bool>>
        >
    with $FutureModifier<Map<int, bool>>, $FutureProvider<Map<int, bool>> {
  /// Same as [spotPhotoVotes] but for videos.
  SpotVideoVotesProvider._({
    required SpotVideoVotesFamily super.from,
    required (int, int?) super.argument,
  }) : super(
         retry: null,
         name: r'spotVideoVotesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotVideoVotesHash();

  @override
  String toString() {
    return r'spotVideoVotesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Map<int, bool>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<int, bool>> create(Ref ref) {
    final argument = this.argument as (int, int?);
    return spotVideoVotes(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotVideoVotesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotVideoVotesHash() => r'03f07b7f74e3992b2332a6d00fb3d1fd531b1055';

/// Same as [spotPhotoVotes] but for videos.

final class SpotVideoVotesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<int, bool>>, (int, int?)> {
  SpotVideoVotesFamily._()
    : super(
        retry: null,
        name: r'spotVideoVotesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Same as [spotPhotoVotes] but for videos.

  SpotVideoVotesProvider call(int spotId, int? sportId) =>
      SpotVideoVotesProvider._(argument: (spotId, sportId), from: this);

  @override
  String toString() => r'spotVideoVotesProvider';
}
