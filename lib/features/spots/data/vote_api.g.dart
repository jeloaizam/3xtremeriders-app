// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(voteApi)
final voteApiProvider = VoteApiProvider._();

final class VoteApiProvider
    extends $FunctionalProvider<VoteApi, VoteApi, VoteApi>
    with $Provider<VoteApi> {
  VoteApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voteApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voteApiHash();

  @$internal
  @override
  $ProviderElement<VoteApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VoteApi create(Ref ref) {
    return voteApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoteApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoteApi>(value),
    );
  }
}

String _$voteApiHash() => r'7aa9f546899b95a299b59bed15c7a45d15836ded';
