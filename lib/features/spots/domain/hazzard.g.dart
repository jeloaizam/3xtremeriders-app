// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hazzard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Hazzard _$HazzardFromJson(Map<String, dynamic> json) => _Hazzard(
  id: (json['id'] as num).toInt(),
  spotId: (json['spot_id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  severity: (json['severity'] as num?)?.toInt(),
  createdDate: DateTime.parse(json['created_date'] as String),
);

Map<String, dynamic> _$HazzardToJson(_Hazzard instance) => <String, dynamic>{
  'id': instance.id,
  'spot_id': instance.spotId,
  'name': instance.name,
  'description': instance.description,
  'severity': instance.severity,
  'created_date': instance.createdDate.toIso8601String(),
};
