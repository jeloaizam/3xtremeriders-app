// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_element.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RideElement _$RideElementFromJson(Map<String, dynamic> json) => _RideElement(
  id: (json['id'] as num).toInt(),
  rideId: (json['ride_id'] as num).toInt(),
  name: json['name'] as String,
  type: json['type'] as String?,
  brand: json['brand'] as String?,
  model: json['model'] as String?,
  description: json['description'] as String?,
  iconImage: json['icon_image'] as String?,
  createdDate: DateTime.parse(json['created_date'] as String),
);

Map<String, dynamic> _$RideElementToJson(_RideElement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ride_id': instance.rideId,
      'name': instance.name,
      'type': instance.type,
      'brand': instance.brand,
      'model': instance.model,
      'description': instance.description,
      'icon_image': instance.iconImage,
      'created_date': instance.createdDate.toIso8601String(),
    };
