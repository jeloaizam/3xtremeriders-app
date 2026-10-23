// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_target_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Resolves the content a [Report] points at, for [ModerationQueueScreen] to
/// render inline (body text / thumbnail) instead of just the bare id — null
/// means it's gone (photo/video are hard-deleted, so a past "Accionado"
/// report 404s; a soft-deleted comment still resolves, just with
/// `state == commentStateDeleted`).

@ProviderFor(reportedComment)
final reportedCommentProvider = ReportedCommentFamily._();

/// Resolves the content a [Report] points at, for [ModerationQueueScreen] to
/// render inline (body text / thumbnail) instead of just the bare id — null
/// means it's gone (photo/video are hard-deleted, so a past "Accionado"
/// report 404s; a soft-deleted comment still resolves, just with
/// `state == commentStateDeleted`).

final class ReportedCommentProvider
    extends
        $FunctionalProvider<
          AsyncValue<SpotComment?>,
          SpotComment?,
          FutureOr<SpotComment?>
        >
    with $FutureModifier<SpotComment?>, $FutureProvider<SpotComment?> {
  /// Resolves the content a [Report] points at, for [ModerationQueueScreen] to
  /// render inline (body text / thumbnail) instead of just the bare id — null
  /// means it's gone (photo/video are hard-deleted, so a past "Accionado"
  /// report 404s; a soft-deleted comment still resolves, just with
  /// `state == commentStateDeleted`).
  ReportedCommentProvider._({
    required ReportedCommentFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'reportedCommentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reportedCommentHash();

  @override
  String toString() {
    return r'reportedCommentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SpotComment?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SpotComment?> create(Ref ref) {
    final argument = this.argument as int;
    return reportedComment(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportedCommentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reportedCommentHash() => r'7a5404edd4fff2f3dd25b791b0a7bbdfa439fb0a';

/// Resolves the content a [Report] points at, for [ModerationQueueScreen] to
/// render inline (body text / thumbnail) instead of just the bare id — null
/// means it's gone (photo/video are hard-deleted, so a past "Accionado"
/// report 404s; a soft-deleted comment still resolves, just with
/// `state == commentStateDeleted`).

final class ReportedCommentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SpotComment?>, int> {
  ReportedCommentFamily._()
    : super(
        retry: null,
        name: r'reportedCommentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Resolves the content a [Report] points at, for [ModerationQueueScreen] to
  /// render inline (body text / thumbnail) instead of just the bare id — null
  /// means it's gone (photo/video are hard-deleted, so a past "Accionado"
  /// report 404s; a soft-deleted comment still resolves, just with
  /// `state == commentStateDeleted`).

  ReportedCommentProvider call(int commentId) =>
      ReportedCommentProvider._(argument: commentId, from: this);

  @override
  String toString() => r'reportedCommentProvider';
}

@ProviderFor(reportedPhoto)
final reportedPhotoProvider = ReportedPhotoFamily._();

final class ReportedPhotoProvider
    extends
        $FunctionalProvider<
          AsyncValue<SpotPhoto?>,
          SpotPhoto?,
          FutureOr<SpotPhoto?>
        >
    with $FutureModifier<SpotPhoto?>, $FutureProvider<SpotPhoto?> {
  ReportedPhotoProvider._({
    required ReportedPhotoFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'reportedPhotoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reportedPhotoHash();

  @override
  String toString() {
    return r'reportedPhotoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SpotPhoto?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SpotPhoto?> create(Ref ref) {
    final argument = this.argument as int;
    return reportedPhoto(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportedPhotoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reportedPhotoHash() => r'b707a15fb0d5e3eeadcf80de51f1afbdb45300d2';

final class ReportedPhotoFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SpotPhoto?>, int> {
  ReportedPhotoFamily._()
    : super(
        retry: null,
        name: r'reportedPhotoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReportedPhotoProvider call(int photoId) =>
      ReportedPhotoProvider._(argument: photoId, from: this);

  @override
  String toString() => r'reportedPhotoProvider';
}

@ProviderFor(reportedVideo)
final reportedVideoProvider = ReportedVideoFamily._();

final class ReportedVideoProvider
    extends
        $FunctionalProvider<
          AsyncValue<SpotVideo?>,
          SpotVideo?,
          FutureOr<SpotVideo?>
        >
    with $FutureModifier<SpotVideo?>, $FutureProvider<SpotVideo?> {
  ReportedVideoProvider._({
    required ReportedVideoFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'reportedVideoProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reportedVideoHash();

  @override
  String toString() {
    return r'reportedVideoProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<SpotVideo?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<SpotVideo?> create(Ref ref) {
    final argument = this.argument as int;
    return reportedVideo(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportedVideoProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reportedVideoHash() => r'b146e111d44c8de5437e540034ee239b1feb69bb';

final class ReportedVideoFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<SpotVideo?>, int> {
  ReportedVideoFamily._()
    : super(
        retry: null,
        name: r'reportedVideoProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReportedVideoProvider call(int videoId) =>
      ReportedVideoProvider._(argument: videoId, from: this);

  @override
  String toString() => r'reportedVideoProvider';
}
