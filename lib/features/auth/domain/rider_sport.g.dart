// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_sport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RiderSport _$RiderSportFromJson(Map<String, dynamic> json) => _RiderSport(
  id: (json['id'] as num).toInt(),
  riderId: (json['rider_id'] as num).toInt(),
  sportId: (json['sport_id'] as num).toInt(),
  order: (json['order'] as num).toInt(),
);

Map<String, dynamic> _$RiderSportToJson(_RiderSport instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rider_id': instance.riderId,
      'sport_id': instance.sportId,
      'order': instance.order,
    };
