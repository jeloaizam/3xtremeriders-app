// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventApi)
final eventApiProvider = EventApiProvider._();

final class EventApiProvider
    extends $FunctionalProvider<EventApi, EventApi, EventApi>
    with $Provider<EventApi> {
  EventApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventApiHash();

  @$internal
  @override
  $ProviderElement<EventApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventApi create(Ref ref) {
    return eventApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventApi>(value),
    );
  }
}

String _$eventApiHash() => r'2eff349dc46cf1e7cc82b44a5bdb17c233c01b88';
