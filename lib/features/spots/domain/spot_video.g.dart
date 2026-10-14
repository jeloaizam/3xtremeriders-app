// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotVideo _$SpotVideoFromJson(Map<String, dynamic> json) => _SpotVideo(
  id: (json['id'] as num).toInt(),
  spotId: (json['spot_id'] as num).toInt(),
  sportId: (json['sport_id'] as num?)?.toInt(),
  uploadedBy: (json['uploaded_by'] as num).toInt(),
  uploaderNickname: json['uploader_nickname'] as String,
  uploaderIconImage: json['uploader_icon_image'] as String?,
  url: json['url'] as String,
  provider: json['provider'] as String?,
  caption: json['caption'] as String?,
  thumbnailUrl: json['thumbnail_url'] as String?,
  voteCount: (json['vote_count'] as num).toInt(),
);

Map<String, dynamic> _$SpotVideoToJson(_SpotVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spot_id': instance.spotId,
      'sport_id': instance.sportId,
      'uploaded_by': instance.uploadedBy,
      'uploader_nickname': instance.uploaderNickname,
      'uploader_icon_image': instance.uploaderIconImage,
      'url': instance.url,
      'provider': instance.provider,
      'caption': instance.caption,
      'thumbnail_url': instance.thumbnailUrl,
      'vote_count': instance.voteCount,
    };
