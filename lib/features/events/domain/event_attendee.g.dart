// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_attendee.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventAttendee _$EventAttendeeFromJson(Map<String, dynamic> json) =>
    _EventAttendee(
      id: (json['id'] as num).toInt(),
      eventId: (json['event_id'] as num).toInt(),
      riderId: (json['rider_id'] as num).toInt(),
      status: (json['status'] as num?)?.toInt(),
      createdDate: DateTime.parse(json['created_date'] as String),
    );

Map<String, dynamic> _$EventAttendeeToJson(_EventAttendee instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'rider_id': instance.riderId,
      'status': instance.status,
      'created_date': instance.createdDate.toIso8601String(),
    };
