// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'spot_hazard_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SpotHazardRating {

 int get id;@JsonKey(name: 'spot_id') int get spotId;@JsonKey(name: 'rider_id') int get riderId; int get crutches;
/// Create a copy of SpotHazardRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpotHazardRatingCopyWith<SpotHazardRating> get copyWith => _$SpotHazardRatingCopyWithImpl<SpotHazardRating>(this as SpotHazardRating, _$identity);

  /// Serializes this SpotHazardRating to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpotHazardRating&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.crutches, crutches) || other.crutches == crutches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,riderId,crutches);

@override
String toString() {
  return 'SpotHazardRating(id: $id, spotId: $spotId, riderId: $riderId, crutches: $crutches)';
}


}

/// @nodoc
abstract mixin class $SpotHazardRatingCopyWith<$Res>  {
  factory $SpotHazardRatingCopyWith(SpotHazardRating value, $Res Function(SpotHazardRating) _then) = _$SpotHazardRatingCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId,@JsonKey(name: 'rider_id') int riderId, int crutches
});




}
/// @nodoc
class _$SpotHazardRatingCopyWithImpl<$Res>
    implements $SpotHazardRatingCopyWith<$Res> {
  _$SpotHazardRatingCopyWithImpl(this._self, this._then);

  final SpotHazardRating _self;
  final $Res Function(SpotHazardRating) _then;

/// Create a copy of SpotHazardRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? spotId = null,Object? riderId = null,Object? crutches = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,crutches: null == crutches ? _self.crutches : crutches // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpotHazardRating].
extension SpotHazardRatingPatterns on SpotHazardRating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpotHazardRating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpotHazardRating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpotHazardRating value)  $default,){
final _that = this;
switch (_that) {
case _SpotHazardRating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpotHazardRating value)?  $default,){
final _that = this;
switch (_that) {
case _SpotHazardRating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId, @JsonKey(name: 'rider_id')  int riderId,  int crutches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpotHazardRating() when $default != null:
return $default(_that.id,_that.spotId,_that.riderId,_that.crutches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'spot_id')  int spotId, @JsonKey(name: 'rider_id')  int riderId,  int crutches)  $default,) {final _that = this;
switch (_that) {
case _SpotHazardRating():
return $default(_that.id,_that.spotId,_that.riderId,_that.crutches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'spot_id')  int spotId, @JsonKey(name: 'rider_id')  int riderId,  int crutches)?  $default,) {final _that = this;
switch (_that) {
case _SpotHazardRating() when $default != null:
return $default(_that.id,_that.spotId,_that.riderId,_that.crutches);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SpotHazardRating implements SpotHazardRating {
  const _SpotHazardRating({required this.id, @JsonKey(name: 'spot_id') required this.spotId, @JsonKey(name: 'rider_id') required this.riderId, required this.crutches});
  factory _SpotHazardRating.fromJson(Map<String, dynamic> json) => _$SpotHazardRatingFromJson(json);

@override final  int id;
@override@JsonKey(name: 'spot_id') final  int spotId;
@override@JsonKey(name: 'rider_id') final  int riderId;
@override final  int crutches;

/// Create a copy of SpotHazardRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpotHazardRatingCopyWith<_SpotHazardRating> get copyWith => __$SpotHazardRatingCopyWithImpl<_SpotHazardRating>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpotHazardRatingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpotHazardRating&&(identical(other.id, id) || other.id == id)&&(identical(other.spotId, spotId) || other.spotId == spotId)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.crutches, crutches) || other.crutches == crutches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,spotId,riderId,crutches);

@override
String toString() {
  return 'SpotHazardRating(id: $id, spotId: $spotId, riderId: $riderId, crutches: $crutches)';
}


}

/// @nodoc
abstract mixin class _$SpotHazardRatingCopyWith<$Res> implements $SpotHazardRatingCopyWith<$Res> {
  factory _$SpotHazardRatingCopyWith(_SpotHazardRating value, $Res Function(_SpotHazardRating) _then) = __$SpotHazardRatingCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'spot_id') int spotId,@JsonKey(name: 'rider_id') int riderId, int crutches
});




}
/// @nodoc
class __$SpotHazardRatingCopyWithImpl<$Res>
    implements _$SpotHazardRatingCopyWith<$Res> {
  __$SpotHazardRatingCopyWithImpl(this._self, this._then);

  final _SpotHazardRating _self;
  final $Res Function(_SpotHazardRating) _then;

/// Create a copy of SpotHazardRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? spotId = null,Object? riderId = null,Object? crutches = null,}) {
  return _then(_SpotHazardRating(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,spotId: null == spotId ? _self.spotId : spotId // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,crutches: null == crutches ? _self.crutches : crutches // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
