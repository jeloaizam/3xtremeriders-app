// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportApi)
final reportApiProvider = ReportApiProvider._();

final class ReportApiProvider
    extends $FunctionalProvider<ReportApi, ReportApi, ReportApi>
    with $Provider<ReportApi> {
  ReportApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportApiHash();

  @$internal
  @override
  $ProviderElement<ReportApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReportApi create(Ref ref) {
    return reportApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportApi>(value),
    );
  }
}

String _$reportApiHash() => r'3a1dc363ce9fd075e70bb48791ffede1144eda9a';
