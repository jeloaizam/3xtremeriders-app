// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Rider {

 int get id;@JsonKey(name: 'firebase_uid') String get firebaseUid;@JsonKey(name: 'role_id') int get roleId; String get email; String get name;@JsonKey(name: 'last_name') String get lastName; String get nickname;@JsonKey(name: 'icon_image') String? get iconImage; String? get bio; String? get city;@JsonKey(name: 'social_links') Map<String, dynamic>? get socialLinks;@JsonKey(name: 'reputation_pts') int get reputationPts;@JsonKey(name: 'created_date') DateTime get createdDate;@JsonKey(name: 'updated_date') DateTime? get updatedDate;
/// Create a copy of Rider
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiderCopyWith<Rider> get copyWith => _$RiderCopyWithImpl<Rider>(this as Rider, _$identity);

  /// Serializes this Rider to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Rider&&(identical(other.id, id) || other.id == id)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other.socialLinks, socialLinks)&&(identical(other.reputationPts, reputationPts) || other.reputationPts == reputationPts)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firebaseUid,roleId,email,name,lastName,nickname,iconImage,bio,city,const DeepCollectionEquality().hash(socialLinks),reputationPts,createdDate,updatedDate);

@override
String toString() {
  return 'Rider(id: $id, firebaseUid: $firebaseUid, roleId: $roleId, email: $email, name: $name, lastName: $lastName, nickname: $nickname, iconImage: $iconImage, bio: $bio, city: $city, socialLinks: $socialLinks, reputationPts: $reputationPts, createdDate: $createdDate, updatedDate: $updatedDate)';
}


}

/// @nodoc
abstract mixin class $RiderCopyWith<$Res>  {
  factory $RiderCopyWith(Rider value, $Res Function(Rider) _then) = _$RiderCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'firebase_uid') String firebaseUid,@JsonKey(name: 'role_id') int roleId, String email, String name,@JsonKey(name: 'last_name') String lastName, String nickname,@JsonKey(name: 'icon_image') String? iconImage, String? bio, String? city,@JsonKey(name: 'social_links') Map<String, dynamic>? socialLinks,@JsonKey(name: 'reputation_pts') int reputationPts,@JsonKey(name: 'created_date') DateTime createdDate,@JsonKey(name: 'updated_date') DateTime? updatedDate
});




}
/// @nodoc
class _$RiderCopyWithImpl<$Res>
    implements $RiderCopyWith<$Res> {
  _$RiderCopyWithImpl(this._self, this._then);

  final Rider _self;
  final $Res Function(Rider) _then;

/// Create a copy of Rider
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firebaseUid = null,Object? roleId = null,Object? email = null,Object? name = null,Object? lastName = null,Object? nickname = null,Object? iconImage = freezed,Object? bio = freezed,Object? city = freezed,Object? socialLinks = freezed,Object? reputationPts = null,Object? createdDate = null,Object? updatedDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,socialLinks: freezed == socialLinks ? _self.socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,reputationPts: null == reputationPts ? _self.reputationPts : reputationPts // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,updatedDate: freezed == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Rider].
extension RiderPatterns on Rider {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Rider value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Rider() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Rider value)  $default,){
final _that = this;
switch (_that) {
case _Rider():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Rider value)?  $default,){
final _that = this;
switch (_that) {
case _Rider() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'firebase_uid')  String firebaseUid, @JsonKey(name: 'role_id')  int roleId,  String email,  String name, @JsonKey(name: 'last_name')  String lastName,  String nickname, @JsonKey(name: 'icon_image')  String? iconImage,  String? bio,  String? city, @JsonKey(name: 'social_links')  Map<String, dynamic>? socialLinks, @JsonKey(name: 'reputation_pts')  int reputationPts, @JsonKey(name: 'created_date')  DateTime createdDate, @JsonKey(name: 'updated_date')  DateTime? updatedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Rider() when $default != null:
return $default(_that.id,_that.firebaseUid,_that.roleId,_that.email,_that.name,_that.lastName,_that.nickname,_that.iconImage,_that.bio,_that.city,_that.socialLinks,_that.reputationPts,_that.createdDate,_that.updatedDate);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'firebase_uid')  String firebaseUid, @JsonKey(name: 'role_id')  int roleId,  String email,  String name, @JsonKey(name: 'last_name')  String lastName,  String nickname, @JsonKey(name: 'icon_image')  String? iconImage,  String? bio,  String? city, @JsonKey(name: 'social_links')  Map<String, dynamic>? socialLinks, @JsonKey(name: 'reputation_pts')  int reputationPts, @JsonKey(name: 'created_date')  DateTime createdDate, @JsonKey(name: 'updated_date')  DateTime? updatedDate)  $default,) {final _that = this;
switch (_that) {
case _Rider():
return $default(_that.id,_that.firebaseUid,_that.roleId,_that.email,_that.name,_that.lastName,_that.nickname,_that.iconImage,_that.bio,_that.city,_that.socialLinks,_that.reputationPts,_that.createdDate,_that.updatedDate);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'firebase_uid')  String firebaseUid, @JsonKey(name: 'role_id')  int roleId,  String email,  String name, @JsonKey(name: 'last_name')  String lastName,  String nickname, @JsonKey(name: 'icon_image')  String? iconImage,  String? bio,  String? city, @JsonKey(name: 'social_links')  Map<String, dynamic>? socialLinks, @JsonKey(name: 'reputation_pts')  int reputationPts, @JsonKey(name: 'created_date')  DateTime createdDate, @JsonKey(name: 'updated_date')  DateTime? updatedDate)?  $default,) {final _that = this;
switch (_that) {
case _Rider() when $default != null:
return $default(_that.id,_that.firebaseUid,_that.roleId,_that.email,_that.name,_that.lastName,_that.nickname,_that.iconImage,_that.bio,_that.city,_that.socialLinks,_that.reputationPts,_that.createdDate,_that.updatedDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Rider implements Rider {
  const _Rider({required this.id, @JsonKey(name: 'firebase_uid') required this.firebaseUid, @JsonKey(name: 'role_id') required this.roleId, required this.email, required this.name, @JsonKey(name: 'last_name') required this.lastName, required this.nickname, @JsonKey(name: 'icon_image') this.iconImage, this.bio, this.city, @JsonKey(name: 'social_links') final  Map<String, dynamic>? socialLinks, @JsonKey(name: 'reputation_pts') required this.reputationPts, @JsonKey(name: 'created_date') required this.createdDate, @JsonKey(name: 'updated_date') this.updatedDate}): _socialLinks = socialLinks;
  factory _Rider.fromJson(Map<String, dynamic> json) => _$RiderFromJson(json);

@override final  int id;
@override@JsonKey(name: 'firebase_uid') final  String firebaseUid;
@override@JsonKey(name: 'role_id') final  int roleId;
@override final  String email;
@override final  String name;
@override@JsonKey(name: 'last_name') final  String lastName;
@override final  String nickname;
@override@JsonKey(name: 'icon_image') final  String? iconImage;
@override final  String? bio;
@override final  String? city;
 final  Map<String, dynamic>? _socialLinks;
@override@JsonKey(name: 'social_links') Map<String, dynamic>? get socialLinks {
  final value = _socialLinks;
  if (value == null) return null;
  if (_socialLinks is EqualUnmodifiableMapView) return _socialLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'reputation_pts') final  int reputationPts;
@override@JsonKey(name: 'created_date') final  DateTime createdDate;
@override@JsonKey(name: 'updated_date') final  DateTime? updatedDate;

/// Create a copy of Rider
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiderCopyWith<_Rider> get copyWith => __$RiderCopyWithImpl<_Rider>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RiderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rider&&(identical(other.id, id) || other.id == id)&&(identical(other.firebaseUid, firebaseUid) || other.firebaseUid == firebaseUid)&&(identical(other.roleId, roleId) || other.roleId == roleId)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.nickname, nickname) || other.nickname == nickname)&&(identical(other.iconImage, iconImage) || other.iconImage == iconImage)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other._socialLinks, _socialLinks)&&(identical(other.reputationPts, reputationPts) || other.reputationPts == reputationPts)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate)&&(identical(other.updatedDate, updatedDate) || other.updatedDate == updatedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firebaseUid,roleId,email,name,lastName,nickname,iconImage,bio,city,const DeepCollectionEquality().hash(_socialLinks),reputationPts,createdDate,updatedDate);

