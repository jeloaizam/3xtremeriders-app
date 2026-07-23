// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Spot _$SpotFromJson(Map<String, dynamic> json) => _Spot(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  difficulty: (json['difficulty'] as num?)?.toInt(),
  bestSeason: json['best_season'] as String?,
  neighborhood: json['neighborhood'] as String?,
  openHour: json['open_hour'] as String?,
  closeHour: json['close_hour'] as String?,
  createdBy: (json['created_by'] as num).toInt(),
  stateId: (json['state_id'] as num?)?.toInt(),
  ratingAvg: (json['rating_avg'] as num?)?.toDouble(),
  ratingCount: (json['rating_count'] as num).toInt(),
  hazardAvg: (json['hazard_avg'] as num?)?.toDouble(),
  hazardCount: (json['hazard_count'] as num).toInt(),
  voteCount: (json['vote_count'] as num).toInt(),
  coverPhotoUrl: json['cover_photo_url'] as String?,
  coverVideoUrl: json['cover_video_url'] as String?,
  createdDate: DateTime.parse(json['created_date'] as String),
  updatedDate: json['updated_date'] == null
      ? null
      : DateTime.parse(json['updated_date'] as String),
  sportIds:
      (json['sport_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$SpotToJson(_Spot instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'difficulty': instance.difficulty,
  'best_season': instance.bestSeason,
  'neighborhood': instance.neighborhood,
  'open_hour': instance.openHour,
  'close_hour': instance.closeHour,
  'created_by': instance.createdBy,
  'state_id': instance.stateId,
  'rating_avg': instance.ratingAvg,
  'rating_count': instance.ratingCount,
  'hazard_avg': instance.hazardAvg,
  'hazard_count': instance.hazardCount,
  'vote_count': instance.voteCount,
  'cover_photo_url': instance.coverPhotoUrl,
  'cover_video_url': instance.coverVideoUrl,
  'created_date': instance.createdDate.toIso8601String(),
  'updated_date': instance.updatedDate?.toIso8601String(),
  'sport_ids': instance.sportIds,
};
