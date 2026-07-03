// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Rider _$RiderFromJson(Map<String, dynamic> json) => _Rider(
  id: (json['id'] as num).toInt(),
  firebaseUid: json['firebase_uid'] as String,
  roleId: (json['role_id'] as num).toInt(),
  email: json['email'] as String,
  name: json['name'] as String,
  lastName: json['last_name'] as String,
  nickname: json['nickname'] as String,
  iconImage: json['icon_image'] as String?,
  bio: json['bio'] as String?,
  city: json['city'] as String?,
  socialLinks: json['social_links'] as Map<String, dynamic>?,
  reputationPts: (json['reputation_pts'] as num).toInt(),
  createdDate: DateTime.parse(json['created_date'] as String),
  updatedDate: json['updated_date'] == null
      ? null
      : DateTime.parse(json['updated_date'] as String),
);

Map<String, dynamic> _$RiderToJson(_Rider instance) => <String, dynamic>{
  'id': instance.id,
  'firebase_uid': instance.firebaseUid,
  'role_id': instance.roleId,
  'email': instance.email,
  'name': instance.name,
  'last_name': instance.lastName,
  'nickname': instance.nickname,
  'icon_image': instance.iconImage,
  'bio': instance.bio,
  'city': instance.city,
  'social_links': instance.socialLinks,
  'reputation_pts': instance.reputationPts,
  'created_date': instance.createdDate.toIso8601String(),
  'updated_date': instance.updatedDate?.toIso8601String(),
};
