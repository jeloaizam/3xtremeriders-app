// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotComment _$SpotCommentFromJson(Map<String, dynamic> json) => _SpotComment(
  id: (json['id'] as num).toInt(),
  riderId: (json['rider_id'] as num).toInt(),
  parentId: (json['parent_id'] as num?)?.toInt(),
  body: json['body'] as String,
  voteCount: (json['vote_count'] as num).toInt(),
  createdDate: DateTime.parse(json['created_date'] as String),
);

Map<String, dynamic> _$SpotCommentToJson(_SpotComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rider_id': instance.riderId,
      'parent_id': instance.parentId,
      'body': instance.body,
      'vote_count': instance.voteCount,
      'created_date': instance.createdDate.toIso8601String(),
    };
