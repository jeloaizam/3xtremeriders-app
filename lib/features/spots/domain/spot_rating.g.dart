// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotRating _$SpotRatingFromJson(Map<String, dynamic> json) => _SpotRating(
  id: (json['id'] as num).toInt(),
  spotId: (json['spot_id'] as num).toInt(),
  riderId: (json['rider_id'] as num).toInt(),
  stars: (json['stars'] as num).toInt(),
);

Map<String, dynamic> _$SpotRatingToJson(_SpotRating instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spot_id': instance.spotId,
      'rider_id': instance.riderId,
      'stars': instance.stars,
    };
