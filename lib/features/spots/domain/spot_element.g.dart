// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotElement _$SpotElementFromJson(Map<String, dynamic> json) => _SpotElement(
  id: (json['id'] as num).toInt(),
  spotId: (json['spot_id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
  type: json['type'] as String?,
  difficulty: (json['difficulty'] as num?)?.toInt(),
  reportedBy: (json['reported_by'] as num?)?.toInt(),
  likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
  dislikeCount: (json['dislike_count'] as num?)?.toInt() ?? 0,
  createdDate: DateTime.parse(json['created_date'] as String),
);

Map<String, dynamic> _$SpotElementToJson(_SpotElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spot_id': instance.spotId,
      'name': instance.name,
      'description': instance.description,
      'type': instance.type,
      'difficulty': instance.difficulty,
      'reported_by': instance.reportedBy,
      'like_count': instance.likeCount,
      'dislike_count': instance.dislikeCount,
      'created_date': instance.createdDate.toIso8601String(),
    };
