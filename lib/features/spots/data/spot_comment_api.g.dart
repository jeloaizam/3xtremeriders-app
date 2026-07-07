// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_comment_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(spotCommentApi)
final spotCommentApiProvider = SpotCommentApiProvider._();

final class SpotCommentApiProvider
    extends $FunctionalProvider<SpotCommentApi, SpotCommentApi, SpotCommentApi>
    with $Provider<SpotCommentApi> {
  SpotCommentApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'spotCommentApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$spotCommentApiHash();

  @$internal
  @override
  $ProviderElement<SpotCommentApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SpotCommentApi create(Ref ref) {
    return spotCommentApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SpotCommentApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SpotCommentApi>(value),
    );
  }
}

String _$spotCommentApiHash() => r'8a6c9f363d216834d1cd61e0e76d437580976327';
