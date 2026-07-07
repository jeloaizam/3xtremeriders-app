// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotRating {

 int get id;@JsonKey(name: 'spot_id') int get spotId;@JsonKey(name: 'rider_id') int get riderId; int get stars;
/// Create a copy of SpotRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotRatingCopyWith<SpotRating> get copyWith => _$SpotRatingCopyWithImpl<SpotRating>(this as SpotRating, _$identity);

  /// Serializes this SpotRating to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotRating&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.stars, stars) || other.stars == stars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,riderId,stars);

@override
String toString() {
  return 'SpotRating(id: $id, spotId: $spotId, riderId: $riderId, stars: $stars)';
}


}

/// @nodoc
abstract mixin class $SpotRatingCopyWith<$Res>  {
  factory $SpotRatingCopyWith(SpotRating value, $Res Function(SpotRating) _then) = _$SpotRatingCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId,@JsonKey(name: 'rider_id') int riderId, int stars
});




}
/// @nodoc
class _$SpotRatingCopyWithImpl<$Res>
    implements $SpotRatingCopyWith<$Res> {
  _$SpotRatingCopyWithImpl(this._self, this._then);

  final SpotRating _self;
  final $Res Function(SpotRating) _then;

/// Create a copy of SpotRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? spotId = null,Object? riderId = null,Object? stars = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotRating].
extension SpotRatingPatterns on SpotRating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotRating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotRating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotRating value)  $default,){
final _that = this;
switch (_that) {
case _SpotRating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotRating value)?  $default,){
final _that = this;
switch (_that) {
case _SpotRating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId, @JsonKey(name: 'rider_id')  int riderId,  int stars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotRating() when $default != null:
return $default(_that.id,_that.spotId,_that.riderId,_that.stars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId, @JsonKey(name: 'rider_id')  int riderId,  int stars)  $default,) {final _that = this;
switch (_that) {
case _SpotRating():
return $default(_that.id,_that.spotId,_that.riderId,_that.stars);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'spot_id')  int spotId, @JsonKey(name: 'rider_id')  int riderId,  int stars)?  $default,) {final _that = this;
switch (_that) {
case _SpotRating() when $default != null:
return $default(_that.id,_that.spotId,_that.riderId,_that.stars);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotRating implements SpotRating {
  const _SpotRating({required this.id, @JsonKey(name: 'spot_id') required this.spotId, @JsonKey(name: 'rider_id') required this.riderId, required this.stars});
  factory _SpotRating.fromJson(Map<String, dynamic> json) => _$SpotRatingFromJson(json);

@override final  int id;
@override@JsonKey(name: 'spot_id') final  int spotId;
@override@JsonKey(name: 'rider_id') final  int riderId;
@override final  int stars;

/// Create a copy of SpotRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotRatingCopyWith<_SpotRating> get copyWith => __$SpotRatingCopyWithImpl<_SpotRating>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotRatingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotRating&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.stars, stars) || other.stars == stars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,riderId,stars);

@override
String toString() {
  return 'SpotRating(id: $id, spotId: $spotId, riderId: $riderId, stars: $stars)';
}


}

/// @nodoc
abstract mixin class _$SpotRatingCopyWith<$Res> implements $SpotRatingCopyWith<$Res> {
  factory _$SpotRatingCopyWith(_SpotRating value, $Res Function(_SpotRating) _then) = __$SpotRatingCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId,@JsonKey(name: 'rider_id') int riderId, int stars
});




}
/// @nodoc
class __$SpotRatingCopyWithImpl<$Res>
    implements _$SpotRatingCopyWith<$Res> {
  __$SpotRatingCopyWithImpl(this._self, this._then);

  final _SpotRating _self;
  final $Res Function(_SpotRating) _then;

/// Create a copy of SpotRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? spotId = null,Object? riderId = null,Object? stars = null,}) {
  return _then(_SpotRating(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
