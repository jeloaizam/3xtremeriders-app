// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SpotCategory _$SpotCategoryFromJson(Map<String, dynamic> json) =>
    _SpotCategory(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SpotCategoryToJson(_SpotCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
