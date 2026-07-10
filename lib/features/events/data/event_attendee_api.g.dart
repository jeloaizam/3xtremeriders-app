// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_attendee_api.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eventAttendeeApi)
final eventAttendeeApiProvider = EventAttendeeApiProvider._();

final class EventAttendeeApiProvider
    extends
        $FunctionalProvider<
          EventAttendeeApi,
          EventAttendeeApi,
          EventAttendeeApi
        >
    with $Provider<EventAttendeeApi> {
  EventAttendeeApiProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventAttendeeApiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventAttendeeApiHash();

  @$internal
  @override
  $ProviderElement<EventAttendeeApi> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventAttendeeApi create(Ref ref) {
    return eventAttendeeApi(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventAttendeeApi value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventAttendeeApi>(value),
    );
  }
}

String _$eventAttendeeApiHash() => r'084af1471319903a85d18538f65b881aabffb7aa';
