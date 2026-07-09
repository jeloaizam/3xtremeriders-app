// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RiderPhoto _$RiderPhotoFromJson(Map<String, dynamic> json) => _RiderPhoto(
  id: (json['id'] as num).toInt(),
  riderId: (json['rider_id'] as num).toInt(),
  rideId: (json['ride_id'] as num?)?.toInt(),
  url: json['url'] as String,
  caption: json['caption'] as String?,
  createdDate: DateTime.parse(json['created_date'] as String),
);

Map<String, dynamic> _$RiderPhotoToJson(_RiderPhoto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rider_id': instance.riderId,
      'ride_id': instance.rideId,
      'url': instance.url,
      'caption': instance.caption,
      'created_date': instance.createdDate.toIso8601String(),
    };
