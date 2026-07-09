// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rider_video.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RiderVideo {

 int get id;@JsonKey(name: 'rider_id') int get riderId;@JsonKey(name: 'ride_id') int? get rideId; String get url; String? get provider; String? get caption;@JsonKey(name: 'created_date') DateTime get createdDate;
/// Create a copy of RiderVideo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiderVideoCopyWith<RiderVideo> get copyWith => _$RiderVideoCopyWithImpl<RiderVideo>(this as RiderVideo, _$identity);

  /// Serializes this RiderVideo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiderVideo&&(identical(other.id, id) || other.id == id)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.url, url) || other.url == url)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,riderId,rideId,url,provider,caption,createdDate);

@override
String toString() {
  return 'RiderVideo(id: $id, riderId: $riderId, rideId: $rideId, url: $url, provider: $provider, caption: $caption, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class $RiderVideoCopyWith<$Res>  {
  factory $RiderVideoCopyWith(RiderVideo value, $Res Function(RiderVideo) _then) = _$RiderVideoCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'rider_id') int riderId,@JsonKey(name: 'ride_id') int? rideId, String url, String? provider, String? caption,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class _$RiderVideoCopyWithImpl<$Res>
    implements $RiderVideoCopyWith<$Res> {
  _$RiderVideoCopyWithImpl(this._self, this._then);

  final RiderVideo _self;
  final $Res Function(RiderVideo) _then;

/// Create a copy of RiderVideo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? riderId = null,Object? rideId = freezed,Object? url = null,Object? provider = freezed,Object? caption = freezed,Object? createdDate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,rideId: freezed == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as int?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RiderVideo].
extension RiderVideoPatterns on RiderVideo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RiderVideo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RiderVideo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RiderVideo value)  $default,){
final _that = this;
switch (_that) {
case _RiderVideo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RiderVideo value)?  $default,){
final _that = this;
switch (_that) {
case _RiderVideo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'ride_id')  int? rideId,  String url,  String? provider,  String? caption, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RiderVideo() when $default != null:
return $default(_that.id,_that.riderId,_that.rideId,_that.url,_that.provider,_that.caption,_that.createdDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'ride_id')  int? rideId,  String url,  String? provider,  String? caption, @JsonKey(name: 'created_date')  DateTime createdDate)  $default,) {final _that = this;
switch (_that) {
case _RiderVideo():
return $default(_that.id,_that.riderId,_that.rideId,_that.url,_that.provider,_that.caption,_that.createdDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'ride_id')  int? rideId,  String url,  String? provider,  String? caption, @JsonKey(name: 'created_date')  DateTime createdDate)?  $default,) {final _that = this;
switch (_that) {
case _RiderVideo() when $default != null:
return $default(_that.id,_that.riderId,_that.rideId,_that.url,_that.provider,_that.caption,_that.createdDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RiderVideo implements RiderVideo {
  const _RiderVideo({required this.id, @JsonKey(name: 'rider_id') required this.riderId, @JsonKey(name: 'ride_id') this.rideId, required this.url, this.provider, this.caption, @JsonKey(name: 'created_date') required this.createdDate});
  factory _RiderVideo.fromJson(Map<String, dynamic> json) => _$RiderVideoFromJson(json);

@override final  int id;
@override@JsonKey(name: 'rider_id') final  int riderId;
@override@JsonKey(name: 'ride_id') final  int? rideId;
@override final  String url;
@override final  String? provider;
@override final  String? caption;
@override@JsonKey(name: 'created_date') final  DateTime createdDate;

/// Create a copy of RiderVideo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiderVideoCopyWith<_RiderVideo> get copyWith => __$RiderVideoCopyWithImpl<_RiderVideo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RiderVideoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RiderVideo&&(identical(other.id, id) || other.id == id)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.rideId, rideId) || other.rideId == rideId)&&(identical(other.url, url) || other.url == url)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.createdDate, createdDate) || other.createdDate == createdDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,riderId,rideId,url,provider,caption,createdDate);

@override
String toString() {
  return 'RiderVideo(id: $id, riderId: $riderId, rideId: $rideId, url: $url, provider: $provider, caption: $caption, createdDate: $createdDate)';
}


}

/// @nodoc
abstract mixin class _$RiderVideoCopyWith<$Res> implements $RiderVideoCopyWith<$Res> {
  factory _$RiderVideoCopyWith(_RiderVideo value, $Res Function(_RiderVideo) _then) = __$RiderVideoCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'rider_id') int riderId,@JsonKey(name: 'ride_id') int? rideId, String url, String? provider, String? caption,@JsonKey(name: 'created_date') DateTime createdDate
});




}
/// @nodoc
class __$RiderVideoCopyWithImpl<$Res>
    implements _$RiderVideoCopyWith<$Res> {
  __$RiderVideoCopyWithImpl(this._self, this._then);

  final _RiderVideo _self;
  final $Res Function(_RiderVideo) _then;

/// Create a copy of RiderVideo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? riderId = null,Object? rideId = freezed,Object? url = null,Object? provider = freezed,Object? caption = freezed,Object? createdDate = null,}) {
  return _then(_RiderVideo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,rideId: freezed == rideId ? _self.rideId : rideId // ignore: cast_nullable_to_non_nullable
as int?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,createdDate: null == createdDate ? _self.createdDate : createdDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
