// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ride _$RideFromJson(Map<String, dynamic> json) => _Ride(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  ownerId: (json['owner_id'] as num).toInt(),
  stateId: (json['state_id'] as num?)?.toInt(),
  condition: (json['condition'] as num?)?.toInt(),
  coverPhotoId: (json['cover_photo_id'] as num?)?.toInt(),
  coverPhotoUrl: json['cover_photo_url'] as String?,
  createdDate: DateTime.parse(json['created_date'] as String),
  wastedDate: json['wasted_date'] == null
      ? null
      : DateTime.parse(json['wasted_date'] as String),
);

Map<String, dynamic> _$RideToJson(_Ride instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'owner_id': instance.ownerId,
  'state_id': instance.stateId,
  'condition': instance.condition,
  'cover_photo_id': instance.coverPhotoId,
  'cover_photo_url': instance.coverPhotoUrl,
  'created_date': instance.createdDate.toIso8601String(),
  'wasted_date': instance.wastedDate?.toIso8601String(),
};
