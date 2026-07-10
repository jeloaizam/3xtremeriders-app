// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rider_sport.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RiderSport {

 int get id;@JsonKey(name: 'rider_id') int get riderId;@JsonKey(name: 'sport_id') int get sportId; int get order;
/// Create a copy of RiderSport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RiderSportCopyWith<RiderSport> get copyWith => _$RiderSportCopyWithImpl<RiderSport>(this as RiderSport, _$identity);

  /// Serializes this RiderSport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RiderSport&&(identical(other.id, id) || other.id == id)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,riderId,sportId,order);

@override
String toString() {
  return 'RiderSport(id: $id, riderId: $riderId, sportId: $sportId, order: $order)';
}


}

/// @nodoc
abstract mixin class $RiderSportCopyWith<$Res>  {
  factory $RiderSportCopyWith(RiderSport value, $Res Function(RiderSport) _then) = _$RiderSportCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'rider_id') int riderId,@JsonKey(name: 'sport_id') int sportId, int order
});




}
/// @nodoc
class _$RiderSportCopyWithImpl<$Res>
    implements $RiderSportCopyWith<$Res> {
  _$RiderSportCopyWithImpl(this._self, this._then);

  final RiderSport _self;
  final $Res Function(RiderSport) _then;

/// Create a copy of RiderSport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? riderId = null,Object? sportId = null,Object? order = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,sportId: null == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RiderSport].
extension RiderSportPatterns on RiderSport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RiderSport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RiderSport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RiderSport value)  $default,){
final _that = this;
switch (_that) {
case _RiderSport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RiderSport value)?  $default,){
final _that = this;
switch (_that) {
case _RiderSport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'sport_id')  int sportId,  int order)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RiderSport() when $default != null:
return $default(_that.id,_that.riderId,_that.sportId,_that.order);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'sport_id')  int sportId,  int order)  $default,) {final _that = this;
switch (_that) {
case _RiderSport():
return $default(_that.id,_that.riderId,_that.sportId,_that.order);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'rider_id')  int riderId, @JsonKey(name: 'sport_id')  int sportId,  int order)?  $default,) {final _that = this;
switch (_that) {
case _RiderSport() when $default != null:
return $default(_that.id,_that.riderId,_that.sportId,_that.order);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RiderSport implements RiderSport {
  const _RiderSport({required this.id, @JsonKey(name: 'rider_id') required this.riderId, @JsonKey(name: 'sport_id') required this.sportId, required this.order});
  factory _RiderSport.fromJson(Map<String, dynamic> json) => _$RiderSportFromJson(json);

@override final  int id;
@override@JsonKey(name: 'rider_id') final  int riderId;
@override@JsonKey(name: 'sport_id') final  int sportId;
@override final  int order;

/// Create a copy of RiderSport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RiderSportCopyWith<_RiderSport> get copyWith => __$RiderSportCopyWithImpl<_RiderSport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RiderSportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RiderSport&&(identical(other.id, id) || other.id == id)&&(identical(other.riderId, riderId) || other.riderId == riderId)&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.order, order) || other.order == order));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,riderId,sportId,order);

@override
String toString() {
  return 'RiderSport(id: $id, riderId: $riderId, sportId: $sportId, order: $order)';
}


}

/// @nodoc
abstract mixin class _$RiderSportCopyWith<$Res> implements $RiderSportCopyWith<$Res> {
  factory _$RiderSportCopyWith(_RiderSport value, $Res Function(_RiderSport) _then) = __$RiderSportCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'rider_id') int riderId,@JsonKey(name: 'sport_id') int sportId, int order
});




}
/// @nodoc
class __$RiderSportCopyWithImpl<$Res>
    implements _$RiderSportCopyWith<$Res> {
  __$RiderSportCopyWithImpl(this._self, this._then);

  final _RiderSport _self;
  final $Res Function(_RiderSport) _then;

/// Create a copy of RiderSport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? riderId = null,Object? sportId = null,Object? order = null,}) {
  return _then(_RiderSport(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,riderId: null == riderId ? _self.riderId : riderId // ignore: cast_nullable_to_non_nullable
as int,sportId: null == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as int,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