@override
String toString() {
  return 'Rider(id: $id, firebaseUid: $firebaseUid, roleId: $roleId, email: $email, name: $name, lastName: $lastName, nickname: $nickname, iconImage: $iconImage, bio: $bio, city: $city, socialLinks: $socialLinks, reputationPts: $reputationPts, createdDate: $createdDate, updatedDate: $updatedDate)';
}


}

/// @nodoc
abstract mixin class _$RiderCopyWith<$Res> implements $RiderCopyWith<$Res> {
  factory _$RiderCopyWith(_Rider value, $Res Function(_Rider) _then) = __$RiderCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'firebase_uid') String firebaseUid,@JsonKey(name: 'role_id') int roleId, String email, String name,@JsonKey(name: 'last_name') String lastName, String nickname,@JsonKey(name: 'icon_image') String? iconImage, String? bio, String? city,@JsonKey(name: 'social_links') Map<String, dynamic>? socialLinks,@JsonKey(name: 'reputation_pts') int reputationPts,@JsonKey(name: 'created_date') DateTime createdDate,@JsonKey(name: 'updated_date') DateTime? updatedDate
});




}
/// @nodoc
class __$RiderCopyWithImpl<$Res>
    implements _$RiderCopyWith<$Res> {
  __$RiderCopyWithImpl(this._self, this._then);

  final _Rider _self;
  final $Res Function(_Rider) _then;

/// Create a copy of Rider
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firebaseUid = null,Object? roleId = null,Object? email = null,Object? name = null,Object? lastName = null,Object? nickname = null,Object? iconImage = freezed,Object? bio = freezed,Object? city = freezed,Object? socialLinks = freezed,Object? reputationPts = null,Object? createdDate = null,Object? updatedDate = freezed,}) {
  return _then(_Rider(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,firebaseUid: null == firebaseUid ? _self.firebaseUid : firebaseUid // ignore: cast_nullable_to_non_nullable
as String,roleId: null == roleId ? _self.roleId : roleId // ignore: cast_nullable_to_non_nullable
as int,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,nickname: null == nickname ? _self.nickname : nickname // ignore: cast_nullable_to_non_nullable
as String,iconImage: freezed == iconImage ? _self.iconImage : iconImage // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,socialLinks: freezed == socialLinks ? _self._socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,reputationPts: null == reputationPts ? _self.reputationPts : reputationPts // ignore: cast_nullable_to_non_nullable
as int,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,updatedDate: freezed == updatedDate ? _self.updatedDate : updatedDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
