// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rider_photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RiderPhoto {

 int get id;@JsonKey(name: 'rider_id') int get riderId;@JsonKey(name: 'ride_id') int? get rideId; String get url; String? get caption;@JsonKey(name: 'created_date') DateTime get createdDate;
/// Create a copy of RiderPhoto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiderPhotoCopyWith<RiderPhoto> get copyWith => _$RiderPhotoCopyWithImpl<RiderPhoto>(this as RiderPhoto, _$identity);

  /// Serializes this RiderPhoto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiderPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.url, url) || other.url == url)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,riderId,rideId,url,caption,createdDate);

@override
String toString() {
  return 'RiderPhoto(id: $id, riderId: $riderId, rideId: $rideId, url: $url, caption: $caption, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $RiderPhotoCopyWith<$Res>  {
  factory $RiderPhotoCopyWith(RiderPhoto value, $Res Function(RiderPhoto) _then) = _$RiderPhotoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'rider_id') int riderId,@JsonKey(name: 'ride_id') int? rideId, String url, String? caption,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class _$RiderPhotoCopyWithImpl<$Res>
    implements $RiderPhotoCopyWith<$Res> {
  _$RiderPhotoCopyWithImpl(this._self, this._then);

  final RiderPhoto _self;
  final $Res Function(RiderPhoto) _then;

/// Create a copy of RiderPhoto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? riderId = null,Object? rideId = freezed,Object? url = null,Object? caption = freezed,Object? createdDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,rideId: freezed == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as int?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RiderPhoto].
extension RiderPhotoPatterns on RiderPhoto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RiderPhoto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RiderPhoto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RiderPhoto value)  $default,){
final _that = this;
switch (_that) {
case _RiderPhoto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RiderPhoto value)?  $default,){
final _that = this;
switch (_that) {
case _RiderPhoto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'ride_id')  int? rideId,  String url,  String? caption, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RiderPhoto() when $default != null:
return $default(_that.id,_that.riderId,_that.rideId,_that.url,_that.caption,_that.createdDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'ride_id')  int? rideId,  String url,  String? caption, @JsonKey(name: 'created_date')  DateTime createdDate)  $default,) {final _that = this;
switch (_that) {
case _RiderPhoto():
return $default(_that.id,_that.riderId,_that.rideId,_that.url,_that.caption,_that.createdDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'ride_id')  int? rideId,  String url,  String? caption, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,) {final _that = this;
switch (_that) {
case _RiderPhoto() when $default != null:
return $default(_that.id,_that.riderId,_that.rideId,_that.url,_that.caption,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RiderPhoto implements RiderPhoto {
  const _RiderPhoto({required this.id, @JsonKey(name: 'rider_id') required this.riderId, @JsonKey(name: 'ride_id') this.rideId, required this.url, this.caption, @JsonKey(name: 'created_date') required this.createdDate});
  factory _RiderPhoto.fromJson(Map<String, dynamic> json) => _$RiderPhotoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'rider_id') final  int riderId;
@override@JsonKey(name: 'ride_id') final  int? rideId;
@override final  String url;
@override final  String? caption;
@override@JsonKey(name: 'created_date') final  DateTime createdDate;

/// Create a copy of RiderPhoto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiderPhotoCopyWith<_RiderPhoto> get copyWith => __$RiderPhotoCopyWithImpl<_RiderPhoto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RiderPhotoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RiderPhoto&&(identical(other.id, id) || other.id == id)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.url, url) || other.url == url)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,riderId,rideId,url,caption,createdDate);

@override
String toString() {
  return 'RiderPhoto(id: $id, riderId: $riderId, rideId: $rideId, url: $url, caption: $caption, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$RiderPhotoCopyWith<$Res> implements $RiderPhotoCopyWith<$Res> {
  factory _$RiderPhotoCopyWith(_RiderPhoto value, $Res Function(_RiderPhoto) _then) = __$RiderPhotoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'rider_id') int riderId,@JsonKey(name: 'ride_id') int? rideId, String url, String? caption,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class __$RiderPhotoCopyWithImpl<$Res>
    implements _$RiderPhotoCopyWith<$Res> {
  __$RiderPhotoCopyWithImpl(this._self, this._then);

  final _RiderPhoto _self;
  final $Res Function(_RiderPhoto) _then;

/// Create a copy of RiderPhoto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? riderId = null,Object? rideId = freezed,Object? url = null,Object? caption = freezed,Object? createdDate = null,}) {
  return _then(_RiderPhoto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,rideId: freezed == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as int?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
