// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RideState _$RideStateFromJson(Map<String, dynamic> json) => _RideState(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String?,
);

Map<String, dynamic> _$RideStateToJson(_RideState instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
