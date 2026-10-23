// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Backs [ModerationQueueScreen] — `targetType` is always 'spot' for now
/// (this round's only moderated content type, see the moderation plan),
/// `state` picks which of the 3 review states to show.

@ProviderFor(reportQueue)
final reportQueueProvider = ReportQueueFamily._();

/// Backs [ModerationQueueScreen] — `targetType` is always 'spot' for now
/// (this round's only moderated content type, see the moderation plan),
/// `state` picks which of the 3 review states to show.

final class ReportQueueProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Report>>,
          List<Report>,
          FutureOr<List<Report>>
        >
    with $FutureModifier<List<Report>>, $FutureProvider<List<Report>> {
  /// Backs [ModerationQueueScreen] — `targetType` is always 'spot' for now
  /// (this round's only moderated content type, see the moderation plan),
  /// `state` picks which of the 3 review states to show.
  ReportQueueProvider._({
    required ReportQueueFamily super.from,
    required (int, String) super.argument,
  }) : super(
         retry: null,
         name: r'reportQueueProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reportQueueHash();

  @override
  String toString() {
    return r'reportQueueProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<Report>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Report>> create(Ref ref) {
    final argument = this.argument as (int, String);
    return reportQueue(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is ReportQueueProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reportQueueHash() => r'da46cfb1a7e479f4635efc67ae1bdb7f50c047e2';

/// Backs [ModerationQueueScreen] — `targetType` is always 'spot' for now
/// (this round's only moderated content type, see the moderation plan),
/// `state` picks which of the 3 review states to show.

final class ReportQueueFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Report>>, (int, String)> {
  ReportQueueFamily._()
    : super(
        retry: null,
        name: r'reportQueueProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Backs [ModerationQueueScreen] — `targetType` is always 'spot' for now
  /// (this round's only moderated content type, see the moderation plan),
  /// `state` picks which of the 3 review states to show.

  ReportQueueProvider call(int state, String targetType) =>
      ReportQueueProvider._(argument: (state, targetType), from: this);

  @override
  String toString() => r'reportQueueProvider';
}
