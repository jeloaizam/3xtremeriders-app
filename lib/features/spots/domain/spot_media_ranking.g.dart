// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_media_ranking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotMediaRanking _$SpotMediaRankingFromJson(Map<String, dynamic> json) =>
    _SpotMediaRanking(
      female: (json['female'] as List<dynamic>)
          .map((e) => RankedMediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      male: (json['male'] as List<dynamic>)
          .map((e) => RankedMediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      alien: (json['alien'] as List<dynamic>)
          .map((e) => RankedMediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SpotMediaRankingToJson(_SpotMediaRanking instance) =>
    <String, dynamic>{
      'female': instance.female,
      'male': instance.male,
      'alien': instance.alien,
    };
