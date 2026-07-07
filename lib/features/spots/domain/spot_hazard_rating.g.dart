// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_hazard_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotHazardRating _$SpotHazardRatingFromJson(Map<String, dynamic> json) =>
    _SpotHazardRating(
      id: (json['id'] as num).toInt(),
      spotId: (json['spot_id'] as num).toInt(),
      riderId: (json['rider_id'] as num).toInt(),
      crutches: (json['crutches'] as num).toInt(),
    );

Map<String, dynamic> _$SpotHazardRatingToJson(_SpotHazardRating instance) =>
    <String, dynamic>{
      'id': instance.id,
      'spot_id': instance.spotId,
      'rider_id': instance.riderId,
      'crutches': instance.crutches,
    };
