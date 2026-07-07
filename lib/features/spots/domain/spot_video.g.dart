// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotVideo _$SpotVideoFromJson(Map<String, dynamic> json) => _SpotVideo(
  id: (json['id'] as num).toInt(),
  spotId: (json['spot_id'] as num).toInt(),
  url: json['url'] as String,
  provider: json['provider'] as String?,
  caption: json['caption'] as String?,
  voteCount: (json['vote_count'] as num).toInt(),
);

Map<String, dynamic> _$SpotVideoToJson(_SpotVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spot_id': instance.spotId,
      'url': instance.url,
      'provider': instance.provider,
      'caption': instance.caption,
      'vote_count': instance.voteCount,
    };
