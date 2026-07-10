// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  startDate: DateTime.parse(json['start_date'] as String),
  endDate: json['end_date'] == null
      ? null
      : DateTime.parse(json['end_date'] as String),
  spotId: (json['spot_id'] as num?)?.toInt(),
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  createdBy: (json['created_by'] as num).toInt(),
  stateId: (json['state_id'] as num?)?.toInt(),
  coverImageUrl: json['cover_image_url'] as String?,
  createdDate: DateTime.parse(json['created_date'] as String),
  updatedDate: json['updated_date'] == null
      ? null
      : DateTime.parse(json['updated_date'] as String),
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'start_date': instance.startDate.toIso8601String(),
  'end_date': instance.endDate?.toIso8601String(),
  'spot_id': instance.spotId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'created_by': instance.createdBy,
  'state_id': instance.stateId,
  'cover_image_url': instance.coverImageUrl,
  'created_date': instance.createdDate.toIso8601String(),
  'updated_date': instance.updatedDate?.toIso8601String(),
};
