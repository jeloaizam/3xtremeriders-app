// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Report _$ReportFromJson(Map<String, dynamic> json) => _Report(
  id: (json['id'] as num).toInt(),
  riderId: (json['rider_id'] as num).toInt(),
  targetType: json['target_type'] as String,
  targetId: (json['target_id'] as num).toInt(),
  reason: json['reason'] as String,
  details: json['details'] as String?,
  state: (json['state'] as num).toInt(),
  createdDate: DateTime.parse(json['created_date'] as String),
);

Map<String, dynamic> _$ReportToJson(_Report instance) => <String, dynamic>{
  'id': instance.id,
  'rider_id': instance.riderId,
  'target_type': instance.targetType,
  'target_id': instance.targetId,
  'reason': instance.reason,
  'details': instance.details,
  'state': instance.state,
  'created_date': instance.createdDate.toIso8601String(),
};
