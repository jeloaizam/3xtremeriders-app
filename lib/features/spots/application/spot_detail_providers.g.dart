// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_detail_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

String _$spotDetailHash() => r'c25ec90d7ae0e94b0967999f9eb5d71870befa35';

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
