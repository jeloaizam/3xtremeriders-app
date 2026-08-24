// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_comments.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Comments (with author resolved) for a photo or video's own comment
/// thread — same shape/resolution as `spotDetailProvider`'s `comments`
/// field, just for `targetType` 'photo'/'video' instead of 'spot'. Kept as
/// its own provider (not folded into `spotDetailProvider`) since a
/// photo/video's comments are only ever needed once its own detail screen
/// opens, not every time the spot loads.

@ProviderFor(mediaComments)
final mediaCommentsProvider = MediaCommentsFamily._();

/// Comments (with author resolved) for a photo or video's own comment
/// thread — same shape/resolution as `spotDetailProvider`'s `comments`
/// field, just for `targetType` 'photo'/'video' instead of 'spot'. Kept as
/// its own provider (not folded into `spotDetailProvider`) since a
/// photo/video's comments are only ever needed once its own detail screen
/// opens, not every time the spot loads.

final class MediaCommentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SpotCommentWithAuthor>>,
          List<SpotCommentWithAuthor>,
          FutureOr<List<SpotCommentWithAuthor>>
        >
    with
        $FutureModifier<List<SpotCommentWithAuthor>>,
        $FutureProvider<List<SpotCommentWithAuthor>> {
  /// Comments (with author resolved) for a photo or video's own comment
  /// thread — same shape/resolution as `spotDetailProvider`'s `comments`
  /// field, just for `targetType` 'photo'/'video' instead of 'spot'. Kept as
  /// its own provider (not folded into `spotDetailProvider`) since a
  /// photo/video's comments are only ever needed once its own detail screen
  /// opens, not every time the spot loads.
  MediaCommentsProvider._({
    required MediaCommentsFamily super.from,
    required (String, int) super.argument,
  }) : super(
         retry: null,
         name: r'mediaCommentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mediaCommentsHash();

  @override
  String toString() {
    return r'mediaCommentsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<SpotCommentWithAuthor>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SpotCommentWithAuthor>> create(Ref ref) {
    final argument = this.argument as (String, int);
    return mediaComments(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is MediaCommentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mediaCommentsHash() => r'518a2382f40ad3aa52d17dfb2c5c336e12289eed';

/// Comments (with author resolved) for a photo or video's own comment
/// thread — same shape/resolution as `spotDetailProvider`'s `comments`
/// field, just for `targetType` 'photo'/'video' instead of 'spot'. Kept as
/// its own provider (not folded into `spotDetailProvider`) since a
/// photo/video's comments are only ever needed once its own detail screen
/// opens, not every time the spot loads.

final class MediaCommentsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<SpotCommentWithAuthor>>,
          (String, int)
        > {
  MediaCommentsFamily._()
    : super(
        retry: null,
        name: r'mediaCommentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Comments (with author resolved) for a photo or video's own comment
  /// thread — same shape/resolution as `spotDetailProvider`'s `comments`
  /// field, just for `targetType` 'photo'/'video' instead of 'spot'. Kept as
  /// its own provider (not folded into `spotDetailProvider`) since a
  /// photo/video's comments are only ever needed once its own detail screen
  /// opens, not every time the spot loads.

  MediaCommentsProvider call(String targetType, int targetId) =>
      MediaCommentsProvider._(argument: (targetType, targetId), from: this);

  @override
  String toString() => r'mediaCommentsProvider';
}
