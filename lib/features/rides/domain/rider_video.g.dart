// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RiderVideo _$RiderVideoFromJson(Map<String, dynamic> json) => _RiderVideo(
  id: (json['id'] as num).toInt(),
  riderId: (json['rider_id'] as num).toInt(),
  rideId: (json['ride_id'] as num?)?.toInt(),
  url: json['url'] as String,
  provider: json['provider'] as String?,
  caption: json['caption'] as String?,
  createdDate: DateTime.parse(json['created_date'] as String),
);

Map<String, dynamic> _$RiderVideoToJson(_RiderVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rider_id': instance.riderId,
      'ride_id': instance.rideId,
      'url': instance.url,
      'provider': instance.provider,
      'caption': instance.caption,
      'created_date': instance.createdDate.toIso8601String(),
    };
