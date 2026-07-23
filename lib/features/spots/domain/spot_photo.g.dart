// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotPhoto _$SpotPhotoFromJson(Map<String, dynamic> json) => _SpotPhoto(
  id: (json['id'] as num).toInt(),
  spotId: (json['spot_id'] as num).toInt(),
  sportId: (json['sport_id'] as num?)?.toInt(),
  url: json['url'] as String,
  caption: json['caption'] as String?,
  voteCount: (json['vote_count'] as num).toInt(),
);

Map<String, dynamic> _$SpotPhotoToJson(_SpotPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spot_id': instance.spotId,
      'sport_id': instance.sportId,
      'url': instance.url,
      'caption': instance.caption,
      'vote_count': instance.voteCount,
    };
