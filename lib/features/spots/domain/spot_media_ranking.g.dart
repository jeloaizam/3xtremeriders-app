// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_media_ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MediaBucket _$MediaBucketFromJson(Map<String, dynamic> json) => _MediaBucket(
  photos: (json['photos'] as List<dynamic>)
      .map((e) => RankedMediaItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  videos: (json['videos'] as List<dynamic>)
      .map((e) => RankedMediaItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$MediaBucketToJson(_MediaBucket instance) =>
    <String, dynamic>{'photos': instance.photos, 'videos': instance.videos};

_SpotMediaRanking _$SpotMediaRankingFromJson(Map<String, dynamic> json) =>
    _SpotMediaRanking(
      female: MediaBucket.fromJson(json['female'] as Map<String, dynamic>),
      male: MediaBucket.fromJson(json['male'] as Map<String, dynamic>),
      alien: MediaBucket.fromJson(json['alien'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SpotMediaRankingToJson(_SpotMediaRanking instance) =>
    <String, dynamic>{
      'female': instance.female,
      'male': instance.male,
      'alien': instance.alien,
    };
