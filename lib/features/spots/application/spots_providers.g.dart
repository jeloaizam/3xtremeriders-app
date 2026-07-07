// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spots_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Real spots near the user, fetched from `GET /spots`.

@ProviderFor(nearbySpots)
final nearbySpotsProvider = NearbySpotsProvider._();

/// Real spots near the user, fetched from `GET /spots`.

final class NearbySpotsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Spot>>,
          List<Spot>,
          FutureOr<List<Spot>>
        >
    with $FutureModifier<List<Spot>>, $FutureProvider<List<Spot>> {
  /// Real spots near the user, fetched from `GET /spots`.
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
  $FutureProviderElement<List<Spot>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Spot>> create(Ref ref) {
    return nearbySpots(ref);
  }
}

String _$nearbySpotsHash() => r'4b54ada159cfd154fda1571f8b6714e8e3196afd';

/// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
/// spotId so Home's list and the Spot detail screen share one fetch.
///
/// keepAlive: without it, this (and the other small per-spot providers
/// below) gets disposed the instant nothing is watching it even for a
/// single frame — which happened during scroll on the Spot screen's media
/// gallery (a nested widget watching it independently of the parent's
/// `spotDetailProvider` watch), making it silently refetch and show fewer
/// items right after the fetch, then the full list again once it resolved.

@ProviderFor(spotSports)
final spotSportsProvider = SpotSportsFamily._();

/// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
/// spotId so Home's list and the Spot detail screen share one fetch.
///
/// keepAlive: without it, this (and the other small per-spot providers
/// below) gets disposed the instant nothing is watching it even for a
/// single frame — which happened during scroll on the Spot screen's media
/// gallery (a nested widget watching it independently of the parent's
/// `spotDetailProvider` watch), making it silently refetch and show fewer
/// items right after the fetch, then the full list again once it resolved.

