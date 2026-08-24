// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ranked_media_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankedMediaItem _$RankedMediaItemFromJson(Map<String, dynamic> json) =>
    _RankedMediaItem(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String?,
      voteCount: (json['vote_count'] as num).toInt(),
      uploadedBy: (json['uploaded_by'] as num).toInt(),
      caption: json['caption'] as String?,
      createdDate: DateTime.parse(json['created_date'] as String),
    );

Map<String, dynamic> _$RankedMediaItemToJson(_RankedMediaItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'thumbnail_url': instance.thumbnailUrl,
      'vote_count': instance.voteCount,
      'uploaded_by': instance.uploadedBy,
      'caption': instance.caption,
      'created_date': instance.createdDate.toIso8601String(),
    };