final class SpotSportsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Sport>>,
          List<Sport>,
          FutureOr<List<Sport>>
        >
    with $FutureModifier<List<Sport>>, $FutureProvider<List<Sport>> {
  /// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
  /// spotId so Home's list and the Spot detail screen share one fetch.
  ///
  /// keepAlive: without it, this (and the other small per-spot providers
  /// below) gets disposed the instant nothing is watching it even for a
  /// single frame — which happened during scroll on the Spot screen's media
  /// gallery (a nested widget watching it independently of the parent's
  /// `spotDetailProvider` watch), making it silently refetch and show fewer
  /// items right after the fetch, then the full list again once it resolved.
  SpotSportsProvider._({
    required SpotSportsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'spotSportsProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotSportsHash();

  @override
  String toString() {
    return r'spotSportsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Sport>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Sport>> create(Ref ref) {
    final argument = this.argument as int;
    return spotSports(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotSportsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotSportsHash() => r'8a02aed8eef6e797f666ffe65808df6ba51b3e8a';

/// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
/// spotId so Home's list and the Spot detail screen share one fetch.
///
/// keepAlive: without it, this (and the other small per-spot providers
/// below) gets disposed the instant nothing is watching it even for a
/// single frame — which happened during scroll on the Spot screen's media
/// gallery (a nested widget watching it independently of the parent's
/// `spotDetailProvider` watch), making it silently refetch and show fewer
/// items right after the fetch, then the full list again once it resolved.

final class SpotSportsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Sport>>, int> {
  SpotSportsFamily._()
    : super(
        retry: null,
        name: r'spotSportsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A spot's sports, fetched from `GET /spots/{id}/sports` — cached per
  /// spotId so Home's list and the Spot detail screen share one fetch.
  ///
  /// keepAlive: without it, this (and the other small per-spot providers
  /// below) gets disposed the instant nothing is watching it even for a
  /// single frame — which happened during scroll on the Spot screen's media
  /// gallery (a nested widget watching it independently of the parent's
  /// `spotDetailProvider` watch), making it silently refetch and show fewer
  /// items right after the fetch, then the full list again once it resolved.

  SpotSportsProvider call(int spotId) =>
      SpotSportsProvider._(argument: spotId, from: this);

  @override
  String toString() => r'spotSportsProvider';
}

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

/// A spot's photos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery.

@ProviderFor(spotPhotos)
final spotPhotosProvider = SpotPhotosFamily._();

/// A spot's photos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery.

final class SpotPhotosProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpotPhoto>>,
          List<SpotPhoto>,
          FutureOr<List<SpotPhoto>>
        >
    with $FutureModifier<List<SpotPhoto>>, $FutureProvider<List<SpotPhoto>> {
  /// A spot's photos, ranked by vote count (backend already orders them) —
  /// used by the Spot detail screen's media gallery.
  SpotPhotosProvider._({
    required SpotPhotosFamily super.from,
    required int super.argument,
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
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SpotPhoto>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpotPhoto>> create(Ref ref) {
    final argument = this.argument as int;
    return spotPhotos(ref, argument);
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

String _$spotPhotosHash() => r'fda54800f68fc41b49329c28eb12398d0aba52f3';

/// A spot's photos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery.

final class SpotPhotosFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SpotPhoto>>, int> {
  SpotPhotosFamily._()
    : super(
        retry: null,
        name: r'spotPhotosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A spot's photos, ranked by vote count (backend already orders them) —
  /// used by the Spot detail screen's media gallery.

  SpotPhotosProvider call(int spotId) =>
      SpotPhotosProvider._(argument: spotId, from: this);

  @override
  String toString() => r'spotPhotosProvider';
}

/// A spot's videos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery.

@ProviderFor(spotVideos)
final spotVideosProvider = SpotVideosFamily._();

/// A spot's videos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery.

final class SpotVideosProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpotVideo>>,
          List<SpotVideo>,
          FutureOr<List<SpotVideo>>
        >
    with $FutureModifier<List<SpotVideo>>, $FutureProvider<List<SpotVideo>> {
  /// A spot's videos, ranked by vote count (backend already orders them) —
  /// used by the Spot detail screen's media gallery.
  SpotVideosProvider._({
    required SpotVideosFamily super.from,
    required int super.argument,
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
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<SpotVideo>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpotVideo>> create(Ref ref) {
    final argument = this.argument as int;
    return spotVideos(ref, argument);
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

String _$spotVideosHash() => r'578679fd24051d0e6f3fdded9dee9d395d08a507';

/// A spot's videos, ranked by vote count (backend already orders them) —
/// used by the Spot detail screen's media gallery.

final class SpotVideosFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<SpotVideo>>, int> {
  SpotVideosFamily._()
    : super(
        retry: null,
        name: r'spotVideosProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// A spot's videos, ranked by vote count (backend already orders them) —
  /// used by the Spot detail screen's media gallery.

  SpotVideosProvider call(int spotId) =>
      SpotVideosProvider._(argument: spotId, from: this);

  @override
  String toString() => r'spotVideosProvider';
}

/// Everything the Spot detail screen needs for one spot, fetched in
/// parallel and combined: the spot itself, its sports, hazards, comments
/// (each resolved to its author), the creator's profile, whether the
/// signed-in rider already liked it, and their own star rating if any.
///
/// keepAlive: SpotScreen's `detailAsync.when()` renders a completely
/// different widget for `loading` vs `data` — if this provider isn't kept
/// alive, a momentary listener gap (e.g. during scroll) disposes it, and the
/// next watch briefly returns `loading` again, tearing down and rebuilding
/// the whole `_SpotScreenBody` subtree (which is why the media gallery's
/// own local state — the video/photo tab — was resetting on scroll).

@ProviderFor(spotDetail)
final spotDetailProvider = SpotDetailFamily._();

/// Everything the Spot detail screen needs for one spot, fetched in
/// parallel and combined: the spot itself, its sports, hazards, comments
/// (each resolved to its author), the creator's profile, whether the
/// signed-in rider already liked it, and their own star rating if any.
///
/// keepAlive: SpotScreen's `detailAsync.when()` renders a completely
/// different widget for `loading` vs `data` — if this provider isn't kept
/// alive, a momentary listener gap (e.g. during scroll) disposes it, and the
/// next watch briefly returns `loading` again, tearing down and rebuilding
/// the whole `_SpotScreenBody` subtree (which is why the media gallery's
/// own local state — the video/photo tab — was resetting on scroll).

final class SpotDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<SpotDetailData>,
          SpotDetailData,
          FutureOr<SpotDetailData>
        >
    with $FutureModifier<SpotDetailData>, $FutureProvider<SpotDetailData> {
  /// Everything the Spot detail screen needs for one spot, fetched in
  /// parallel and combined: the spot itself, its sports, hazards, comments
  /// (each resolved to its author), the creator's profile, whether the
  /// signed-in rider already liked it, and their own star rating if any.
  ///
  /// keepAlive: SpotScreen's `detailAsync.when()` renders a completely
  /// different widget for `loading` vs `data` — if this provider isn't kept
  /// alive, a momentary listener gap (e.g. during scroll) disposes it, and the
  /// next watch briefly returns `loading` again, tearing down and rebuilding
  /// the whole `_SpotScreenBody` subtree (which is why the media gallery's
  /// own local state — the video/photo tab — was resetting on scroll).
  SpotDetailProvider._({
    required SpotDetailFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'spotDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$spotDetailHash();

  @override
  String toString() {
    return r'spotDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SpotDetailData> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SpotDetailData> create(Ref ref) {
    final argument = this.argument as int;
    return spotDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is SpotDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$spotDetailHash() => r'77c41e0c880bcc9bde9f7ba7aecaf94a6082179a';

/// Everything the Spot detail screen needs for one spot, fetched in
/// parallel and combined: the spot itself, its sports, hazards, comments
/// (each resolved to its author), the creator's profile, whether the
/// signed-in rider already liked it, and their own star rating if any.
///
/// keepAlive: SpotScreen's `detailAsync.when()` renders a completely
/// different widget for `loading` vs `data` — if this provider isn't kept
/// alive, a momentary listener gap (e.g. during scroll) disposes it, and the
/// next watch briefly returns `loading` again, tearing down and rebuilding
/// the whole `_SpotScreenBody` subtree (which is why the media gallery's
/// own local state — the video/photo tab — was resetting on scroll).

final class SpotDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SpotDetailData>, int> {
  SpotDetailFamily._()
    : super(
        retry: null,
        name: r'spotDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Everything the Spot detail screen needs for one spot, fetched in
  /// parallel and combined: the spot itself, its sports, hazards, comments
  /// (each resolved to its author), the creator's profile, whether the
  /// signed-in rider already liked it, and their own star rating if any.
  ///
  /// keepAlive: SpotScreen's `detailAsync.when()` renders a completely
  /// different widget for `loading` vs `data` — if this provider isn't kept
  /// alive, a momentary listener gap (e.g. during scroll) disposes it, and the
  /// next watch briefly returns `loading` again, tearing down and rebuilding
  /// the whole `_SpotScreenBody` subtree (which is why the media gallery's
  /// own local state — the video/photo tab — was resetting on scroll).

  SpotDetailProvider call(int spotId) =>
      SpotDetailProvider._(argument: spotId, from: this);

  @override
  String toString() => r'spotDetailProvider';
}
